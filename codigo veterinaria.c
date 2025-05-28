#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include </usr/include/mysql/mysql.h>

typedef struct {
    int id;
    char nombre[100];
    char num_telefono[20];
    char especialidad[100];
} Veterinario;

typedef struct {
    int id;
    char nombre[100];
} Area;

MYSQL *con;

void finish_with_error() {
    fprintf(stderr, "%s\n", mysql_error(con));
    mysql_close(con);
    exit(1);
}

void conectar() {
    con = mysql_init(NULL);
    if (con == NULL) {
        fprintf(stderr, "mysql_init() falló\n");
        exit(1);
    }

    if (mysql_real_connect(con, "localhost", "root", "C0ntr@$3nia", "Veterinaria",
        8889, "/var/run/mysqld/mysqld.sock", 0) == NULL) {
        finish_with_error();
    }
}

int crear_veterinario(const Veterinario *vet) {
    char query[512];
    snprintf(query, sizeof(query),
        "INSERT INTO veterinario(nombre, num_telefono, especialidad) VALUES('%s', '%s', '%s')",
        vet->nombre, vet->num_telefono, vet->especialidad);

    if (mysql_query(con, query)) {
        finish_with_error();
    }

    return mysql_insert_id(con);
}

int crear_area(const char *nombre) {
    char query[256];
    snprintf(query, sizeof(query),
        "INSERT INTO area(nombre) VALUES('%s')", nombre);

    if (mysql_query(con, query)) {
        finish_with_error();
    }

    return mysql_insert_id(con);
}

void asignar_veterinario_a_area(int vet_id, int area_id) {
    char query[256];
    snprintf(query, sizeof(query),
        "INSERT INTO veterinario_area(id_veterinario, id_area) VALUES(%d, %d)",
        vet_id, area_id);

    if (mysql_query(con, query)) {
        finish_with_error();
    }
}

void leer_veterinarios_y_areas() {
    const char *query =
        "SELECT v.id_veterinario, v.nombre, v.num_telefono, v.especialidad, a.nombre "
        "FROM veterinario v "
        "JOIN veterinario_area va ON v.id_veterinario = va.id_veterinario "
        "JOIN area a ON a.id_area = va.id_area "
        "ORDER BY v.id_veterinario";

    if (mysql_query(con, query)) {
        finish_with_error();
    }

    MYSQL_RES *result = mysql_store_result(con);
    if (result == NULL) {
        finish_with_error();
    }

    MYSQL_ROW row;
    int last_vet_id = -1;

    while ((row = mysql_fetch_row(result))) {
        int vet_id = atoi(row[0]);
        const char *nombre = row[1];
        const char *telefono = row[2];
        const char *especialidad = row[3];
        const char *area_nombre = row[4];

        if (vet_id != last_vet_id) {
            printf("\nVeterinario ID: %d, Nombre: %s, Teléfono: %s, Especialidad: %s\n",
                   vet_id, nombre, telefono, especialidad);
            printf("Áreas:\n");
            last_vet_id = vet_id;
        }

        printf(" - %s\n", area_nombre);
    }

    mysql_free_result(result);
}

void leer_areas_y_veterinarios() {
    const char *query =
        "SELECT a.id_area, a.nombre, v.nombre, v.especialidad "
        "FROM area a "
        "JOIN veterinario_area va ON a.id_area = va.id_area "
        "JOIN veterinario v ON v.id_veterinario = va.id_veterinario "
        "ORDER BY a.id_area";

    if (mysql_query(con, query)) {
        finish_with_error();
    }

    MYSQL_RES *result = mysql_store_result(con);
    if (result == NULL) {
        finish_with_error();
    }

    MYSQL_ROW row;
    int last_area_id = -1;

    while ((row = mysql_fetch_row(result))) {
        int area_id = atoi(row[0]);
        const char *area_nombre = row[1];
        const char *vet_nombre = row[2];
        const char *vet_especialidad = row[3];

        if (area_id != last_area_id) {
            printf("\nÁrea ID: %d, Nombre: %s\n", area_id, area_nombre);
            printf("Veterinarios:\n");
            last_area_id = area_id;
        }

        printf(" - %s (Especialidad: %s)\n", vet_nombre, vet_especialidad);
    }

    mysql_free_result(result);
}

int main() {
    conectar();

    Veterinario vet = {0, "Dra. López", "555-6789", "Cirugía"};
    int vet_id = crear_veterinario(&vet);

    int area1 = crear_area("Quirófano");
    int area2 = crear_area("Consultorio General");

    asignar_veterinario_a_area(vet_id, area1);
    asignar_veterinario_a_area(vet_id, area2);

    printf("\n== Veterinarios con sus áreas ==\n");
    leer_veterinarios_y_areas();

    printf("\n== Áreas con sus veterinarios ==\n");
    leer_areas_y_veterinarios();

    mysql_close(con);
    return 0;
}

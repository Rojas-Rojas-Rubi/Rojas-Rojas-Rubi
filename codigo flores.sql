#include <stdio.h>
#include <stdlib.h>
#include </usr/include/mysql/mysql.h>

typedef struct {
    int id;
    char nombre[100];
    char color[50];
    int cantidad; // cantidad disponible
} Flor;

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

    if (mysql_real_connect(con, "localhost", "root", "C0ntr@$3nia", "Flores",
        0, "/var/run/mysqld/mysqld.sock", 0) == NULL) {
        finish_with_error();
    }
}

void crear_flor(const Flor *flor) {
    char query[512];
    snprintf(query, sizeof(query),
        "INSERT INTO flores(nombre, color, cantidad) VALUES('%s', '%s', %d)",
        flor->nombre, flor->color, flor->cantidad);
    if (mysql_query(con, query)) {
        finish_with_error();
    } else {
        printf("Flor creada.\n");
    }
}

void leer_flores() {
    if (mysql_query(con, "SELECT id, nombre, color, cantidad FROM flores")) {
        finish_with_error();
    }

    MYSQL_RES *result = mysql_store_result(con);
    if (result == NULL) {
        finish_with_error();
    }

    MYSQL_ROW row;

    while ((row = mysql_fetch_row(result))) {
        Flor flor;
        flor.id = atoi(row[0]);
        snprintf(flor.nombre, sizeof(flor.nombre), "%s", row[1]);
        snprintf(flor.color, sizeof(flor.color), "%s", row[2]);
        flor.cantidad = atoi(row[3]);

        printf("ID: %d, Nombre: %s, Color: %s, Cantidad: %d\n", flor.id, flor.nombre, flor.color, flor.cantidad);
    }

    mysql_free_result(result);
}

void actualizar_flor(const Flor *flor) {
    char query[512];
    snprintf(query, sizeof(query),
             "UPDATE flores SET nombre='%s', color='%s', cantidad=%d WHERE id=%d",
             flor->nombre, flor->color, flor->cantidad, flor->id);
    if (mysql_query(con, query)) {
        finish_with_error();
    } else {
        printf("Flor actualizada.\n");
    }
}

void eliminar_flor(int id) {
    char query[128];
    snprintf(query, sizeof(query), "DELETE FROM flores WHERE id=%d", id);
    if (mysql_query(con, query)) {
        finish_with_error();
    } else {
        printf("Flor eliminada.\n");
    }
}

int main() {
    conectar();

    Flor rosa = {0, "Rosa", "Rojo", 50};
    crear_flor(&rosa);

    leer_flores();

    rosa.id = 1;
    snprintf(rosa.nombre, sizeof(rosa.nombre), "Rosa Silvestre");
    snprintf(rosa.color, sizeof(rosa.color), "Rosa");
    rosa.cantidad = 60;
    actualizar_flor(&rosa);

    leer_flores();

    eliminar_flor(rosa.id);

    mysql_close(con);
    return 0;
}

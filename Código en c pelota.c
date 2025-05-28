#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include </usr/include/mysql/mysql.h>

typedef struct {
    int id;
    char nombre[100];
} Marca;

typedef struct {
    int id;
    char nombre[100];
    char telefono[20];
} Proveedor;

typedef struct {
    int id;
    char nombre[100];
} Categoria;

typedef struct {
    int id;
    char nombre[100];
    int marca_id;
    int proveedor_id;
    int categoria_id;
    double precio;
    int cantidad;
} Valon;

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

    if (mysql_real_connect(con, "localhost", "root", "C0ntr@$3nia", "Pelotas",
        8889, "/var/run/mysqld/mysqld.sock", 0) == NULL) {
        finish_with_error();
    }
}

// Crear marca
int crear_marca(const Marca *marca) {
    char query[256];
    snprintf(query, sizeof(query), "INSERT INTO marcas(nombre) VALUES('%s')", marca->nombre);

    if (mysql_query(con, query)) finish_with_error();

    return mysql_insert_id(con);
}

// Crear proveedor
int crear_proveedor(const Proveedor *prov) {
    char query[256];
    snprintf(query, sizeof(query),
        "INSERT INTO proveedores(nombre, telefono) VALUES('%s', '%s')",
        prov->nombre, prov->telefono);

    if (mysql_query(con, query)) finish_with_error();

    return mysql_insert_id(con);
}

// Crear categoria
int crear_categoria(const Categoria *cat) {
    char query[256];
    snprintf(query, sizeof(query), "INSERT INTO categorias(nombre) VALUES('%s')", cat->nombre);

    if (mysql_query(con, query)) finish_with_error();

    return mysql_insert_id(con);
}

// Crear valon
int crear_valon(const Valon *v) {
    char query[512];
    snprintf(query, sizeof(query),
        "INSERT INTO valones(nombre, marca_id, proveedor_id, categoria_id, precio, cantidad) "
        "VALUES('%s', %d, %d, %d, %.2f, %d)",
        v->nombre, v->marca_id, v->proveedor_id, v->categoria_id, v->precio, v->cantidad);

    if (mysql_query(con, query)) finish_with_error();

    return mysql_insert_id(con);
}

// Leer valones con detalles
void leer_valones() {
    const char *query =
        "SELECT v.id, v.nombre, m.nombre, p.nombre, c.nombre, v.precio, v.cantidad, p.telefono "
        "FROM valones v "
        "LEFT JOIN marcas m ON v.marca_id = m.id "
        "LEFT JOIN proveedores p ON v.proveedor_id = p.id "
        "LEFT JOIN categorias c ON v.categoria_id = c.id "
        "ORDER BY v.id";

    if (mysql_query(con, query)) finish_with_error();

    MYSQL_RES *result = mysql_store_result(con);
    if (!result) finish_with_error();

    MYSQL_ROW row;

    while ((row = mysql_fetch_row(result))) {
        printf("\nValon ID: %s\n", row[0]);
        printf("Nombre: %s\n", row[1]);
        printf("Marca: %s\n", row[2] ? row[2] : "N/A");
        printf("Proveedor: %s (Tel: %s)\n", row[3] ? row[3] : "N/A", row[7] ? row[7] : "N/A");
        printf("Categoría: %s\n", row[4] ? row[4] : "N/A");
        printf("Precio: %s\n", row[5]);
        printf("Cantidad: %s\n", row[6]);
    }

    mysql_free_result(result);
}

// Eliminar valon
void eliminar_valon(int id) {
    char query[128];
    snprintf(query, sizeof(query), "DELETE FROM valones WHERE id=%d", id);

    if (mysql_query(con, query)) finish_with_error();
    else printf("Valon eliminado.\n");
}

int main() {
    conectar();

    Marca marca = {0, "MarcaX"};
    int marca_id = crear_marca(&marca);

    Proveedor prov = {0, "ProveedorUno", "555-1234567"};
    int prov_id = crear_proveedor(&prov);

    Categoria cat = {0, "Categoría A"};
    int cat_id = crear_categoria(&cat);

    Valon valon = {0, "Valon Alfa", marca_id, prov_id, cat_id, 15.75, 200};
    int valon_id = crear_valon(&valon);

    leer_valones();

    eliminar_valon(valon_id);

    mysql_close(con);
    return 0;
}

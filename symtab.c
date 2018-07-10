#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct var {
    char *name;
    double *value;
    struct var *next;
} var;

var *head = NULL;

var* searchNode(char *name) {
    var *i = head;

    while (i != NULL && strcmp(i->name, name) != 0) i = i->next;
    if (i != NULL) return i;
    else return NULL;
}

void updateSymTab(char *name, double *v) {
    var *node = searchNode(name);
    double *value = (double *) malloc(sizeof(*v));
    *value = *v;
    if (node == NULL) {
        var *newNode;
        newNode = malloc(sizeof(var));
        newNode->name = strdup(name);
        newNode->value = value;
        newNode->next = head;
        head = newNode;
    } else node->value = value;  
}

double* searchVarVal(char *name) {
    var *i = head;
    while (i != NULL && strcmp(i->name, name) != 0) i = i->next;
    if (i != NULL) return i->value;
    else return NULL;
}

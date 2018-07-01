#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct var 
{
    char *name;
    double *value;
    struct var *next;
} var;


var *head = NULL;


double* searchVarVal(char *name) 
{
    var *current = head;

    while (current != NULL && strcmp(current->name, name) != 0) {
        current = current->next;
    }

    if (current != NULL)
        return current->value;
    else 
        return NULL;
}


var* searchNode(char *name) 
{
    var *current = head;

    while (current != NULL && strcmp(head->name, name) != 0) {
        current = current->next;
    }

    if (current != NULL)
        return current;
    else 
        return NULL;
}


void updateSymTab(char *name, double *value) 
{
    var *n = searchNode(name);
    if (n == NULL) {
        var *new_node;
    new_node = malloc(sizeof(var));

    new_node->name = strdup(name);
    new_node->value = value;
    new_node->next = head;
    head = new_node;
    } else {
        n->value = value;
    }    
}


void print_list() {
    var *current = head;

    printf("\t Printing...\n");
    while (current != NULL) {
        printf("\t%s = %f\n", current->name, *current->value);
        current = current->next;
    }
}

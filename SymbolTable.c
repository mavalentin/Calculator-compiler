#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct variable 
{
    char* name;
    char* value;
    struct variable * next;
} variable_t;


variable_t * head = NULL;


char* searchNodeValue(char* name) 
{
    variable_t * current = head;

    while (current != NULL && strcmp(current->name, name) != 0) {
        current = current->next;
    }

    if (current != NULL)
        return current->value;
    else 
        return NULL;
}


variable_t* searchNode(char* name) 
{
    variable_t * current = head;

    while (current != NULL && strcmp(head->name, name) != 0) {
        current = current->next;
    }

    if (current != NULL)
        return current;
    else 
        return NULL;
}


void push(char* name, char* value) 
{
    variable_t * new_node;
    new_node = malloc(sizeof(variable_t));

    new_node->name = strdup(name);
    new_node->value = strdup(value);
    new_node->next = head;
    head = new_node;
}


void pushOrSubstitute(char* name, char* value) 
{
    variable_t* n = searchNode(name);
    if (n == NULL) {
        variable_t * new_node;
    new_node = malloc(sizeof(variable_t));

    new_node->name = strdup(name);
    new_node->value = strdup(value);
    new_node->next = head;
    head = new_node;
    } else {
        n->value = value;
    }    
}


void print_list() {
    variable_t * current = head;

    printf("\t Printing...\n");
    while (current != NULL) {
        printf("\t%s = %s\n", current->name, current->value);
        current = current->next;
    }
}
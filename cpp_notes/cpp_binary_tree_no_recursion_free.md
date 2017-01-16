~~~c++
struct node_t
{
    int data;
    struct node_t * left;
    struct node_t * right;
};

int add_node(struct node_t * root, int data1,int data2)
{
    
    root->left = new struct node_t;
    root->left->data = data1;
    root->left->left = NULL;
    root->left->right = NULL;


    root->right = new struct node_t;
    root->right->data = data2;
    root->right->left = NULL;
    root->right->right = NULL;

    return 0;
}


void free_tree(struct node_t * t)
{
    struct node_t * bl;
    for(bl = t; bl != NULL && bl->left != NULL; bl = bl->left);

    for (;t != NULL;)
    {
        for(bl->left = t->right ; bl!= NULL && bl->left != NULL; bl=bl->left);

        struct node_t * old = t; 
        t = t->left;
        printf("%d ",old->data);
        delete old;
    }
}

int main(int argc, const TCHAR ** argv)
{

    node_t * root = new struct node_t;
    root->data = 1;
    
    add_node(root,2,3);
    add_node(root->left,4,5);
    add_node(root->right,6,7);
    
//          1
//        /   \
//       2     3
//     /   \  /  \
//    4     5 6   7

    // free 1 2 4 3 6 5 7
    free_tree(root);

    return 0;
}
~~~
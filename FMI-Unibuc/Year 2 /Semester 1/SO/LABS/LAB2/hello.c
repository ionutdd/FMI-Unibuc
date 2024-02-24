#include <unistd.h>
#include <errno.h>

int main()
{
    const char message[] = "Hello World!\n";
    ssize_t nwritten = write(1, message, sizeof(message) - 1);

    //verificam erorile si le afisam
    if (nwritten < 0)
        return errno;
    
    return 0;
}
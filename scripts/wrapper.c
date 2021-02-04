#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <unistd.h>

#define assert_or(cond, err) do { if (!(cond)) { perror(err); exit(1); } } while (0)

extern const char _binary_prog_start[];
extern const char _binary_prog_end[];

static char TMP[] = ".wrapper_XXXXXX";

int main(int argc, char *argv[]) {
    const size_t prog_size = (void *) &_binary_prog_end - (void *) &_binary_prog_start;

    int tmp = mkstemp(TMP);
    assert_or(tmp != -1, "mkstemp");
    assert_or(write(tmp, _binary_prog_start, prog_size) == prog_size, "write");
    close(tmp);

    pid_t python = fork();
    assert_or(python != -1, "fork");
    if (python == 0) {
        char **pyargs = malloc(sizeof(char *) * (argc + 2));
        pyargs[0] = argv[0];
        pyargs[1] = TMP;
        pyargs[argc + 1] = NULL;
        for (int i = 1; i < argc; i++) {
            pyargs[i + 1] = argv[i];
        }
        assert_or(setreuid(0, 0) != -1, "setreuid");
        return execvp("python", (char * const *) pyargs);
    } else {
        int ret;
        assert_or(waitpid(python, &ret, 0) == python, "waitpid");
        assert_or(unlink(TMP) != -1, "unlink");
        return ret;
    }
}

#include <chrono>
#include <cstdio>
#include <unistd.h>

int tests = 0, fails = 0;

static void report(bool ok, const char* msg)
{
    ++tests;
    fails += !ok;
    printf("%s: %s\n", (ok ? "PASS" : "FAIL"), msg);
}

int main(int ac, char** av)
{
    printf("starting sleep test\n");
    auto start = std::chrono::system_clock::now();
    int r = sleep(2);
    auto end = std::chrono::system_clock::now();
    double sec = ((std::chrono::duration<double>)(end - start)).count();
    report(r == 0, "sleep 2 seconds finished successfully");
    report(sec >= 1.5 && sec < 2.5, "and slept for roughly 2 seconds");

    printf("SUMMARY: %d tests, %d failures\n", tests, fails);
}

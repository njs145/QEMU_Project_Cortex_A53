int main(void) {
    volatile int counter = 0;
    while (1) {
        counter++;  // GDB로 추적 가능
    }
    return 0;
}
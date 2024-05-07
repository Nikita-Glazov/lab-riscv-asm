#include <stdio.h>
#include <limits.h>

int findMinSumRow(int matrix[5][3]) {
    int minSum = INT_MAX; // Инициализация минимальной суммы значением, равным максимальному целому числу
    int minSumRow = -1; // Инициализация индекса строки с минимальной суммой

    for (int i = 0; i < 5; i++) {
        int rowSum = 0;
        for (int j = 0; j < 3; j++) {
            rowSum += matrix[i][j]; // Вычисление суммы элементов в текущей строке
        }
        if (rowSum < minSum) {
            minSum = rowSum; // Обновление минимальной суммы, если текущая сумма меньше минимальной
            minSumRow = i; // Обновление индекса строки с минимальной суммой
        }
    }

    return minSumRow; // Возвращение индекса строки с минимальной суммой
}

int main() {
    int matrix[5][3] = {
        {2, 3, 5},
        {1, 4, 9},
        {7, 2, 3},
        {6, 8, 2},
        {4, 5, 6}
    };

    int minSumRow = findMinSumRow(matrix);

    printf("Index of the row with the minimum sum: %d\n", minSumRow);

    return 0;
}

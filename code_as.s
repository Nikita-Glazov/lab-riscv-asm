.data               # определяем исходные данные
matrix:
    .word 1, 4, 9
    .word 7, 2, 3
    .word 2, 3, 5
    .word 6, 8, 2
    .word 4, 5, 6
minSum:
    .word 0x7FFFFFFF
minSumRow:
    .word -1

.text               # исполняемый код программы
.globl main
main:
    la a0, matrix      # загружает адрес матрицы в регистр a0
    jal findMinSumRow  # "jump and link" (переход и сохранение), чтобы после выполнения вернуться в эту точку

# Подготовка к выводу значения minSumRow
    mv a1, a0        # Сохраняем minSumRow в a1 для вывода
    li a0, 1         # Системный вызов для вывода целого числа
    ecall            # Выполняем системный вызов

# Завершаем программу
    li a0, 0         # Код возврата
    ecall            # Вызов exit

findMinSumRow:
    li t1, 5           # количество строк матрицы (N)
    li t2, 3           # количество столбцов матрицы (M)
    li t3, 0x7FFFFFFF  # устанавливаем значение INT_MAX
    li t4, -1          # инициализирует переменную minSumRow
    li t5, 0           # устанавливает индекс строки i (счетчик строк)

loop_i:
    li t6, 0           # rowSum = 0
    li s2, 0           # индекс столбца j = 0

loop_j:
    lw s1, 0(a0)       # загружаем значение из текущей ячейки матрицы в s1 (matrix[i][j])
    add t6, t6, s1     # прибавляем значение из матрицы к rowSum (rowSum += matrix[i][j])
    addi a0, a0, 4     # переходим к следующему элементу
    addi s2, s2, 1     # увеличиваем индекс столбца j
    blt s2, t2, loop_j # условие продолжения цикла: если j < M

    addi a0, a0, -12   # возвращаемся к началу текущей строки
    addi a0, a0, 4     # переходим к началу следующей строки

    # Если rowSum меньше текущего minSum, обновляем minSum и minSumRow
    blt t6, t3, updateMin
    j next_i

updateMin:
    mv t3, t6          # minSum = rowSum
    mv t4, t5          # minSumRow = i

next_i:
    addi t5, t5, 1     # увеличиваем счетчик строк i
    blt t5, t1, loop_i # условие продолжения цикла: если i < N

    mv a0, t4          # возвращаем индекс строки с минимальной суммой
    ret                # возвращение из функции

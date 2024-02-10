program lab2;

uses crt;//модуль,который подключает интерфейс программы

const
  nmax = 10;

type
  mas = array[1..nmax] of integer;
  matr = array[1..nmax, 1..nmax] of integer;//максимальный размер массива и матрицы

procedure Task;//процедура вывода задания на экран
begin
  writeln('Лабораторная работа №2');
  writeln('Гижевская Валерия');
  writeln('Группа 6113-020302D');
  writeln('Вариант 10' + #13#10);
  writeln('1)Получить одномерный массив, состоящий из сумм элементов соответствующих столбцов матрицы');
  writeln('2)В полученном векторе решить задачу поиска количества отрицательных элементов');
  writeln('3)Отсортировать в матрице строки по возрастанию значений элементов в столбце,с номером,заданным пользователем' + #13#10);
end;

procedure InputMatr(var a: matr; n, m: integer);//процедура ввода матрица, заносит матрицу в программу
var
  i, j: integer;
begin
  for i := 1 to n do 
  begin
    for j := 1 to m do 
    begin
      gotoxy(5 * j, 16 + 2 * i);//перевод курсора
      read(a[i, j]);//ввод элемента
    end;   
  end;
end;

procedure MatrToMas(var a: matr; n, m: integer; var b: mas);//процедура создания массива из матрицы
var
  i, j: integer;
begin
  for j := 1 to m do 
  begin
    b[j] := 0;
    for i := 1 to n do b[j] := b[j] + a[i, j];//ищем сумму элементов текущего столбика
  end;
end;

procedure OutputMas(var b: mas; m, n: integer);
var
  j: integer;
begin
  for j := 1 to m do 
  begin
    gotoxy(5 * j, 20 + 2 * n);//Первый элемент матрицы находится на координатах (5,12); макс координата по х=5*m; макс координата по у=10+2*n
    write(b[j]); 
  end; 
end;

function NumNeg(var b: mas; m: integer): integer;
var
  j, num: integer;
begin
  num := 0;
  for j := 1 to m do
  begin
    if b[j] < 0 then num := num + 1;
  end;
  NumNeg := num;
end;

procedure QuickSort(var a: matr; m, column, top, bottom: integer);
var{m - столбцы, column - столбец юзера, top - самая верхняя строка, bottom - самая нижняя строка}
  i, j, keyElem, temp: integer;
begin
  i := top;
  j := bottom;
  keyElem := a[(i + j) div 2, column];
  repeat
    while (a[i, column] < keyElem) do inc(i);
    while (a[j, column] > keyElem) do dec(j);
    if (i <= j) then begin
      for var k := 1 to m do 
      begin
        temp := a[i, k];
        a[i, k] := a[j, k];
        a[j, k] := temp;
      end;
      inc(i);
      dec(j);
    end;
  until (i > j);
  if (i < bottom) then QuickSort(a, m, column, i, bottom);
  if (j > top) then QuickSort(a, m, column, top, j);
end;

procedure OutputMatr(var a: matr; n, m: integer);//процедура вывода матрицы
var
  i, j: integer;
begin
  for i := 1 to n do 
  begin
    for j := 1 to m do 
    begin
      gotoxy(12 + 5 * m + 5 * j, 16 + 2 * i);//перевод курсора
      write(a[i, j]);//ввод элемента
    end;   
  end;
end;

var
  n, m, column, top, bottom: integer;
  a: matr;//объявление переменных
  b: mas;

begin
  Task();
  Writeln('Начало программы' + #13#10);
  Write('Введите количество строк: ');
  Readln(n);
  Write(#13#10 + 'Введите количество столбцов: ');
  Readln(m);
  Writeln(#13#10 + 'Введите матрицу');
  InputMatr(a, n, m);//вызываю ранее созданную процедуру 
  MatrToMas(a, n, m, b);
  gotoxy(1, 18 + 2 * n);
  writeln('Полученный массив:');
  OutputMas(b, m, n);
  gotoxy(1, 22 + 2 * n);
  Writeln('Количество отрицательных элементов: ', NumNeg(b, m));
  Write(#13#10+'Введите номер столбца: ');
  Readln(column);
  gotoxy(15 + 5 * m, 16);
  writeln('Отсортированная матрица:');
  QuickSort(a, m, column, 1, n);
  OutputMatr(a, n, m);
  Readln();
end.




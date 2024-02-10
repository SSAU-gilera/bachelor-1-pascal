uses crt;

type
  TPas = record
    name: string[15];
    weight: integer;
    conduct: string[13];
  end;
  TFPas = file of TPas;

procedure Task();
begin
  writeln('Лабораторная работа №4');
  writeln('Гижевская Валерия');
  writeln('Группа: 6113-020302D');
  writeln('Задание:');
  writeln('В файле содержатся сведения о веществах: название вещества, удельный вес, проводимость (проводник, полупроводник, диэлектрик).');
  writeln('Создать новый файл, содержащий информацию о всех веществах, удельный вес которых не превышает заданного.');
  writeln('Выдать в текстовый файл удельные веса и названия всех полупроводников.');
  writeln('==========================================================================================================');
end;

procedure InputRec(var mat: TPas);
var
  i: integer;
begin
  writeln('Введите информацию о веществе: ');
  write('Введите название: ');
  readln(mat.name);
  write('Введите удельный вес: ');
  readln(mat.weight);
  write('Введите проводимость(проводник, полупроводник, диэлектрик): ');
  readln(mat.conduct);
end;

procedure AddRec(var f: TFPas; mat: TPas);
begin
  reset(f);
  seek(f, filesize(f));
  write(f, mat);
  close(f);
end;

procedure DelRec(var f: TFPas; n: integer);
var
  mat: TPas;
begin
  if n <> filesize(f) - 1 then begin
    seek(f, filesize(f) - 1);
    read(f, mat);
    seek(f, n);
    write(f, mat);
  end;
  seek(f, filesize(f) - 1);
  truncate(f);
end;

procedure EditRec(var f: TFPas; n: integer);
var
  mat: TPas;
  m: integer;
begin
  seek(f, n);
  read(f, mat);
  readln(m);
  writeln;
  case m of
    1:
      begin
        write('Новое название: ');
        readln(mat.name);
      end;
    2:
      begin
        write('Новый вес: ');
        readln(mat.weight);
      end;
    3:
      begin
        write('Новая проводимость: ');
        readln(mat.conduct);
      end;
  end;
  seek(f, n);
  write(f, mat);
end;

procedure Alg1(var f1, f2: TFPas; c: integer);
var
  mat: TPas;
begin
  reset(f1); rewrite(f2);
  while not eof(f1) do 
  begin
    read(f1, mat);
    if (mat.weight <= c) then
      AddRec(f2, mat);
  end;
  close(f1);
end;

procedure Alg2(var f1: TFPas; var f3: text);
var
  mat: TPas;
begin
  reset(f1); rewrite(f3);
  while not eof(f1) do 
  begin
    read(f1, mat);
    if mat.conduct = 'полупроводник' then
      writeln(f3, mat.name:15, mat.weight:8);
  end;
  close(f1); close(f3);
end;

procedure ViewFRec(var f: TFPas);
var
  mat: TPas;
  j: integer;
begin
  reset(f); j := 1;
  writeln('№':3, 'название':15, 'вес':8, 'проводимость':16);
  while not eof(f) do 
  begin
    read(f, mat);
    writeln(j:3, mat.name:15, mat.weight:8, mat.conduct:16);
    inc(j);
  end;
  close(f);
end;

procedure ViewFTxt(var f: text);
var
  s: string;
begin
  reset(f);
  while not eof(f) do 
  begin
    readln(f, s);
    writeln(s);
  end;
  close(f);
end;

var
  f1, f2: TFPas;
  f3: text;
  fn1, fn2, fn3: string; 
  mat: TPas; 
  m1, m2, n, c: integer;

begin
  repeat
    clrscr;
    writeln('Меню: ');
    writeln('1 - Задание');
    writeln('2 - Создание файла');
    writeln('3 - Работа с файлом');
    writeln('4 - Вещества весом, не превышающим заданного');
    writeln('5 - Вещества-полупроводники');
    writeln('6 - Просмотр текстового файла');
    writeln('7 - Удалить файл');
    writeln('0 - Выход');
    write('Ваш выбор: ');
    readln(m1);
    writeln;
    case m1 of
      //задание
      1:
        begin
          Task;
          readln;
        end;  
      
      //создание файла
      2:
        begin
          write('Введите имя файла: ');
          readln(fn1);
          if not FileExists(fn1) then begin
            assign(f1, fn1);
            rewrite(f1);
            close(f1);
            writeln('Файл ', fn1, ' успешно создан');
            readln;
          end
          else begin
            writeln('Файл с таким именем уже существует.');
            readln;
          end;
        end;
      
      //работа с файлом записи
      3:
        begin
          write('Введите имя файла: ');
          readln(fn1);
          if FileExists(fn1) then begin
            assign(f1, fn1);
            repeat
              clrscr;
              ViewFRec(f1);
              writeln;
              writeln('Меню работы с файлом записи:');
              writeln('1 - Добавить запись');
              writeln('2 - удалить запись');
              writeln('3 - редактировать запись');
              writeln('0 - выход');
              write('Ваш выбор: ');
              readln(m2);
              writeln;
              case m2 of
                1:
                  begin
                    InputRec(mat);
                    AddRec(f1, mat);
                  end;
                
                2:
                  begin
                    write('Введите номер записи: ');
                    readln(n);
                    dec(n);  //почему? (строки в файле начинаются с нуля, обычный пользователь считает с единицы)
                     //проверка n (проверка в самом DelRec);
                    reset(f1);
                    if (n >= 0) and (n < filesize(f1)) then DelRec(f1, n)
                    else begin
                      writeln('Данная строка в файле отсутствует!');
                      readln;
                    end;
                    close(f1);
                  end;
                3:
                  begin
                    write('Введите номер записи: ');
                    readln(n);
                    dec(n);
                    reset(f1);
                    if (n >= 0) and (n < filesize(f1)) then begin
                      writeln;
                      writeln('Редактирование записи:');
                      writeln('1 - изменить название');
                      writeln('2 - изменить вес');
                      writeln('3 - изменить проводимость');
                      writeln('0 - выход');
                      write('Ваш выбор: ');
                      EditRec(f1, n);
                    end
                    else begin
                      writeln('Данная строка в файле отсутствует!');
                      readln;
                    end;
                    close(f1);
                  end;
              end
            until m2 = 0;      
          end
          else begin
            writeln('Файл с именем ', fn1, ' не существует.');
            readln;
          end;
        end;
      
      4:
        begin
          write('Введите имя исходного файла: ');
          readln(fn1);
          if FileExists(fn1) then begin
            assign(f1, fn1);
            write('Введите имя результирующего файла: ');
            readln(fn2);
            assign(f2, fn2);
            write('Введите максимальный удельный вес: ');
            readln(c);
            Alg1(f1, f2, c);
          end
          else begin
            Writeln('Файла ', fn1, 'не существует');
            readln;
          end;
        end;
      
      5:
        begin
          write('Введите имя исходного файла: ');
          readln(fn1);
          if FileExists(fn1) then begin
            assign(f1, fn1);
            write('Введите имя результирующего файла: ');
            readln(fn3);
            assign(f3, fn3);
            Alg2(f1, f3);       
          end
          else begin
            Writeln('Файла ', fn1, 'не существует');
            readln;
          end;
        end;
      
      //просмотр текстового файла
      6:
        begin
          write('Введите имя файла: ');
          readln(fn3);
          if FileExists(fn3) then begin
            assign(f3, fn3);
            writeln;
            ViewFtxt(f3);         
          end
          else
            writeln('Файл с таким именем уже существует.');
          readln;
        end;
      
      //удаление текстового файла  
      7:
        begin
          write('Введите имя файла:');
          readln(fn3);
          if FileExists(fn3) then begin
            assign(f3, fn3);
            erase(f3);
          end
          else begin
            writeln('Файла с именем', fn3, 'не существует.');
            readln;
          end;
        end;
    end;
  until m1 = 0;
end.
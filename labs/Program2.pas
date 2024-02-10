Program Pr1; 

const nmax=5; 

type vector = array [1..nmax] of integer; 

var A:vector; 

i:integer; 

n:integer; 

begin 

write ('Сейчас введи длину массива (до 5): '); 
readln (n); 

writeln('А теперь элементы массива. Сначала число, затем энтр и опять число потом энтр и тд'); 

for i:=1 to n do 

readln(A[i]); 

write(A); 


end.
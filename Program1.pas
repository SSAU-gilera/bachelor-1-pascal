Program Pr1; 

const nmax = 10; mmax = 10; 

type matr = array [1..nmax, 1..mmax] of integer; 
var a: matr; 
n, m, i, j, S: integer; 


begin 

readln(n, m); 
S:= 0; 
for i := 1 to n do 
begin 
for j:= 1 to m do 
readln(a[i, j]); 
S:= S+a[i,j]; 
end; 


writeln(S); 

end.
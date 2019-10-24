%First, we plot the triangular function 

x=-1:0.1:3;

x1=x(x<1);
x2=x(x>=1);

y1=x1;
y2=-x2+2;

plot(x,[y1 y2])

% Now, we calculate the Fourier series
T = 4; % Period
w0 = 2*pi/T; % Angular frequency
% Assuming an amplitude of A=1

% Fundamental frequency
C1 = 0

% Sum of unwanted harmonics
unwanted = 0

for n = 1:10
    f1=@(t) t;
    i1=quad(f1, -1, 1);
    f2=@(t) -t + 2;
    i2=quad(f2, 1, 3);
    
    a0=(1/T)*(i1 + i2);
    
    f1a=@(t) t*cos(n*w0*t);
    i1a=quad(f1a, -1, 1);
    f2a=@(t) (-t + 2) * cos(n*w0*t);
    i2a=quad(f2a, 1, 3);
    
    an = (2/T) * (i1a + i2a);
    
    f1b=@(t) t*sin(n*w0*t);
    i1b=quad(f1b, -1, 1);
    f2b=@(t) (-t + 2) * sin(n*w0*t);
    i2b=quad(f2b, 1, 3);
   
    bn = (2/T) * (i1b + i2b);
    
    disp("n: "); disp(n);
    disp("A0: "); disp(a0);
    disp("An: "); disp(an);
    disp("Bn: "); disp(bn);
    
    if (n == 1)
        C1 = an + bn
    else
        unwanted = unwanted + (an + bn)^2;
    endif
endfor

THD = (sqrt(unwanted) / C1) * 100;
disp("THD is: ");disp(THD);disp(" %")
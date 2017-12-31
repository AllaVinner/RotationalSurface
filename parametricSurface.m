%% parametric surface
% What happens if you take a circle and drag it along a 3D-curve? A surface
% is created which is ploted by this function.
function parametricSurface(x_function, y_function, z_function, A, B)
%% Load preset inputs
load('Surfaces');
load('Ranges');

%% Check and execute preset inputs
%{
  if(STRCMP(x_function,'Torus'))
   x_function = char(Torus(1));
   y_function = char(Torus(2));
   z_function = char(Torus(3));
elseif(STRCMP(x_function,'Sphere'))
   x_function = char(Sphere(1));
   y_function = char(Sphere(2));
   z_function = char(Sphere(3));
elseif(STRCMP(x_function,'Saddle'))
   x_function = char(Saddle(1));
   y_function = char(Saddle(2));
   z_function = char(Saddle(3));
end
%}

if(A =='TWOPI')
    A= TWOPI;
end

if(B =='TWOPI')
    B= TWOPI;
end

%% Handling input
% Create the meshgrids
[A B] = meshgrid(A,B);

% Convert char to sym
x_sym = sym(x_function);
y_sym = sym(y_function);
z_sym = sym(z_function);
syms a;
syms b;

% substitute the variables a and b with the meshgrids.
x=subs(x_sym, {a, b} , {A, B});
y=subs(y_sym, {a, b} , {A, B});
z=subs(z_sym, {a, b} , {A, B});
S =insert(x,y,z);

surface(x,y,z);
xlabel(['x-axis:  ' , x_function]);
ylabel(['y-axis:  ' , y_function]);
zlabel(['z-axis:  ' , z_function]);
end

function T=insert(x,y,z)
T=x;
T(:,:,2)=y;
T(:,:,3)=z;
end



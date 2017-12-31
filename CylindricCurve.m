function CylindricCurve(x_function, y_function, z_function,r)

%% Examples
% Torus: CylindricCurve('2*cos(t)', '2*sin(t)', 't-t',1)
% Svinging: CylindricCurve('5*cos(t)', '5*sin(t)', '3*cos(5*t)',1)
% Helix: CylindricCurve('2*cos(t)', '2*sin(t)', 't',1)

%% Set domain of parameters
T=0:2*pi/64:2*pi;
beta=0:2*pi/64:2*pi;
[T,beta] = meshgrid(T,beta);

% Convert string to sym
x_sym = sym(x_function);
y_sym = sym(y_function);
z_sym = sym(z_function);
syms t;

%% Initialize the curve in parametric form
x=double(subs(x_sym,t,T));
y=double(subs(y_sym,t,T));
z=double(subs(z_sym,t,T));
curve=insert(x,y,z);

%% Initialize the tangent of the curve in parametric form
x_sym = diff(x_sym);
y_sym = diff(y_sym);
z_sym = diff(z_sym);

x=double(subs(x_sym,t,T));
y=double(subs(y_sym,t,T));
z=double(subs(z_sym,t,T));
tangent=insert(x,y,z);

%% Create the vectors needed
% Create a normal vector and normalize it
norm=Tmap(tangent);
norm=normSurface(norm);

% Create the secound normal vector which is perpendicular to the tangent
% and the first normal vector
cross=crossSurface(tangent, norm);
cross=normSurface(cross);

% Change beta from axb matrix to a multilinear one. With third dimension =
% 3 and alla indexes are iqual to the first one.
B=beta;
B(:,:,2)=beta;
B(:,:,3)=beta;
beta=B;
B=T;
B(:,:,2)=T;
B(:,:,3)=T;
T=B;

%% Create Surface (actual formula)
S=curve + cos(beta).*norm+sin(beta).*cross;

%% Plot the surface.
surf(S(:,:,1),S(:,:,2),S(:,:,3));
axis([-7 7 -7 7 -7 7], 'square');
xlabel('x-axis');
ylabel('y-axis');
zlabel('z-axis');
grid on

end

function T=insert(x,y,z)
T=x;
T(:,:,2)=y;
T(:,:,3)=z;
end

function N=normSurface(X)

    for i = 1: size((X(:,:,1)),1)
        for j = 1: size((X(:,:,1)),2)
            v =[X(i,j,1);X(i,j,2);X(i,j,3)];
            v = 1/norm(v)*v;
            X(i,j,1) = v(1);
            X(i,j,2) = v(2);
            X(i,j,3)= v(3);
        end
    end
     N=X;
end

function C=crossSurface(X,Y)
%X x Y
    C=X;
    for i = 1: size((X(:,:,1)),1)
        for j = 1: size((X(:,:,1)),2)
            v =[X(i,j,1);X(i,j,2);X(i,j,3)];
            u =[Y(i,j,1);Y(i,j,2);Y(i,j,3)];
            w= cross(v,u);
            C(i,j,1) = w(1);
            C(i,j,2) = w(2);
            C(i,j,3)= w(3);
        end
    end
end

function N=Tmap(X)
    N=X;
    T=[0 -1 0
       1 0 0
       0 0 0];
    for i = 1: size((X(:,:,1)),1)
        for j = 1: size((X(:,:,1)),2)
            v =[X(i,j,1);X(i,j,2);X(i,j,3)];
            v=T*v;
            N(i,j,1) = v(1);
            N(i,j,2) = v(2);
            N(i,j,3)= v(3);
        end
    end
end
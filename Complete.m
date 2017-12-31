function Complete()
%% TODO
% * Make it work, save "workspace", inputs, general formula for 2D-curves:
% derivatives.
%%
% Insert the shape at line 65

alpha=-4*pi:2*pi/32:4*pi;
beta=0:2*pi/32:2*pi;
tune =2*pi/64;
r=3;
d=2;
[alpha,beta] = meshgrid(alpha,beta);

t= -3:0.1:3;
s= -3:0.1:3;
[t s] = meshgrid(t,s);
v =alpha;
u = beta;
x	=	beta;	
y	=	beta;	
z	=	alpha;
S=x;
S(:,:,2)=y;
S(:,:,3)=z;
%% Pre determinet things
% PseSphere
x	=	sech(u).*cos(v);	
y	=	sech(u).*sin(v);	
z	=	u-tanh(u);
PseSphere=insert(x,y,z);

% Sphere TODO r' ska bli normerad
r=1/6;

x	=	(2+sin(6*alpha)/2).*cos(alpha)+(3*cos(6*alpha).*sin(alpha)+(2+sin(6*alpha)/2).*cos(alpha))*r.*cos(beta);	
y	=	(2+sin(6*alpha)/2).*sin(alpha)+(3*cos(6*alpha).*cos(alpha)-	(2+sin(6*alpha)/2).*sin(alpha))*r.*cos(beta);
z	=	r*sin(beta);
Sphere=insert(x,y,z);

% Torus
r=1;
x= (d+r*cos(beta)).*cos(alpha);
y= (d+r*cos(beta)).*sin(alpha);
z = r*sin(beta);
Torus=insert(x,y,z);

% Helix
r=0.2;
k=1/(3*pi);
x= cos(alpha)+r*cos(alpha).*cos(beta)+r*k/sqrt(1+k^2)*sin(alpha).*sin(beta);
y= sin(alpha)+r*sin(alpha).*cos(beta)-r*k/sqrt(1+k^2)*cos(alpha).*sin(beta);
z= k*alpha+r*1/sqrt(1+k^2)*sin(beta);
Helix=insert(x,y,z);

a= 0:pi/32:pi-pi/3;
b= pi/2:2/64:pi;
[a b] = meshgrid(a,b);
d=2;
x= d*(1-2*cos(b).^2).*cos(a);
y= d*(1-2*cos(b).^2).*sin(a);
z= -2*d*cos(b).*sin(b);
Sphere2=insert(x,y,z);

%% Insert the shape here
S=Helix;
% Option
% Sphere
% PseSphere
% Torus
% Helix
% Sphere2

%Sett ing x, y, z to match S
x=S(:,:,1);
y=S(:,:,2);
z=S(:,:,3);

subplot(3,2,3);
surf(S(:,:,1),S(:,:,2),S(:,:,3));
axis([-5 5 -5 5 -5 5], 'square');
xlabel('x-axis');
ylabel('y-axis');
zlabel('z-axis');
grid on

%% Crossection of the xy-plane
z_sect=0;
index= z_sect - tune < z & z < z_sect + tune;
x_2D = x(index);
y_2D = y(index);

subplot(3,2,2);
plot(x_2D,y_2D, 'm.');
title('Crossection xy plane')
axis([-5 5 -5 5], 'square');
xlabel('x-axis');
ylabel('y-axis');
grid on

%% Crossection of the xz-plane

y_sect = 0;
index= y_sect - tune < y & y < y_sect + tune;
x_2D = x(index);
z_2D = z(index);

subplot(3,2,4);
plot(x_2D,z_2D, 'g.');
axis([-5 5 -5 5], 'square');
title('Crossection xz-plane');
xlabel('x-axis');
ylabel('z-axis');
grid on

%% Crosssection of the plane x=x_intersection

x_sect = 0;
index= x_sect - tune < x & x < x_sect + tune;
y_2D = y(index);
z_2D = z(index);

subplot(3,2,6);
plot(y_2D,z_2D, 'r.');
axis([-5 5 -5 5], 'square');
title('Crossection of the yz plane');
xlabel('y-axis');
ylabel('z-axis');
grid on


hold off
end

function T=insert(x,y,z)
T=x;
T(:,:,2)=y;
T(:,:,3)=z;
end
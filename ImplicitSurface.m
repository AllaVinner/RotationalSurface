


d= 1/5;
syms x;
syms y;
syms z;

X = -2:d:2;
Y = -2:d:2;
Z = -2:d:2;

hold on
for z = X
   for y = Y
      for x = Z; 
        if( abs(x^2-y^2 +z) < d)
            plot3(x,y,z, '*b');
        end
      end
   end    
end


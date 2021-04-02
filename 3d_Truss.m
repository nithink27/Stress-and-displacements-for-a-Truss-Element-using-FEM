clc;
E = 69;
FS = 1.5;
Rho = 2.77e-5;
YS = 172;
Allowable_displacement = 50.8;
Coordinates = [0 0; 0 9144; 0 18288; 18288 9144; 9144 9144;0 9144];
ElementCon = [1 2; 2 3; 3 4; 4 5; 5 6;2 5; 2 6; 1 5; 3 5; 2 4];
NumberNode = size(Coordinates,1);
NumberElement = size(ElementCon,1);
Kg = zeros(2*NumberNode);

for i = 1:NumberElement
    n1 = ElementCon(i,1);
    n2 = ElementCon(i,2); 
    x1 = Coordinates(n1,1);
    y1 = Coordinates(n1,2);
    x2 = Coordinates(n2,1);
    y2 = Coordinates(n2,2);
   
    L = sqrt((x2-x1)^2+(y2-y1)^2);
    l = (x2-x1)/L;
    m = (y2-y1)/L;
     
    Kl = (E*A/L)*[l^2 l*m -l^2 -l*m;
                    l*m m^2 -l*m -m^2;
                    -l^2 -l*m l^2 l*m;
                    -l*m -m^2 l*m m^2];
   
    k1 = 2*n1-1; k2 = 2*n1;
    k3 = 2*n2-1; k4 = 2*n2;
   
    Kg(k1:k2,k1:k2) = Kg(k1:k2,k1:k2) + Kl(1:2,1:2);
    Kg(k1:k2,k3:k4) = Kg(k1:k2,k3:k4) + Kl(1:2,3:4);
    Kg(k3:k4,k1:k2) = Kg(k3:k4,k1:k2) + Kl(3:4,1:2);
    Kg(k3:k4,k3:k4) = Kg(k3:k4,k3:k4) + Kl(3:4,3:4);
       
end

   
    
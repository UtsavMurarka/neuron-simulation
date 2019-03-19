stepSize=0.01;
t=0:stepSize:100;
ENa=52; 
EK=-72; 
El=-58; 
gbarNa=120; 
gbarK=36; 
gbarl=0.3; 
I = 8; %TO BE CHANGED
Cm = 1; 
%V(1)=-62.2658;
V(1)=-65;
time(1)=0;
m(1)=ab('am', V(1))/(ab('am', V(1))+ab('bm', V(1)));
n(1)=ab('an', V(1))/(ab('an', V(1))+ab('bn', V(1)));
h(1)=ab('ah', V(1))/(ab('ah', V(1))+ab('bh', V(1)));
for i=1:length(t)
    m(i+1)=m(i)+stepSize*((ab('am', V(i))*(1-m(i)))-(ab('bm', V(i))*m(i)));
    n(i+1)=n(i)+stepSize*((ab('an', V(i))*(1-n(i)))-(ab('bn', V(i))*n(i)));
    h(i+1)=h(i)+stepSize*((ab('ah', V(i))*(1-h(i)))-(ab('bh', V(i))*h(i)));
    gNa=gbarNa*m(i)^3*h(i);
    gK=gbarK*n(i)^4;
    gl=gbarl;
    INa=gNa*(V(i)-ENa);
    IK=gK*(V(i)-EK);
    Il=gl*(V(i)-El);
    V(i+1)=V(i)+ stepSize*((1/Cm)*(I-(INa+IK+Il)));
    time(i+1) = (i+1)*0.01;
end

plot(time,V);
xlabel('TIME (msec)');
ylabel('VOLTAGE (mV)');
title('VOLTAGE V/S TIME');
xlim([-2 100]);

figure
plot(time, n);
ylabel('GATING VARIABLE (n)')
xlabel('TIME (msec)')
title('n v/s Time');
xlim([-2 100]);
ylim([-0.2 1.2]);

figure
plot(time, m);
ylabel('GATING VARIABLE (m)')
xlabel('TIME (msec)')
title('m v/s Time');
xlim([-2 100]);
ylim([-0.2 1.2]);

figure
plot(time, h);
ylabel('GATING VARIABLE (h)')
xlabel('TIME (msec)')
title('h v/s Time');
xlim([-2 100]);
ylim([-0.2 1.2]);

clear V;
clear m;
clear n;
clear h;


function alphabeta = ab(ab, v) 
    alphabeta=0;
    if ab == 'an' 
        alphabeta=(0.01*(v+55))/(1-exp(-(0.1)*(v+55)));
    end
    if ab == 'am' 
        alphabeta=(0.1*(v+40))/(1-exp(-(0.1)*(v+40)));
    end
    if ab == 'ah' 
        alphabeta=0.07*exp(-0.05*(v+65));
    end
    if ab == 'bn' 
        alphabeta=0.125*exp(-0.0125*(v+65));
    end
    if ab == 'bm' 
        alphabeta=4*exp(-0.0556*(v+65));

    end
    if ab == 'bh' 
        alphabeta=1/(1+exp(-(0.1)*(v+35)));
    end
end



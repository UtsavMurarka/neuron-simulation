stepSize=0.01;
t=0.1:stepSize:100; 
V=-65; 
m=ab('am', V)/(ab('am', V)+ab('bm', V)); 
n=ab('an', V)/(ab('an', V)+ab('bn', V)); 
h=ab('ah', V)/(ab('ah', V)+ab('bh', V)); 
initial=[V;n;m;h];

tspan = [0.1,max(t)];

[time,V] = ode23(@HHeqn,tspan,initial);
ODE=V(:,1); ODEn=V(:,2); ODEm=V(:,3); ODEh=V(:,4);


plot(time,ODE);
xlabel('TIME (msec)');
ylabel('VOLTAGE (mV)');
title('VOLTAGE V/S TIME');
xlim([-2 100]);

figure
plot(time,ODEn);
ylabel('GATING VARIABLE (n)')
xlabel('TIME (msec)')
title('n v/s Time');
xlim([-2 100]);
ylim([-0.2 1.2]);

figure
plot(time,ODEm);
ylabel('GATING VARIABLE (m)')
xlabel('TIME (msec)')
title('m v/s Time');
xlim([-2 100]);
ylim([-0.2 1.2]);

figure
plot(time,ODEh);
ylabel('GATING VARIABLE (h)')
xlabel('TIME (msec)')
title('h v/s Time');
xlim([-2 100]);
ylim([-0.2 1.2]);

function dV_dt = HHeqn(t, y)
    ENa=52; 
    EK=-72; 
    El=-58; 
    gNa=120; 
    gK=36; 
    gl=0.3; 
    I = 8; %TO BE CHANGED
    Cm = 1; 
    y(1)
    V = y(1);
    n = y(2);
    m = y(3);
    h = y(4);
    
    INa=gNa*m^3*h*(V-ENa);
    IK=gK*n^4*(V-EK);
    Il=gl*(V-El);
    dV_dt = [((1/Cm)*(I-(INa+IK+Il))); ab('an', V)*(1-n)-ab('bn', V)*n; ab('am', V)*(1-m)-ab('bm', V)*m; ab('ah', V)*(1-h)-ab('bh', V)*h];
end

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




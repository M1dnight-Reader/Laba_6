clc
close all

k1 = 20;
k2 = 45;
T = 7;
T1 = 0.025;
t = 0.4;

W1 = tf([t, 1], [T, 1])
W2 = tf(k1, [T1, 1, 0])
W3 = tf(k2, [1, 0])

W5 = feedback(W2, 1, -1)
W5_5 = series(W1, W5);
W6 = series(W5_5, W3)

Fx = feedback(W6, 1, -1)
Fe = 1 - Fx
bode(W6)
figure
nyquist(W6)
figure
step(Fx)
figure
impulse(Fx)



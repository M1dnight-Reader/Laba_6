clc
close all


W1 = tf([t, 1], [T, 1])
W2 = tf(k1, [T1, 1, 0])
W3 = tf(k2, [1, 0])

W5 = feedback(W2, 1, -1)
W5_5 = series(W1, W5);
W6 = series(W5_5, W3)

Fx = feedback(W6, 1, -1)
Fe = 1 - Fx

draw_pictures;

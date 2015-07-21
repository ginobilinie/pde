function [B0 B1 B2 B3 B4] = p5b()

LW = 'linewidth'; lw = 1.6;
MS = 'markersize'; ms = 12;
FS = 'fontsize'; fs = 12;

x = chebfun('x',[-0.5 0.5]);
B0 = 1+0*x;
ax = [-3 3 -.2 1.2];
hold off, plot(B0,LW,lw), axis(ax), grid on
pts = [-.5 .5];
hold on, plot(pts,B0(pts,'left'),'.k',MS,ms)
plot(pts,B0(pts,'right'),'.k',MS,ms)
title('B-spline of order 0',FS,fs)

B1 = conv(B0,B0);
%hold off, plot(B1,LW,lw), axis(ax), grid on
plot(B1,LW,lw), axis(ax), grid on
pts = [pts-.5 max(pts)+.5];
hold on, plot(pts,B1(pts),'.k',MS,ms)
title('B-spline of order 1',FS,fs)

B2 = conv(B0,B1);
%hold off, plot(B2,LW,lw), axis(ax), grid on
plot(B2,LW,lw), axis(ax), grid on
pts = [pts-.5 max(pts)+.5];
hold on, plot(pts,B2(pts),'.k',MS,ms)
title('B-spline of order 2',FS,fs)

B3 = conv(B0,B2);
%hold off, plot(B3,LW,lw), axis(ax), grid on
plot(B3,LW,lw), axis(ax), grid on
pts = [pts-.5 max(pts)+.5];
hold on, plot(pts,B3(pts),'.k',MS,ms)
title('B-spline of order 3',FS,fs)


B4 = conv(B0,B3);
%hold off, plot(B4,LW,lw), axis(ax), grid on
plot(B4,LW,lw), axis(ax), grid on
pts = [pts-.5 max(pts)+.5];
hold on, plot(pts,B4(pts),'.k',MS,ms)
title('B-spline of order 4',FS,fs)


end



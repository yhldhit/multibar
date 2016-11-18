function x = multibar(x,y,width,M)
%%This function extend the bar to draw multiple bars in one figure
% x is a vector 1 by N, N is the num of classes, typically x= [1:N]
% y is matrix  M by N, M is num of oberservation in one class
%width is the width of bar, suggest to be 0.2
colorstr = 'brgcmyks';
    for iob = 1:M
        xtmp = x-width/2*(M-2*iob-1); 
        ytmp = y(iob,:);
        bar(xtmp,ytmp,width,colorstr(iob));
        hold on;
    end
    
    set(gca,'XTick',x);xlabel('class'); ylabel('proportion')
end
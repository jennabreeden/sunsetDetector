function [avgL, sdL, avgS, sdS, avgT, sdT] = featureExtract(img, nBlocks)
R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);
temp = zeros(size(img, 1), size(img, 2), 3);
temp(:,:,1) = R+B+G;
temp(:,:,2) = R-B;
temp(:,:,3) = R-(2*G)+B;
[r, c] = size(img);sizeR = floor(r / nBlocks);sizeC = floor(c / nBlocks);
for rows=0:nBlocks-1
    for cols=0:nBlocks-1
        x1 = rows*sizeR+1;
        y1 = cols*sizeC+1;
        x2 = min(x1+sizeR-1, r);
        y2 = min(y1+sizeC-1, c); 
        avgL = mean(mean(temp(x1:x2, y1:y2, 1)));
        sdL = std(std(temp(x1:x2, y1:y2, 1)));
        avgS = mean(mean(temp(x1:x2, y1:y2, 2)));
        sdS = std(std(temp(x1:x2, y1:y2, 2)));
        avgT = mean(mean(temp(x1:x2, y1:y2, 3)));
        sdT = std(std(temp(x1:x2, y1:y2, 3)));
    end
end
end
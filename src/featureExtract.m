function featureVector = featureExtract(img, nBlocks)
% image is converted to a double to ensure all calculations are accurate
img = double(img);

% RGB channels extracted and stored in separate matrices respectively 
R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);

% L S & T are computed as linear combinations of the R, G, and B matrices
temp = zeros(size(img, 1), size(img, 2), 3);

temp(:,:,1) = R+B+G;
temp(:,:,2) = R-B;
temp(:,:,3) = R-(2*G)+B;

% image is then divided into a grid of blocks, where each block is of 
% nBlocks equal size. 
% Size is determined by dividing the number of rows and columns of the 
% image by the number of blocks, and rounding down to the nearest integer.
[r, c, ~] = size(img);
sizeR = floor(r / nBlocks);
sizeC = floor(c / nBlocks);

% initialized as a zero vector of length 294, six times the number of blocks squared
featureVector = zeros(1, 294);
k = 1;

for rows=0:nBlocks-1
    for cols=0:nBlocks-1

    x1 = rows*sizeR+1;
    y1 = cols*sizeC+1;
    x2 = min(x1+sizeR-1, r);
    y2 = min(y1+sizeC-1, c);

    Lblock = temp(x1:x2, y1:y2, 1);
    avgL = mean(mean(Lblock));
    featureVector(k) = avgL;
    k = k+1;

    sdL = std(Lblock(:));
    featureVector(k) = sdL;
    k = k+1;

    Sblock = temp(x1:x2, y1:y2, 2);
    avgS = mean(mean(Sblock));
    featureVector(k) = avgS;
    k = k+1;

    sdS = std(Sblock(:));
    featureVector(k) = sdS;
    k = k+1;

    Tblock = temp(x1:x2, y1:y2, 3);
    avgT = mean(Tblock(:));
    featureVector(k) = avgT;
    k = k+1;
    
    sdT = std(Tblock(:));
    featureVector(k) = sdT;
    k = k+1;
    end
end
end
% Example of a datastore 
clc;

if exist('features.mat', 'file') == 0
    rootDir = '/MATLAB Drive/sunsetDetector/images/';

    trainDir = [rootDir 'train'];
    validateDir = [rootDir 'validate'];
    testDir = [rootDir 'test'];

    trainImages = imageDatastore(...
        trainDir, ...
        'IncludeSubfolders',true, ...
        'LabelSource', 'foldernames');
    validateImages = imageDatastore(...
        validateDir, ...
        'IncludeSubfolders',true, ...
        'LabelSource', 'foldernames');
    testImages = imageDatastore(...
        testDir, ...
        'IncludeSubfolders',true, ...
        'LabelSource', 'foldernames');

    fprintf('Read images into datastores\n');

    normalizeFeatures01();

    xTrain = imageDatastoreReader(trainImages);
    yTrain = trainImages.Labels;

    xValidate = imageDatastoreReader(validateImages);
    yValidate = validateImages.Labels;

    xTest = imageDatastoreReader(testImages);
    yTest = testImages.Labels;

    save('features.mat', ...
         'xTrain', 'yTrain', ...
         'xValidate', 'yValidate', ...
         'xTest', 'yTest');
else
    load('features.mat');
end

%% Store Data into labeled objects
xTrain = normalizeFeatures01(xTrain);

xTest = normalizeFeatures01(xTest);

xValidate = normalizeFeatures01(xValidate);

%% Predict an optimal set of hyperparameters for use in an SVM using MATLAB as a starting point
%% optimalSVM = fitcsvm(xTrain, yTrain, 'KernelFunction', 'rbf', 'OptimizeHyperparameters','auto');   
%save("trained_network",'optimalSVM');

%Classifies Training Set
[detectedClasses, distances] = predict(optimalSVM, xTrain);

fprintf("Training Set: ");
[true_positive, false_positive, true_negative, false_negative, Accuracy, TPR, FPR] = determineStatistics(detectedClasses, distances, yTrain);

[detectedClasses, distances] = predict(optimalSVM, xValidate);

fprintf("Validation Set: ");
[true_positive, false_positive, true_negative, false_negative, Accuracy, TPR, FPR] = determineStatistics(detectedClasses, distances, yValidate);

[detectedClasses, distances] = predict(optimalSVM, xTest);

fprintf("Test Set: ");
[true_positive, false_positive, true_negative, false_negative, Accuracy, TPR, FPR] = determineStatistics(detectedClasses, distances, yTest);

%% Train and evaluate an SVM with Optimal HyperParameters Manually
resolution = 100; 
maxKS = 1000;
maxBC = 1000;
minKS = 0;
minBC = 0;

%% Train and evaluate an SVM with Optimal HyperParameters 
[bestKS, bestBC, bestAccuracy,meshKS,meshBC,meshAcc] = hyperparameter(resolution, maxKS, maxBC, xTrain,yTrain, xTest, yTest);

%[bestKS, bestBC, bestAccuracy,meshKS,meshBC,meshAcc,numSupportVectors] = optimalGridSearch(resolution,minKS,maxKS,minBC,maxBC,trainX,trainY,testX,testY);

%SVM = fitcsvm(xTrain, yTrain, 'KernelFunction', 'rbf', 'KernelScale', ...
%     bestKS, 'BoxConstraint', bestBC,'Standardize',true); 
% fprintf("Optimized Hyperparameters are Kernel Scale: %f, Box Constraint: ..." + ...
%     "%f for an accuracy of %f with %d support vectors\n", bestKS, bestBC, ...
%     Accuracy * 100, length(SVM.SupportVectorLabels));
% %save("trained_network",'net');


function newClass = threshold(distances, detectedClasses)
for i=1:length(distance)
    if distance(i, 1) >= thresholdVal
        newClass(i, :) = 'sunset';
    else
        newClass(i, :) = 'nonsunset';
    end
end



end
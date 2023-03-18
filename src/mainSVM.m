% Example of a datastore 
clc;

rootdir = '/MATLAB Drive/sunsetDetector/images';
subdir = [rootdir 'train'];

trainImages = imageDatastore(...
    subdir, ...
    'IncludeSubfolders',true, ...
    'LabelSource', 'foldernames');

% Make datastores for the validation and testing sets similarly.
subdir2 = [rootdir 'test'];
subdir3 = [rootdir 'validate'];

testImages = imageDatastore(...
    subdir2, ...
    'IncludeSubfolders', true, ...
    'LabelSource', 'foldernames');
validateImages = imageDatastore(...
    subdir3, ...
    'IncludeSubfolders', true, ...
    'LabelSource', 'foldernames');

fprintf('Read images into datastores\n');

xTrain = imageDatastoreReader(trainImages);
yTrain = trainImages.Labels;

%% Train and evaluate an SVM








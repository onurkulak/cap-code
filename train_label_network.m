% train a 2-layer one-word image captionizer
% w is the bias + hidden layer weights
% v is the bias + output layer weights
% features is a nxm matrix where 
% m is sample size and n is number of features
% label ids is a kxm matrix
% where each row corresponds to the labels associated with a feature vector
% there are k possible labels in total
function [w, v] = train_label_network(features, label_ids)

% number of labels
k = size(label_ids,1);

% number of samples and features
[n,m] = size(features);

% some parameters
sequence = 1:m;
sequence = sequence(randperm(m));
learningRate = 0.001;
epochCnt = 100;

% number of neurons
hn = round(sqrt(m*k));

w = normrnd(0,0.1,[hn n+1]);
v = normrnd(0,0.1,[k hn+1]);
minBatchSize = 50;
epochErr = zeros([epochCnt 1]);
epochAccuracy = zeros([epochCnt 1]);
for epoch = 1:epochCnt
    errors = zeros([m 1]);
    accuracy  = zeros([m 1]);
    for minBatch = 1:minBatchSize:m
        imids = sequence(minBatch:minBatch+minBatchSize-1);
        img = [features(:,imids);ones(1, minBatchSize)];
        z = w*img;
        h = tanh(z);
        y = v*[h; ones(1, minBatchSize)];
        o = tanh(y);
        d = label_ids(:,imids);
        % error-delta of output layer - v
        e = d-o;
        gv = e.*sech(y).^2;
        
        % error-delta of hidden layer - w
        gw = (1-tanh(z).^2).*repmat(v(1:hn)',1,minBatchSize)*(gv)';
        %update weights
        v = v+(learningRate/minBatchSize*[h; ones(1, minBatchSize)]*gv')';
        w = w+(learningRate/minBatchSize*repmat(gw,1,minBatchSize)*img');
        errors(minBatch) = sum(e(:).^2);
        %accuracy(minBatch) = sum(sign(d)==sign(o));
    end
    epochAccuracy(epoch) = sum(accuracy)/m;
    epochErr(epoch) = sum(errors);
end
plot(epochErr)
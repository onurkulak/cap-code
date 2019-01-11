% train a 2-layer one-word image captionizer
% w is the bias + hidden layer weights
% v is the bias + output layer weights
% features is a nxm matrix where 
% m is sample size and n is number of features
% label ids is a kxm matrix
% where each row corresponds to the labels associated with a feature vector
% there are k possible labels in total

% time limit is the training time limit in seconds
% it can be 0 if user wants to train whole data 250 times
function [w, v] = train_label_network(features, label_ids, time_limit)
tic

label_ids(label_ids==0)=-1;

% number of labels
k = size(label_ids,1);

% number of samples and features
[n,m] = size(features);

% some parameters
sequence = randperm(m);
learningRate = 0.001;
epochCnt = 250;

% number of neurons
hn = round(sqrt(m*k));

w = normrnd(0,0.1,[hn n+1]);
v = normrnd(0,0.1,[k hn+1]);
minBatchSize = 50;
epochErr = zeros([epochCnt 1]);
epochAccuracy = zeros([epochCnt 1]);
for epoch = 1:epochCnt 
    if(toc > time_limit && toc ~= 0)
        break
    end
    disp(epoch);
    errors = zeros([m 1]);
    accuracy  = zeros([m 1]);
    for minBatch = 1:minBatchSize:m 
        if(toc > time_limit && toc ~= 0)
            break
        end
        imids = sequence(minBatch:min(minBatch+minBatchSize-1,m));
        img = [features(:,imids);ones(1, length(imids))];
        
        [z,h,y,o] = feed_forward(w,v,img);
        d = label_ids(:,imids);
        
        % error-delta of output layer - v
        e = d-o;
        gv = e.*sech(y).^2;
        % error-delta of hidden layer - w
        gw = sum((1-tanh(z).^2).*repmat(v(1:hn)',1,length(imids))*(gv)',2);
        %update weights
        v = v+(learningRate/length(imids)*[h; ones(1, length(imids))]*gv')';
        w = w+(learningRate/length(imids)*repmat(gw,1,length(imids))*img');
        errors(minBatch) = sum(e(:).^2);
        %accuracy(minBatch) = sum(sign(d)==sign(o));
    end
    plot(errors)
    epochAccuracy(epoch) = sum(accuracy)/m;
    epochErr(epoch) = sum(errors);
end
figure
plot(epochErr)
function [count,label] = createLabel(photoList,targetRows,learned_weights1,learned_weights2)
    %Photolist is a matrix N x feature_vec_size. It has the feaute vectors
    %for each N photos in the photoList.
    N = size(photoList,1);
    labelLists = zeros(N,10);
    for i=1:N
        labelLists(i) = predictor(photoList(i,:),learned_weights1,learned_weights2);
    end
    
    for i=N:-1:1
        combos = combntns(1:N,i);
        for j= 1:size(combos,1)
            currentComb = combos(j,:);
            
        end
    end
end
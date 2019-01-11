function [count,label] = createLabel(photoList,targetRows,learned_weights1,learned_weights2)
    %Photolist is a matrix N x feature_vec_size. It has the feaute vectors
    %for each N photos in the photoList.
    count = 0;
    label = '';
    maxScore = -Inf;
    N = size(photoList,1);
    labelLists = zeros(2,20,N);

    for i=1:N
        labelLists(:,:,i) = predictor(photoList(i,:),learned_weights1,learned_weights2);
    end
    %predictor returns a matrix (2x20). Each columns has 2 numbers. The
    %first one is the label indicator integer and the second is the score
    %of this label calculated by the network. The labels included are the
    %best 20 labels that defines the given photo and ordered from best to
    %worst.
    targetSize = size(targetRows);
    targetLabelsList = labelLists(:,:,targetRows);
    for i=targetSize:-1:1
        combos = combntns(1:targetSize,i);
        for j= 1:size(combos,1)
            currentComb = combos(j,:);
            %Find intersecting labels 
            intesectingLabelList = unique(targetLabelsList(1,:,currentComb(1)));
            for m =1:size(currentComb)-1
                intesectingLabelList = intersect(unique(targetLabelsList(1,:,currentComb(m))),unique(targetLabelsList(1,:,currentComb(m+1))));
            end
            
            
            if isempty(intesectingLabelList)
                continue;
            end
            for k =1:size(intesectingLabelList)
                %Check here if any non target photo has the label in a
                %higher rank than the target photos
                
                targetMaxScore = -1;
                nonTargetMaxScore = -1;
                for n =1:size(labelLists)
                    curPhotoLabels = labelLists(1,:,n);
                    index = find(curPhotoLabels == intesectingLabelList(k));
                    if( ~isempty(index))
                        if(find(targetRows==n))
                            if labelLists(2,index,n) > targetMaxScore
                                    targetMaxScore = labelLists(2,index,n);
                            end
                        else
                            if labelLists(2,index,n) > nonTargetMaxScore
                                    nonTargetMaxScore = labelLists(2,index,n);
                            end
                        end
                    end
                end
                
                if(nonTargetMaxScore >= targetMaxScore)
                    continue;
                end
                %Calculate score
                [score] = calculateScore(intesectingLabelList(k),labelLists,targetRows);
                if score > maxScore
                    maxScore = score;
                    label = intesectingLabelList(k);
                    count = i;
                end
                
            end
        end
    end
end
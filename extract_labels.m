function labels = extract_labels(features,captions,image_ids)
    labels = zeros(size(features,2),1004);
    for i = 1:size(features,2)
        [r,c] = find(image_ids ==i);
        label_instances = zeros(size(r,1)*17,1);
        for j= 1: size(r)
            start = (j-1)*17 +1;
            ending = start + 16;
            label_instances(start:ending) = captions(:,r(j));
        end
        unique_label_instances = unique(label_instances);
        labels(i,unique_label_instances) = 1;
    end
end
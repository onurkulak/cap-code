% downloads images required for the project
options = weboptions('Timeout',Inf);
for i = 1:size(train_urls)
    url = char(train_urls(i));
    websave(strcat('C:\Users\onur\Desktop\nöral ödevleri\proje\cap-code/trainimg/',num2str(i)), url(url~=' ' & url~=0), options)
end

for i = 1:size(test_urls)
    url = char(test_urls(i));
    websave(strcat('C:\Users\onur\Desktop\nöral ödevleri\proje\cap-code/testimg/',num2str(i)), url(url~=' ' & url~=0), options)
end


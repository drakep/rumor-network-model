function labels = getlabels()
rawData1 = importdata('labels.txt');
[~,name] = fileparts('labels.txt');
newData1.(genvarname(name)) = rawData1;
vars = fieldnames(newData1);
for i = 1:length(vars)
    assignin('base', vars{i}, newData1.(vars{i}));
end
labels = rawData1;
%clear i;clear name;clear newData1;clear rawData1;clear vars;
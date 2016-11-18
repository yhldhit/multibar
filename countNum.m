%%read from dir
dirtmp = dir('./');% get a struct, with element of name date isdir bytes datanum

dirtmp = dirtmp(3:end);% remove current and parent directory
filetmp = {dirtmp.name};%all the file names in dirtmp, including the floders, is a cell, every entry corresponds to a file or a folder
isdirtmp = [dirtmp.isdir];% 
dircell = filetmp(isdirtmp);
% dircell = {dirtmp([dirtmp.isdir]).name};
%backpack,bike,calculator,headphones,keyboard,laptop_computer,monitor,mouse,mug,projector
%[3,1,2,4,5,6,7,8,9,10]
class_index = [1,2,6,11,12,13,16,17,18,23];
%count every class in each domain
claCount = zeros(3,31);
pwdtmp = pwd;
pwdtmp(pwdtmp=='\') = '/';
for idomain=1:length(dircell)
    
    dirname = [pwdtmp,'/',dircell{idomain},'/images/'];
    dirtmp = dir(dirname);
    dirtmp = dirtmp(3:end);% remove current and parent directory
    filetmp = {dirtmp.name};%all the file names in dirtmp, including the floders, is a cell, every entry corresponds to a file or a folder
    isdirtmp = [dirtmp.isdir];% 
    dircell2 = filetmp(isdirtmp);
    
    for iclass = 1:length(dircell2)
%         fprintf('iclass:%f',iclass);
%         fprintf (dircell2{iclass});
%        fprintf('\n');
        dirname2 = [dirname dircell2{iclass}];
        dirimages = dir(fullfile(dirname2,'*jpg'));
        claCount(idomain,iclass) = length(dirimages);
    end

end
% claCount = claCount(:,class_index);
% re_sort = [3,1,2,4,5,6,7,8,9,10];
% claCount = claCount(:,re_sort);
mnist = [5923,6742,5958,6131,5842,5421,5918,6265,5851,5949];
usps = [1194,1005,731,658,652,556,664,645,542,644];
svhn = [4948,13861,10585,8497,7458,6882,5727,5595,5045,4659];
claCount = zeros(3,10);
claCount(1,:) = mnist;
claCount(2,:) = usps;
claCount(3,:) = svhn;
% mnist = [5923,6742,5958,6131,5842,5421,5918,6265,5851,5949];
% generated = [5980,7397,5506,6920,5436,5293,6329,6180,4683,6276];
 
% claCount = zeros(3,10);
% claCount(1,:) = mnist;
% claCount(2,:) = generated;

%************************bar***********************%
domainNum = sum(claCount,2);
domainNum = repmat(domainNum,1,size(claCount,2));
claCount = claCount./domainNum;

x = [1:10];
width = 0.21;
x1 = x-width/2*2; 
y1 = claCount(1,:);
bar(x1,y1,width,'g');
hold on;

x2 = x;
y2 = claCount(2,:);
bar(x2,y2,width,'r');
hold on;
% 
x3 = x+width/2*2;
y3 = claCount(3,:);
bar(x3,y3,width,'y');

set(gca,'XTick',x);xlabel('class'); ylabel('weight');legend('MNIST','USPS','SVHN');
%legend('AMAZON','DSLR','WEBCAM');
% legend('MNIST','Generated')



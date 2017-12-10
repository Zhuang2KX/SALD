function reorientT1(T1Img)
%% Reorient the structural image before pre-processing
% --------------------------------------------------------------------------------%
%% Input
%  -T1Img: where the T1 data are located
% --------------------------------------------------------------------------------%

cd(T1Img);
list = dir;
list = list(3:end,:);

spmDir=which('spm');
spmDir=spmDir(1:end-5);
tmpl=[spmDir 'canonical/avg152T1.nii'];
vg=spm_vol(tmpl);
flags.regtype='rigid';

S = dir('*.nii');
if isempty(S) == 1;
    for i = 1:length(list);
        fildir = [T1Img,'\',list(i).name];
        cd(fildir);
        Filter = ['^*.nii$'];
        p = spm_select('List',fildir, Filter);
        for j=1:size(p,1)
            f=strtrim(p(j,:));
            spm_smooth(f,'temp.nii',[12 12 12]);
            vf=spm_vol('temp.nii');
            [M,scal] = spm_affreg(vg,vf,flags);
            M3=M(1:3,1:3);
            [u s v]=svd(M3);
            M3=u*v';
            M(1:3,1:3)=M3;
            N=nifti(f);
            N.mat=M*N.mat;
            create(N);
        end
        delete('temp.nii');
        disp(['The AC-PC reorientation for subject ',num2str(i),' has been finished!']);
    end
else
    Filter = ['^*.nii$'];
    p = spm_select('List',T1Img, Filter);
    for i=1:size(p,1)
        f=strtrim(p(i,:));
        spm_smooth(f,'temp.nii',[12 12 12]);
        vf=spm_vol('temp.nii');
        [M,scal] = spm_affreg(vg,vf,flags);
        M3=M(1:3,1:3);
        [u s v]=svd(M3);
        M3=u*v';
        M(1:3,1:3)=M3;
        N=nifti(f);
        N.mat=M*N.mat;
        create(N);
        disp(['The AC-PC reorientation for subject ',num2str(i),' has been finished!']);
    end
    delete('temp.nii');
end


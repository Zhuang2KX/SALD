%% SPM Batch of DARTEL
%   
%  Z.K.X.   2017/12/08
%------------------------------------------------------------------------------------%
%% Setting
Data_path = 'F:\Work\Data\SALD\T'            % where the T1 Nifti data are located
FWHM = 6;                                    % Gaussian FWHM
Modulation = 1;                              % 1:modulation; 0;no modulation
%------------------------------------------------------------------------------------%
%% VBM8 Denosing Filter 
cd(Data_path);
Sublist = dir('*.nii');
for i = 1:length(Sublist)
    SUB{i,1} = [Data_path,'\',Sublist(i).name,',1'];
end
matlabbatch{1}.spm.tools.vbm8.tools.sanlm.data = SUB;
spm('defaults', 'FMRI');
spm_jobman('run', matlabbatch);

%% SPM8 New Segment
SPM_path = which('spm.m');
SPM_path(end-4:end) = [];
Sublist = dir('sanlm*.nii');
for i = 1:length(Sublist)
    SUB{i,1} = [Data_path,'\',Sublist(i).name,',1'];
end
matlabbatch{1}.spm.tools.preproc8.channel.vols = SUB;
matlabbatch{1}.spm.tools.preproc8.channel.biasreg = 0.0001;
matlabbatch{1}.spm.tools.preproc8.channel.biasfwhm = 60;
matlabbatch{1}.spm.tools.preproc8.channel.write = [0 0];
matlabbatch{1}.spm.tools.preproc8.tissue(1).tpm = {[SPM_path,'toolbox\Seg\TPM.nii,1']};
matlabbatch{1}.spm.tools.preproc8.tissue(1).ngaus = 2;
matlabbatch{1}.spm.tools.preproc8.tissue(1).native = [1 1];
matlabbatch{1}.spm.tools.preproc8.tissue(1).warped = [0 0];
matlabbatch{1}.spm.tools.preproc8.tissue(2).tpm = {[SPM_path,'toolbox\Seg\TPM.nii,2']};
matlabbatch{1}.spm.tools.preproc8.tissue(2).ngaus = 2;
matlabbatch{1}.spm.tools.preproc8.tissue(2).native = [1 1];
matlabbatch{1}.spm.tools.preproc8.tissue(2).warped = [0 0];
matlabbatch{1}.spm.tools.preproc8.tissue(3).tpm = {[SPM_path,'toolbox\Seg\TPM.nii,3']};
matlabbatch{1}.spm.tools.preproc8.tissue(3).ngaus = 2;
matlabbatch{1}.spm.tools.preproc8.tissue(3).native = [1 0];
matlabbatch{1}.spm.tools.preproc8.tissue(3).warped = [0 0];
matlabbatch{1}.spm.tools.preproc8.tissue(4).tpm = {[SPM_path,'toolbox\Seg\TPM.nii,4']};
matlabbatch{1}.spm.tools.preproc8.tissue(4).ngaus = 3;
matlabbatch{1}.spm.tools.preproc8.tissue(4).native = [1 0];
matlabbatch{1}.spm.tools.preproc8.tissue(4).warped = [0 0];
matlabbatch{1}.spm.tools.preproc8.tissue(5).tpm = {[SPM_path,'toolbox\Seg\TPM.nii,5']};
matlabbatch{1}.spm.tools.preproc8.tissue(5).ngaus = 4;
matlabbatch{1}.spm.tools.preproc8.tissue(5).native = [1 0];
matlabbatch{1}.spm.tools.preproc8.tissue(5).warped = [0 0];
matlabbatch{1}.spm.tools.preproc8.tissue(6).tpm = {[SPM_path,'toolbox\Seg\TPM.nii,6']};
matlabbatch{1}.spm.tools.preproc8.tissue(6).ngaus = 2;
matlabbatch{1}.spm.tools.preproc8.tissue(6).native = [0 0];
matlabbatch{1}.spm.tools.preproc8.tissue(6).warped = [0 0];
matlabbatch{1}.spm.tools.preproc8.warp.mrf = 0;
matlabbatch{1}.spm.tools.preproc8.warp.reg = 4;
matlabbatch{1}.spm.tools.preproc8.warp.affreg = 'mni';
matlabbatch{1}.spm.tools.preproc8.warp.samp = 3;
matlabbatch{1}.spm.tools.preproc8.warp.write = [0 0];
spm('defaults', 'FMRI');
spm_jobman('run', matlabbatch);

%% DARTEL Create Templete
Sub_c1 = dir('rc1*.nii');
Sub_c2 = dir('rc2*.nii');
a = struct2cell(Sub_c1);
b = struct2cell(Sub_c2);
A{1,1} = a(1,:);
A{1,2} = b(1,:);
matlabbatch{1}.spm.tools.dartel.warp.images = A;
matlabbatch{1}.spm.tools.dartel.warp.settings.template = 'Template';
matlabbatch{1}.spm.tools.dartel.warp.settings.rform = 0;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(1).its = 3;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(1).rparam = [4 2 1e-06];
matlabbatch{1}.spm.tools.dartel.warp.settings.param(1).K = 0;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(1).slam = 16;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(2).its = 3;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(2).rparam = [2 1 1e-06];
matlabbatch{1}.spm.tools.dartel.warp.settings.param(2).K = 0;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(2).slam = 8;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(3).its = 3;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(3).rparam = [1 0.5 1e-06];
matlabbatch{1}.spm.tools.dartel.warp.settings.param(3).K = 1;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(3).slam = 4;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(4).its = 3;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(4).rparam = [0.5 0.25 1e-06];
matlabbatch{1}.spm.tools.dartel.warp.settings.param(4).K = 2;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(4).slam = 2;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(5).its = 3;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(5).rparam = [0.25 0.125 1e-06];
matlabbatch{1}.spm.tools.dartel.warp.settings.param(5).K = 4;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(5).slam = 1;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(6).its = 3;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(6).rparam = [0.25 0.125 1e-06];
matlabbatch{1}.spm.tools.dartel.warp.settings.param(6).K = 6;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(6).slam = 0.5;
matlabbatch{1}.spm.tools.dartel.warp.settings.optim.lmreg = 0.01;
matlabbatch{1}.spm.tools.dartel.warp.settings.optim.cyc = 3;
matlabbatch{1}.spm.tools.dartel.warp.settings.optim.its = 3;
spm('defaults', 'FMRI');
spm_jobman('run',matlabbatch);   

%% Normalise to MNI Space
U = dir('u_*.nii');
U = struct2cell(U);
U(2:5,:) = [];
C1 = dir('c1*.nii');
C2 = dir('c2*.nii');
C1 = struct2cell(C1);
C2 = struct2cell(C2);
B{1,1} = C1(1,:);
B{1,2} = C2(1,:);
matlabbatch{1}.spm.tools.dartel.mni_norm.template = {'Template_6.nii'};
matlabbatch{1}.spm.tools.dartel.mni_norm.data.subjs.flowfields = U;
matlabbatch{1}.spm.tools.dartel.mni_norm.data.subjs.images = B;
matlabbatch{1}.spm.tools.dartel.mni_norm.vox = [NaN NaN NaN];
matlabbatch{1}.spm.tools.dartel.mni_norm.bb = [NaN NaN NaN
                                               NaN NaN NaN];
matlabbatch{1}.spm.tools.dartel.mni_norm.preserve = Modulation;
matlabbatch{1}.spm.tools.dartel.mni_norm.fwhm = [FWHM FWHM FWHM];
spm('defaults', 'FMRI');
spm_jobman('run',matlabbatch); 

%% Organize Data
if Modulation == 1
    M = ['GMV_',num2str(FWHM)];
    W = ['GWV_',num2str(FWHM)];
    movefile('swc1*.nii',M);
    movefile('swc2*.nii',W);
elseif Modulation == 0
    M = ['GMD_',num2str(FWHM)];
    W = ['GWD_',num2str(FWHM)];
    movefile('swc1*.nii','GMD_');
    movefile('swc2*.nii','GWD_');
end
cd ..
copyfile(fullfile(Data_path,'GM*'),pwd)
copyfile(fullfile(Data_path,'GW*'),pwd)

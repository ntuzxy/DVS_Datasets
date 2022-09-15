%% dataset is downloaded from https://zenodo.org/record/3228846#.YyKVo3ZBxaR
load('subject01_session01_davis.mat');
%%
epoch_time = 66e3;
a_maxYSize = 180;
a_maxXSize = 240;
frame_ctr = 0;
save_image = 1;
tstart=aedat.data.polarity.timeStamp(1);
frame = zeros(a_maxYSize,a_maxXSize);

filename = 'gesture';
framesFolder = ['./',filename,'_frames'];
if ~exist(framesFolder, 'dir')
    mkdir(framesFolder);
end

for i=1:length(aedat.data.polarity.timeStamp)
    t = aedat.data.polarity.timeStamp(i);
    x = aedat.data.polarity.x(i) + 1;
    y = aedat.data.polarity.y(i) + 1;
    frame(y,x) = 1;

    if t - tstart > epoch_time
        frame_ctr = frame_ctr + 1;
        tstart=t;
        %can perform median filtering or other operations on the accumlated image if needed
        if save_image
            imwrite(frame,[framesFolder,'/',num2str(frame_ctr),'.jpg']);
        end
        imshow(frame);
%         imshow(double(1-frame))
        frame=0;
    end
end
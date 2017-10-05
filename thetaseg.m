function [bounds,bounds_t,osc_env,nuclei] = thetaseg(filenames,threshold)
%function [bounds,bounds_t,osc_env,nuclei] = thetaseg(filenames,threshold)


Q_value = 0.6;  % Q-value of the oscillator, default = 0.5 = critical damping
center_frequency = 8; % in Hz

if nargin <2
threshold = 0.01;
end

% 2) Generate Gammatone filterbank center frequencies (log-spacing)
minfreq = 50;
maxfreq = 7500;
bands = 20;

cfs = zeros(bands,1);
const = (maxfreq/minfreq)^(1/(bands-1));

cfs(1) = 50;
for k = 1:bands-1
    cfs(k+1) = cfs(k).*const;
end

bounds = cell(length(filenames),1);
bounds_t = cell(length(filenames),1);
osc_env = cell(length(filenames),1);
nuclei = cell(length(filenames),1);

for k = 1:length(filenames)
    
    % 1) Load audio file
    [x,fs] = audioread(filenames{k});
    
    if(size(x,2) > 1)
        x = mean(x,2); % Use average of both channels
    end
    
    if(fs ~= 16000)
        x = resample(x,16000,fs);
        fs = 16000;
    end
    
    
    %[x,fs] = denoise(x,fs);
    
    
    
    % 3) Compute gammatone envelopes and downsample to 1000 Hz
    
    env = zeros(length(x),length(cfs));
    for cf = 1:length(cfs)
        [~, env(:,cf), ~, ~] = gammatone_c(x, fs,cfs(cf));
    end
    env = resample(env,1000,fs);
    
    % 4) Run oscillator-based segmentation
    
    [a,b,c,d] = thetaOscillator(env,center_frequency,Q_value,threshold,0);
    
    bounds{k} = a{1};
    bounds_t{k} = b{1};
    osc_env{k} = c{1};
    nuclei{k} = d{1};
    procbar(k,length(filenames));
end
function pos=browse_field(niiFilename,cm)
% POS=BROWSE_FIELD(IMG,CM)
%
% matlab figure browser for selecting target from anatomical mri
%
% img: anatomical volume (usually from img field in Nifti)
% cm: colormap (defaults to grayscale)

if nargin<2, cm=colormap(gray); close gcf; end
if nargin<1, error('At least one argument is required.'); end

deltitx=150;
deltity=25;

% try to load nifti
try
    nii=load_untouch_nii(niiFilename);
    img=nii.img;
catch
    error('Unable to read Nifti image');
end

% set starting position to center of image
pos=size(img)/2;

stop=0;

hf=figure('units','normalized','outerposition',[0 0 1 1]);
set(hf,'MenuBar','none');
set(hf,'DockControls','off');
colormap(cm);

while gca~=stop
    
    h(1)=subplot(2,2,1); imagesc(squeeze(img(:,round(pos(2))+1,:))' );
    hold on;
    plot(pos(1),pos(3),'*');
    hold off;
    axis xy;
    set(gca,'XTick',[]);set(gca,'YTick',[]);
    p=get(gca,'pos');
    pnew=p; pnew(1)=0.05; pnew(2)=0.5; pnew(3)=0.4; pnew(4)=0.4;
    set(gca,'pos',pnew);
    htit=title(['Current position: ' num2str(round(pos(1))) ',' num2str(round(pos(2))) ',' num2str(round(pos(3)))]);
    titpos=get(htit,'Position');
    set(htit,'Position',[titpos(1)+deltitx titpos(2)+deltity titpos(3)]);
    
    h(2)=subplot(2,2,2);
    imagesc(squeeze(img(round(pos(1))+1,:,:))' );
    hold on;
    plot(pos(2),pos(3),'*');
    hold off;
    axis xy;
    set(gca,'XTick',[]);set(gca,'YTick',[]);
    p=get(gca,'pos');
    pnew=p; pnew(1)=0.5; pnew(2)=0.5; pnew(3)=0.4; pnew(4)=0.4;
    set(gca,'pos',pnew);
    %title([num2str(round(pos(1))) ',' num2str(round(pos(2))) ',' num2str(round(pos(3)))]);
    
    h(3)=subplot(2,2,3);
    imagesc(squeeze(img(:,:,round(pos(3))+1))' );
    hold on;
    plot(pos(1),pos(2),'*');
    hold off;
    axis xy;
    set(gca,'XTick',[]);set(gca,'YTick',[]);
    p=get(gca,'pos');
    pnew=p; pnew(1)=0.05; pnew(2)=0.05; pnew(3)=0.4; pnew(4)=0.4;
    set(gca,'pos',pnew);
    %title([num2str(round(pos(1))) ',' num2str(round(pos(2))) ',' num2str(round(pos(3)))]);
    
    stop=subplot(2,2,4);
    htxt=text(0,0.5,'Finalize Electrode Position');
    set(htxt,'FontSize',20);
    set(htxt,'LineWidth',2);
    set(htxt,'EdgeColor',[0.7 0.7 0.7]);
    set(htxt,'BackgroundColor',[1 1 1]);
    set(htxt,'Color',[0.7 0.7 0.7]);
    axis off
    
    newpos = ginput(1);
    %[newpos_x,newpos_y] = ginputc(1,'Color','y');
    %newpos=[newpos_x,newpos_y];
    
    switch gca
        case h(1); pos([1 3]) = newpos;
        case h(2); pos([2 3]) = newpos;
        case h(3); pos([1 2]) = newpos;
    end
    
end

close gcf

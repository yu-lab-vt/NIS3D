function [newLabel, comMaps] = refineOneRegion_with_seed_forSmartSeed_2D(seed_id, comMaps,option)
% refine the seed region indicate by index in yxz

% It remove the crop part outside for parallel computation 
% by mengfan  10/05/2022

% NOTE: it is possible the yxz is not exactly the same as seed_id label
% indicates, e.g. the seed is relabeled. We view yxz as the correct one.

smartSeedRegion=comMaps.score3dMap>0;
smartSeedRegion=comMaps.score3dMap==min(comMaps.score3dMap(smartSeedRegion));

%% gap detection based on min cut
if isfield(option,"mergeFlag")&& option.mergeFlag
    comMaps.score3dMap_raw(comMaps.score3dMap_raw<0) = 0;
    min_pv = 0;
    max_pv = max(comMaps.score3dMap_raw(:));
    comMaps.score3dMap = scale_image(comMaps.score3dMap_raw, 1e-6,1, min_pv, max_pv);
else
    comMaps.score3dMap(comMaps.score3dMap<0) = 0;
    min_pv = min(comMaps.score3dMap(:));
    max_pv = max(comMaps.score3dMap(:));
    comMaps.score3dMap = scale_image(comMaps.score3dMap, 1e-6,1, min_pv, max_pv);
end

fMap = comMaps.regComp;
fMap = imdilate(fMap,strel_ker);
otherSeedMap=(comMaps.idComp ~= seed_id) & (comMaps.idComp > 0);
fMap(otherSeedMap) = 0;
% com = bwconncomp(comMaps.newIdComp);
% com = bwconncomp(imdilate(comMaps.newIdComp,strel_ker_seed));

com = imdilate(comMaps.newIdComp,strel_ker_seed)>0;
if isfield(option,"NotDiaFlag")&& option.NotDiaFlag
    com = comMaps.newIdComp>0;
end
if isfield(option,"DiaDSz") && option.DiaDSz>0
    com = imdilate(comMaps.newIdComp,strel("disk",option.DiaDSz))>0;
end

newLabel = zeros(size(fMap));

sMap = false(size(fMap));
sMap(com) = true;
tMap = true(size(fMap));
tMap(fMap) = false;
% scoreMap = comMaps.score3dMap;
% comMaps.score3dMap(comMaps.score3dMap<0) = 0;
if isfield(option,"smartSeedFlag")&& option.smartSeedFlag
    if max(smartSeedRegion(sMap))==0
        sMap=getSmartSeed(comMaps.score3dMap,fMap,sMap,smartSeedRegion);
    end
end
[dat_in, src, sink] = graphCut_negHandle_mat_v2(comMaps.score3dMap, fMap, sMap, ...
    tMap, 10, [1 option.costDesign], true);       % before fusion

G = digraph(dat_in(:,1),dat_in(:,2),dat_in(:,3));
if ~isempty(find(isnan(dat_in(:)), 1)) || isnan(sink)
    return;
end
[~,~,cs,~] = maxflow(G, src, sink); % cs: fg, ct: bg
cs = cs(cs<=numel(newLabel));

cur_l = newLabel(cs);
if length(unique(cur_l))>2
    keyboard;
end
newLabel(cs) = 1;




end
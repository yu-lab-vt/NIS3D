function curvature=PrcplCrvtr_scaleInvariant_1D_v1d1(y,smFactorLst)
%scale invariant principal curvature detection v1.0
% curvature=PrcplCrvtr_scaleInvariant_1D_v1d0(y) return the curvature of y
% find the first local max curvature



y=y(:)';


N_smNum=length(smFactorLst);

curvature_all=zeros(N_smNum,length(y));


curFltr=[0.25 0 -0.5 0 0.25];
for smCnt=1:N_smNum
    smFactor=smFactorLst(smCnt);
    gauFltr_0=normpdf(-smFactor*10:smFactor*10,0,smFactor);
    gauFltr=gauFltr_0/sum(gauFltr_0);
    finalFltr=conv(curFltr,gauFltr);
    finalFltr=finalFltr/sum(abs(finalFltr));
    SZpad=length(finalFltr);
    y_pad=[ones(1,SZpad)*y(1) y ones(1,SZpad)*y(end)];
    y1=conv(y_pad,finalFltr);
    newSZpad=(SZpad-1)/2+SZpad;
    y_2=y1(1+newSZpad:end-newSZpad);
    curvature_all(smCnt,:)=y_2;
end

locLst=findFirstLocalMaxMin(curvature_all);

curvature=curvature_all(locLst+(0:length(locLst)-1)*N_smNum);

end
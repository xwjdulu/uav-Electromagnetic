
function r = Takerep(M)
    
    [C,ia,ic] = unique(M,'rows','last');
    A_counts = accumarray(ic,1);
    value_counts = [C,A_counts]; 
    [r0,~,~] = find(A_counts(:,1)>1);
    r = C(r0);
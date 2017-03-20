function indexed=returnindexed(source,idx1,idx2)
% indexed=returnindexed(source,index1,index2)
% return source indexed sequentially by index1 and index2, e.g.
% source(idx1)(idx2)
indexed = source(idx1);
indexed = indexed(idx2);

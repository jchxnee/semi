package com.kh.semi.mappers;

import com.kh.semi.domain.vo.Storage;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import java.util.ArrayList;

@Mapper
public interface StorageMapper {

    ArrayList<Storage> selectStorage(int storeId);
    int insertStorage(Storage storage);
    int deleteStorage(int storageNo);
    int storageCount(int storeId);
    ArrayList<Storage> selectStorageList(RowBounds rowBounds, int storeId);
    ArrayList<Storage> getStorageList();

    int updateStorageAmount(int storageNo, int storeId, int amount);

    int minusStorageAmount(int storageNo, int amount);

    Storage searchStorage(int storageNo);

}

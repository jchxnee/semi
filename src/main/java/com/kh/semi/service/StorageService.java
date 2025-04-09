package com.kh.semi.service;

import com.kh.semi.domain.vo.PageInfo;
import com.kh.semi.domain.vo.Storage;

import java.util.ArrayList;

public interface StorageService {
    ArrayList<Storage> selectStorage(int storeId);
    int insertStorage(Storage storage);
    int deleteStorage(int storageNo);
    int StorageCount();
    ArrayList<Storage> selectStorageList(PageInfo pi, int storeId);
    ArrayList<Storage> getStorageList();
    int updateStorageAmount(int storageNo, int amount);
    int minusStorageAmount(int storageNo, int amount);
}

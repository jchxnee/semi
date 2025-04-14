package com.kh.semi.service;

import com.kh.semi.domain.vo.PageInfo;
import com.kh.semi.domain.vo.Storage;
import com.kh.semi.domain.vo.Product;
import com.kh.semi.mappers.ProductMapper;
import com.kh.semi.mappers.StorageMapper;
import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@RequiredArgsConstructor
@Service
public class StorageServiceImpl implements StorageService {

    private final StorageMapper storageMapper;

    @Override
    public ArrayList<Storage> selectStorage(int storeId) {
        return storageMapper.selectStorage(storeId);
    }

    @Override
    public int insertStorage(Storage storage) {
        return storageMapper.insertStorage(storage);
    }

    @Override
    public int deleteStorage(int storageNo) {
        return storageMapper.deleteStorage(storageNo);
    }

    @Override
    public int StorageCount(int storeId) {
        return storageMapper.storageCount(storeId);
    }

    @Override
    public ArrayList<Storage> selectStorageList(PageInfo pi, int storeId) {
        int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
        RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
        return storageMapper.selectStorageList(rowBounds, storeId);
    }

    public ArrayList<Storage> getStorageList() { return storageMapper.getStorageList(); }

    @Override
    public int updateStorageAmount(int storageNo, int storeId, int amount) {
        return storageMapper.updateStorageAmount(storageNo, storeId, amount);
    }

    @Override
    public int minusStorageAmount(int storageNo, int amount) {
        return storageMapper.minusStorageAmount(storageNo,amount);
    }

    @Override
    public Storage searchStorage(int storageNo) {
        return storageMapper.searchStorage(storageNo);
    }
}

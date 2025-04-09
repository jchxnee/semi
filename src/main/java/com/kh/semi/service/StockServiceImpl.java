package com.kh.semi.service;

import com.kh.semi.domain.vo.PageInfo;
import com.kh.semi.domain.vo.Stock;
import com.kh.semi.domain.vo.StockProduct;
import com.kh.semi.mappers.StockMapper;
import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@RequiredArgsConstructor
@Service
public class StockServiceImpl implements StockService {
    private final StockMapper stockMapper;

    @Override
    public ArrayList<Stock> selectStockList(int empNo) {
        return stockMapper.selectStockList(empNo);
    }

    @Override
    public ArrayList<Stock> searchStockInList(String stockStatus, String startDate, String endDate, int empNo) {
        return stockMapper.searchStockInList(stockStatus, startDate, endDate, empNo);
    }

    @Override
    public ArrayList<Stock> searchStockOutList(String stockStatus, String startDate, String endDate, int empNo) {
        return stockMapper.searchStockOutList(stockStatus, startDate, endDate, empNo);
    }

    @Override
    public int insertStockIn(Stock stock) {
        return stockMapper.insertStockIn(stock);
    }

    @Override
    public int insertStockOut(Stock stock) {
        return stockMapper.insertStockOut(stock);
    }

    @Override
    public int insertStockProduct(StockProduct stockProduct) {
        return stockMapper.insertStockProduct(stockProduct);
    }

    @Override
    public ArrayList<StockProduct> selectStockProductList(int empNo) {
        return stockMapper.selectStockProductList(empNo);
    }

    @Override
    public int updateStockInStatus(int stockNo) {
        return stockMapper.updateStockInStatus(stockNo);
    }

    @Override
    public int updateStockOutStatus(int stockNo) {
        return stockMapper.updateStockOutStatus(stockNo);
    }

    @Override
    public int deleteStock(int stockNo) {
        return stockMapper.deleteStock(stockNo);
    }

    public int deleteStockProduct(int stockNo){
        return stockMapper.deleteStockProduct(stockNo);
    }

    @Override
    public Stock selectStock(int stockNo) {
        return stockMapper.selectStock(stockNo);
    }

    @Override
    public ArrayList<StockProduct> selectStockProduct(int stockNo) {
        return stockMapper.selectStockProduct(stockNo);
    }

    @Override
    public int updateCompletedStockIn() {
        return stockMapper.updateCompletedStockIn();
    }

    @Override
    public ArrayList<Stock> selectCompletedStockIn() {
        return stockMapper.selectCompletedStockIn();
    }

    @Override
    public int updateStockProcessedStatus(int stockNo) {
        return stockMapper.updateStockProcessedStatus(stockNo);
    }

    @Override
    public int selectStockListforPaging() {
        return stockMapper.selectStockListforPaging();
    }

    @Override
    public ArrayList<Stock> selectStockListByPage(PageInfo pi) {
        int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
        RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
        return stockMapper.selectStockListByPage(rowBounds);
    }

}

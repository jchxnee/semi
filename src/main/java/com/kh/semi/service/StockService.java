package com.kh.semi.service;

import com.kh.semi.domain.vo.PageInfo;
import com.kh.semi.domain.vo.Stock;
import com.kh.semi.domain.vo.StockProduct;

import java.util.ArrayList;

public interface StockService {
    ArrayList<Stock> selectStockList();
    ArrayList<Stock> searchStockInList(String stockStatus, String startDate, String endDate);
    ArrayList<Stock> searchStockOutList(String stockStatus, String startDate, String endDate);
    int insertStockIn(Stock stock);
    int insertStockOut(Stock stock);
    int insertStockProduct(StockProduct stockProduct);
    ArrayList<StockProduct> selectStockProductList();
    int updateStockInStatus(int stockNo);
    int updateStockOutStatus(int stockNo);
    int deleteStock(int stockNo);
    int deleteStockProduct(int stockNo);
    Stock selectStock(int stockNo);
    ArrayList<StockProduct> selectStockProduct(int stockNo);
    int updateCompletedStockIn();
    ArrayList<Stock> selectCompletedStockIn(); // COMPLETED + Y 인 애들
    int updateStockProcessedStatus(int stockNo); // STATUS = 'C'로 변경

    // 입고 페이지 페이징 처리
    int selectStockListforPaging();
    ArrayList<Stock> selectStockListByPage(PageInfo pi);
}

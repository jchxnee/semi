package com.kh.semi.mappers;

import com.kh.semi.domain.vo.PageInfo;
import com.kh.semi.domain.vo.Stock;
import com.kh.semi.domain.vo.StockProduct;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;

import java.util.ArrayList;

@Mapper
public interface StockMapper {
    int insertStockIn(Stock stock);
    int insertStockOut(Stock stock);
    int insertStockProduct(StockProduct stockProduct);
    ArrayList<StockProduct> selectStockProductList(int empNo);
    int updateStockInStatus(int stockNo);
    int updateStockOutStatus(int stockNo);
    int deleteStock(int stockNo);
    int deleteStockProduct(int stockNo);
    Stock selectStock(int stockNo);
    ArrayList<StockProduct> selectStockProduct(int stockNo);

    //입고완료
    int updateCompletedStockIn();
    ArrayList<Stock> selectCompletedStockIn();
    int updateStockProcessedStatus(int stockNo);

    //출고완료
    int updateCompletedStockOut();
    ArrayList<Stock> selectCompletedStockOut();

    int countStockIn(int empNo);
    int countStockOut(int empNo);

    int selectStockInListforPaging(int empNo, String status, String startDate, String endDate);
    ArrayList<Stock> selectStockInListByPage(int empNo, String status, String startDate, String endDate, RowBounds rowBounds);

    int selectStockOutListforPaging(int empNo, String status, String startDate, String endDate);
    ArrayList<Stock> selectStockOutListByPage(int empNo, String status, String startDate, String endDate, RowBounds rowBounds);
}

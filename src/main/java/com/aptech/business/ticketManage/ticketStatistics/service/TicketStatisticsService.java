package com.aptech.business.ticketManage.ticketStatistics.service;

import java.util.List;
import java.util.Map;

import com.aptech.business.ticketManage.ticketStatistics.domain.TicketStatisticsVO;
import com.aptech.framework.orm.IBaseEntityOperation;


/**
 * 两票统计服务接口
 * @author Administrator
 *
 */
public interface TicketStatisticsService  extends IBaseEntityOperation<TicketStatisticsVO> {
	
	/**
	 * 取得统计数据
	 * @param unitId 组织ID
	 * @param searchYear 查询年
	 * @return
	 */
	List<Map<String, String>> getStatisticDataList(String unitId, String searchYear);
}
package dao;

import java.util.List;

import dto.OrderListDto;


public interface iOrderListDao {

	public List<OrderListDto> getOrderList();	//list
	
	public Boolean addorder(OrderListDto dto); //주문 추가
	
	public boolean insertOrderList(List<OrderListDto> list);
	
	public List<OrderListDto> getResultList(String _today,String order_email); //주문 추가 결과list
	
	
}

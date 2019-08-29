package dao;

import java.util.List;

import dto.MemberDto;
import dto.MyOrderListDto;
import dto.ProductDto;
import dto.StoreQnADto;

public interface iStoreDao {
	public int getPageCount(String product_category);
	
	public List<ProductDto> getProductList(String product_category, int page);
	
	public ProductDto detailProduct(int seq);
	
	public List<StoreQnADto> getQnAList(int product_seq, int page);
	
	public int getQnAPageCount(int product_seq);
	
	public boolean writeQnA(StoreQnADto dto);
	
	public StoreQnADto deatilQnA(int seq);
	
	public boolean updateQnA(StoreQnADto dto);
	
	public boolean deleteQnA(int seq);
	
	public List<MyOrderListDto> getMyOrder(String email);	//마이페이지 내 주문내역
	//public MemberDto login(String loginid, String loginpw);
}

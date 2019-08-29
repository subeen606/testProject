package dao;

import java.util.List;

import dto.ScheduleDto;
import dto.StoreQnADto;
import dto.OrderListDto;
import dto.ProductDto;

public interface iAdminDao {
	
	public int getSchedulePages(String searchCategory, String searchTxt);
	
	public List<ScheduleDto> getScheduleList(String searchCategory, String searchTxt, int page);
	
	public boolean writeSchedule(ScheduleDto dto);
	
	public ScheduleDto ScheduleDetail(int seq);
	
	public boolean updateSchedule(ScheduleDto dto);
	
	public boolean deleteSchedule(String[] seq);
	
	public boolean addProduct(ProductDto dto);
	
	public List<ProductDto> getProduct(int pCount);
	
	public ProductDto detailProduct(int seq);
	
	public boolean updateProduct(ProductDto dto);
	
	public boolean deleteProduct(int seq);
	
	public String findImg(int seq);
	
	public int countProduct();
	
	public int findingCount(String sel,String fText);
	
	public List<ProductDto> findProduct(String sel,String fText,int pCount);
	
	public int getQnAPageCount(String category, String search, String searchtxt);
	
	public List<StoreQnADto> getQnAList(String category, String search, String searchtxt, int page);
	
	public StoreQnADto detailQnA(int seq);
	
	public boolean replyQnA(int seq, StoreQnADto dto);
	
	public boolean deleteQnA(String[] seq);
	
	public boolean updatecount(int product_seq, String product_size, int product_count, int num); //재고수
	
	public int searchnum(int product_seq, String product_size);
	
	public List<dto.OrderListDto> TodayOrderList(String today);
	
	public List<StoreQnADto> TodayQnAList(String today);
	
	public List<dto.MemberDto> getMember(int mCount);
	
	public int CountMember();
	
	public int findCountMember(String sel,String fText);
	
	public List<dto.MemberDto> findMember(String sel, String fText,int mCount);
	
	public boolean DeleteMember(int seq);
	
	public dto.MemberDto memberDetail(int seq);
	
	public List<Integer> MonthlyTotalPrice(String month[]);
	
	public List<Integer> MonthlyTotalCount(String month[]);

	public List<OrderListDto> order_list(int oCount);
	
	public int CountOrder();
	
	public OrderListDto Order_Detail(int seq);

	public int FindOrderCount(String sel,String fText);
	
	public List<OrderListDto> FindOrderList(String sel, String fText,int oCount);
}

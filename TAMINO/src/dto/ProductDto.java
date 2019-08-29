package dto;

import java.io.Serializable;
/*
CREATE TABLE SHOP(		
	PRODUCT_SEQ NUMBER(5) PRIMARY KEY,	
	CODE_NUMBER VARCHAR2(20) NOT NULL,	
	PRODUCT_NAME VARCHAR2(200) NOT NULL,
	PRICE NUMBER(8) NOT NULL,
	PRODUCT_EXPLAIN VARCHAR2(4000) NOT NULL,
	PRODUCT_IMAGE VARCHAR2(1000) NOT NULL,
	
	COUNT_S VARCHAR2(30),  
	COUNT_M VARCHAR2(30),
	COUNT_L VARCHAR2(30),
	COUNT_O VARCHAR2(30),
	PRODUCT_SIZE VARCHAR2(100) NOT NULL
);
*/
public class ProductDto implements Serializable{
	private int seq;	//seq
	private String code;	//분류번호
	private String productName;	//상품명
	private int price;	//가격
	private String productExplain;	//상품설명
	private String productImage;	//상품이미지
	
	private int count_s;	//s재고수
	private int count_m;	//m재고수
	private int count_l;	//l재고수
	private int count_o;	//o재고수
	private String productSize;		//사이즈(의류인경우에만 기입)

	
	public ProductDto() {
		
	}


	public ProductDto(int seq, String code, String productName, int price, String productExplain, String productImage,
			int count_s, int count_m, int count_l, int count_o, String productSize) {
		super();
		this.seq = seq;
		this.code = code;
		this.productName = productName;
		this.price = price;
		this.productExplain = productExplain;
		this.productImage = productImage;
		this.count_s = count_s;
		this.count_m = count_m;
		this.count_l = count_l;
		this.count_o = count_o;
		this.productSize = productSize;
	}


	public ProductDto(String code, String productName, int price, String productExplain, String productImage,
			int count_s, int count_m, int count_l, int count_o, String productSize) {
		super();
		this.code = code;
		this.productName = productName;
		this.price = price;
		this.productExplain = productExplain;
		this.productImage = productImage;
		this.count_s = count_s;
		this.count_m = count_m;
		this.count_l = count_l;
		this.count_o = count_o;
		this.productSize = productSize;
	}


	public int getSeq() {
		return seq;
	}


	public void setSeq(int seq) {
		this.seq = seq;
	}


	public String getCode() {
		return code;
	}


	public void setCode(String code) {
		this.code = code;
	}


	public String getProductName() {
		return productName;
	}


	public void setProductName(String productName) {
		this.productName = productName;
	}


	public int getPrice() {
		return price;
	}


	public void setPrice(int price) {
		this.price = price;
	}


	public String getProductExplain() {
		return productExplain;
	}


	public void setProductExplain(String productExplain) {
		this.productExplain = productExplain;
	}


	public String getProductImage() {
		return productImage;
	}


	public void setProductImage(String productImage) {
		this.productImage = productImage;
	}


	public int getCount_s() {
		return count_s;
	}


	public void setCount_s(int count_s) {
		this.count_s = count_s;
	}


	public int getCount_m() {
		return count_m;
	}


	public void setCount_m(int count_m) {
		this.count_m = count_m;
	}


	public int getCount_l() {
		return count_l;
	}


	public void setCount_l(int count_l) {
		this.count_l = count_l;
	}


	public int getCount_o() {
		return count_o;
	}


	public void setCount_o(int count_o) {
		this.count_o = count_o;
	}


	public String getProductSize() {
		return productSize;
	}


	public void setProductSize(String productSize) {
		this.productSize = productSize;
	}


	@Override
	public String toString() {
		return "ProductDto [seq=" + seq + ", code=" + code + ", productName=" + productName + ", price=" + price
				+ ", productExplain=" + productExplain + ", productImage=" + productImage + ", count_s=" + count_s
				+ ", count_m=" + count_m + ", count_l=" + count_l + ", count_o=" + count_o + ", productSize="
				+ productSize + "]";
	}

	
	

	
}

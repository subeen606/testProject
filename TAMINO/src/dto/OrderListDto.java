package dto;
//////////////dto변경 많음
import java.io.Serializable;

public class OrderListDto implements Serializable{
	private int oderlist_seq;
	
	private String order_date;
	private String order_email;
	private String order_name;
	private String order_address;
	private String order_phonenumber;
	private String order_request;
	
	private int product_seq;
	private String product_name;
	private String product_image;
	private String product_size;
	private int product_count;
	private int product_price;
	
	private int delivery_status;
	
	public OrderListDto() {
	}

	public OrderListDto(int oderlist_seq, String order_date, String order_email, String order_name, String order_address,
			String order_phonenumber, String order_request, int product_seq, String product_name, String product_image,
			String product_size, int product_count, int product_price, int delivery_status) {
		super();
		this.oderlist_seq = oderlist_seq;
		this.order_date = order_date;
		this.order_email = order_email;
		this.order_name = order_name;
		this.order_address = order_address;
		this.order_phonenumber = order_phonenumber;
		this.order_request = order_request;
		this.product_seq = product_seq;
		this.product_name = product_name;
		this.product_image = product_image;
		this.product_size = product_size;
		this.product_count = product_count;
		this.product_price = product_price;
		this.delivery_status = delivery_status;
	}
///my주문내역
	public OrderListDto(String order_date, String product_name, String product_image, String product_size,
			int product_count, int product_price, int delivery_status) {
		super();
		this.order_date = order_date;
		this.product_name = product_name;
		this.product_image = product_image;
		this.product_size = product_size;
		this.product_count = product_count;
		this.product_price = product_price;
		this.delivery_status = delivery_status;
	}

	public OrderListDto(String order_email, int product_seq, String product_name, String product_image,
			String product_size, int product_count, int product_price) {
		super();
		this.order_email = order_email;
		this.product_seq = product_seq;
		this.product_name = product_name;
		this.product_image = product_image;
		this.product_size = product_size;
		this.product_count = product_count;
		this.product_price = product_price;
	}
	
	///추가//////////////////////////////////////////////
	////주문할때 들어갈것///////////////////
	public OrderListDto(String order_email, String order_name, String order_address, String order_phonenumber,
			String order_request, int product_seq, String product_name, String product_image, String product_size,
			int product_count, int product_price) {
		super();
		this.order_email = order_email;
		this.order_name = order_name;
		this.order_address = order_address;
		this.order_phonenumber = order_phonenumber;
		this.order_request = order_request;
		this.product_seq = product_seq;
		this.product_name = product_name;
		this.product_image = product_image;
		this.product_size = product_size;
		this.product_count = product_count;
		this.product_price = product_price;
	}
	
	



	public int getOderlist_seq() {
		return oderlist_seq;
	}

	public void setOderlist_seq(int oderlist_seq) {
		this.oderlist_seq = oderlist_seq;
	}

	public String getOrder_date() {
		return order_date;
	}

	public void setOrder_date(String order_date) {
		this.order_date = order_date;
	}

	public String getOrder_email() {
		return order_email;
	}

	public void setOrder_email(String order_email) {
		this.order_email = order_email;
	}

	public String getOrder_name() {
		return order_name;
	}

	public void setOrder_name(String order_name) {
		this.order_name = order_name;
	}

	public String getOrder_address() {
		return order_address;
	}

	public void setOrder_address(String order_address) {
		this.order_address = order_address;
	}

	public String getOrder_phonenumber() {
		return order_phonenumber;
	}

	public void setOrder_phonenumber(String order_phonenumber) {
		this.order_phonenumber = order_phonenumber;
	}

	public String getOrder_request() {
		return order_request;
	}

	public void setOrder_request(String order_request) {
		this.order_request = order_request;
	}

	public int getProduct_seq() {
		return product_seq;
	}

	public void setProduct_seq(int product_seq) {
		this.product_seq = product_seq;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public String getProduct_image() {
		return product_image;
	}

	public void setProduct_image(String product_image) {
		this.product_image = product_image;
	}

	public String getProduct_size() {
		return product_size;
	}

	public void setProduct_size(String product_size) {
		this.product_size = product_size;
	}

	public int getProduct_count() {
		return product_count;
	}

	public void setProduct_count(int product_count) {
		this.product_count = product_count;
	}

	public int getProduct_price() {
		return product_price;
	}

	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}

	public int getDelivery_status() {
		return delivery_status;
	}

	public void setDelivery_status(int delivery_status) {
		this.delivery_status = delivery_status;
	}

	@Override
	public String toString() {
		return "OrderListDto [oderlist_seq=" + oderlist_seq + ", order_date=" + order_date + ", order_email="
				+ order_email + ", order_name=" + order_name + ", order_address=" + order_address
				+ ", order_phonenumber=" + order_phonenumber + ", order_request=" + order_request + ", product_seq="
				+ product_seq + ", product_name=" + product_name + ", product_image=" + product_image
				+ ", product_size=" + product_size + ", product_count=" + product_count + ", product_price="
				+ product_price + ", delivery_status=" + delivery_status + "]";
	}

}

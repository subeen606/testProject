package dto;

import java.io.Serializable;

public class MyOrderListDto implements Serializable{

	private String order_date;

	
	private String product_name;
	private String product_image;
	private String product_size;
	private String product_count;
	private String product_price;
	
	private String delivery_status;

	public MyOrderListDto(String order_date, String product_name, String product_image, String product_size,
			String product_count, String product_price, String delivery_status) {
		super();
		this.order_date = order_date;
		this.product_name = product_name;
		this.product_image = product_image;
		this.product_size = product_size;
		this.product_count = product_count;
		this.product_price = product_price;
		this.delivery_status = delivery_status;
	}

	public String getOrder_date() {
		return order_date;
	}

	public void setOrder_date(String order_date) {
		this.order_date = order_date;
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

	public String getProduct_count() {
		return product_count;
	}

	public void setProduct_count(String product_count) {
		this.product_count = product_count;
	}

	public String getProduct_price() {
		return product_price;
	}

	public void setProduct_price(String product_price) {
		this.product_price = product_price;
	}

	public String getDelivery_status() {
		return delivery_status;
	}

	public void setDelivery_status(String delivery_status) {
		this.delivery_status = delivery_status;
	}

	@Override
	public String toString() {
		return "MyOrderListDto [order_date=" + order_date + ", product_name=" + product_name + ", product_image="
				+ product_image + ", product_size=" + product_size + ", product_count=" + product_count
				+ ", product_price=" + product_price + ", delivery_status=" + delivery_status + "]";
	}
	
	
	
	
}

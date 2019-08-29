package dto;

import java.io.Serializable;

public class StoreQnADto implements Serializable{
	
	/*
	CREATE TABLE STORE_QNA(
	QNA_SEQ NUMBER(5) PRIMARY KEY,
	
	QNA_PRODUCT_SEQ NUMBER(5) NOT NULL,
	
	QNA_TITLE VARCHAR2(200) NOT NULL,
	QNA_CATEGORY VARCHAR2(50) NOT NULL,
	QNA_CONTENT VARCHAR2(2000) NOT NULL,
	QNA_WDATE DATE NOT NULL,
	QNA_EMAIL VARCHAR2(100) NOT NULL,
	
	QNA_DEL NUMBER(5) NOT NULL,
	
	QNA_REF NUMBER(8) NOT NULL,
	QNA_STEP NUMBER(8) NOT NULL,
	QNA_DEPTH NUMBER(8) NOT NULL
	);
	 */
	
	private int qna_seq;
	
	private int qna_product_seq;
	
	private String qna_title;
	private String qna_category;
	private String qna_content;
	private String qna_wdate;
	private String qna_email;
	
	private int qna_del;
	
	private int qna_ref;
	private int qna_step;
	private int qna_depth;
	
	private int qna_parent;
	
	public StoreQnADto() {
	}

	public StoreQnADto(int qna_seq, int qna_product_seq, String qna_title, String qna_category, String qna_content,
			String qna_wdate, String qna_email, int qna_del, int qna_ref, int qna_step, int qna_depth, int qna_parent) {
		super();
		this.qna_seq = qna_seq;
		this.qna_product_seq = qna_product_seq;
		this.qna_title = qna_title;
		this.qna_category = qna_category;
		this.qna_content = qna_content;
		this.qna_wdate = qna_wdate;
		this.qna_email = qna_email;
		this.qna_del = qna_del;
		this.qna_ref = qna_ref;
		this.qna_step = qna_step;
		this.qna_depth = qna_depth;
		this.qna_parent = qna_parent;
	}

	public StoreQnADto(int qna_product_seq, String qna_title, String qna_category, String qna_content, String qna_wdate,
			String qna_email) {
		super();
		this.qna_product_seq = qna_product_seq;
		this.qna_title = qna_title;
		this.qna_category = qna_category;
		this.qna_content = qna_content;
		this.qna_wdate = qna_wdate;
		this.qna_email = qna_email;
	}

	public int getQna_seq() {
		return qna_seq;
	}

	public void setQna_seq(int qna_seq) {
		this.qna_seq = qna_seq;
	}

	public int getQna_product_seq() {
		return qna_product_seq;
	}

	public void setQna_product_seq(int qna_product_seq) {
		this.qna_product_seq = qna_product_seq;
	}

	public String getQna_title() {
		return qna_title;
	}

	public void setQna_title(String qna_title) {
		this.qna_title = qna_title;
	}

	public String getQna_category() {
		return qna_category;
	}

	public void setQna_category(String qna_category) {
		this.qna_category = qna_category;
	}

	public String getQna_content() {
		return qna_content;
	}

	public void setQna_content(String qna_content) {
		this.qna_content = qna_content;
	}

	public String getQna_wdate() {
		return qna_wdate;
	}

	public void setQna_wdate(String qna_wdate) {
		this.qna_wdate = qna_wdate;
	}

	public String getQna_email() {
		return qna_email;
	}

	public void setQna_email(String qna_email) {
		this.qna_email = qna_email;
	}
	

	public int getQna_del() {
		return qna_del;
	}

	public void setQna_del(int qna_del) {
		this.qna_del = qna_del;
	}

	public int getQna_ref() {
		return qna_ref;
	}

	public void setQna_ref(int qna_ref) {
		this.qna_ref = qna_ref;
	}

	public int getQna_step() {
		return qna_step;
	}

	public void setQna_step(int qna_step) {
		this.qna_step = qna_step;
	}

	public int getQna_depth() {
		return qna_depth;
	}

	public void setQna_depth(int qna_depth) {
		this.qna_depth = qna_depth;
	}

	public int getQna_parent() {
		return qna_parent;
	}

	public void setQna_parent(int qna_parent) {
		this.qna_parent = qna_parent;
	}

	@Override
	public String toString() {
		return "StoreQnADto [qna_seq=" + qna_seq + ", qna_product_seq=" + qna_product_seq + ", qna_title=" + qna_title
				+ ", qna_category=" + qna_category + ", qna_content=" + qna_content + ", qna_wdate=" + qna_wdate
				+ ", qna_email=" + qna_email + ", qna_del=" + qna_del + ", qna_ref=" + qna_ref + ", qna_step="
				+ qna_step + ", qna_depth=" + qna_depth + "]";
	}
	
	

}

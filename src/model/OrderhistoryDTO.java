package model;

public class OrderhistoryDTO
{
	private int order_code;
	private String user_id;
	private String orderer_name;
	private String orderer_mobile;
	private String orderer_general;
	private String orderer_email;
	private String recipient_name;
	private String recipient_mobile;
	private String recipient_general;
	private String postal_code;
	private String road;
	private String number;
	private String detail;
	private String requested_term;
	private int total_price;
	private String payment_method;
	private String delivery_method;

	public int getOrder_code()
	{
		return order_code;
	}

	public String getUser_id()
	{
		return user_id;
	}

	public String getOrderer_name()
	{
		return orderer_name;
	}

	public String getOrderer_mobile()
	{
		return orderer_mobile;
	}

	public String getOrderer_general()
	{
		return orderer_general;
	}

	public String getOrderer_email()
	{
		return orderer_email;
	}

	public String getRecipient_name()
	{
		return recipient_name;
	}

	public String getRecipient_mobile()
	{
		return recipient_mobile;
	}

	public String getRecipient_general()
	{
		return recipient_general;
	}

	public String getPostal_code()
	{
		return postal_code;
	}

	public String getRoad()
	{
		return road;
	}

	public String getNumber()
	{
		return number;
	}

	public String getDetail()
	{
		return detail;
	}

	public String getRequested_term()
	{
		return requested_term;
	}

	public int getTotal_price()
	{
		return total_price;
	}

	public String getPayment_method()
	{
		return payment_method;
	}

	public String getDelivery_method()
	{
		return delivery_method;
	}

	public OrderhistoryDTO setOrder_code(int order_code)
	{
		this.order_code = order_code;
		return this;
	}

	public OrderhistoryDTO setUser_id(String user_id)
	{
		this.user_id = user_id;
		return this;
	}

	public OrderhistoryDTO setOrderer_name(String orderer_name)
	{
		this.orderer_name = orderer_name;
		return this;
	}

	public OrderhistoryDTO setOrderer_mobile(String orderer_mobile)
	{
		this.orderer_mobile = orderer_mobile;
		return this;
	}

	public OrderhistoryDTO setOrderer_general(String orderer_general)
	{
		this.orderer_general = orderer_general;
		return this;
	}

	public OrderhistoryDTO setOrderer_email(String orderer_email)
	{
		this.orderer_email = orderer_email;
		return this;
	}

	public OrderhistoryDTO setRecipient_name(String recipient_name)
	{
		this.recipient_name = recipient_name;
		return this;
	}

	public OrderhistoryDTO setRecipient_mobile(String recipient_mobile)
	{
		this.recipient_mobile = recipient_mobile;
		return this;
	}

	public OrderhistoryDTO setRecipient_general(String recipient_general)
	{
		this.recipient_general = recipient_general;
		return this;
	}

	public OrderhistoryDTO setPostal_code(String postal_code)
	{
		this.postal_code = postal_code;
		return this;
	}

	public OrderhistoryDTO setRoad(String road)
	{
		this.road = road;
		return this;
	}

	public OrderhistoryDTO setNumber(String number)
	{
		this.number = number;
		return this;
	}

	public OrderhistoryDTO setDetail(String detail)
	{
		this.detail = detail;
		return this;
	}

	public OrderhistoryDTO setRequested_term(String requested_term)
	{
		this.requested_term = requested_term;
		return this;
	}

	public OrderhistoryDTO setTotal_price(int total_price)
	{
		this.total_price = total_price;
		return this;
	}

	public OrderhistoryDTO setPayment_method(String payment_method)
	{
		this.payment_method = payment_method;
		return this;
	}

	public OrderhistoryDTO setDelivery_method(String delivery_method)
	{
		this.delivery_method = delivery_method;
		return this;
	}

	public OrderhistoryDTO()
	{
	}
}

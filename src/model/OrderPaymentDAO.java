package model;

import java.sql.Statement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import etc.OrderInformation;
import etc.Util;

public class OrderPaymentDAO
{
	private DataSource ds;

	public void setDataSource(DataSource ds)
	{
		this.ds = ds;
	}

	public int[] requestOrderProcessing(OrderhistoryDTO orderFormData, ArrayList<OrderInformation> ordered_items,
			String userId)
	{
		int[] codes = new int[ordered_items.size() + 1];
		final String currentTime = Util.getCurrentDateTime();

		try (Connection connection = ds.getConnection();)
		{
			String query = "INSERT INTO orderhistory VALUES (null, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement prstmt = connection.prepareStatement(query);

			prstmt.setString(1, orderFormData.getUser_id());
			prstmt.setString(2, orderFormData.getOrderer_name());
			prstmt.setString(3, orderFormData.getOrderer_mobile1());
			prstmt.setString(4, orderFormData.getOrderer_mobile2());
			prstmt.setString(5, orderFormData.getOrderer_mobile3());
			prstmt.setString(6, orderFormData.getOrderer_general1());
			prstmt.setString(7, orderFormData.getOrderer_general2());
			prstmt.setString(8, orderFormData.getOrderer_general3());
			prstmt.setString(9, orderFormData.getOrderer_email());
			prstmt.setString(10, orderFormData.getRecepient_name());
			prstmt.setString(11, orderFormData.getRecepient_mobile1());
			prstmt.setString(12, orderFormData.getRecepient_mobile2());
			prstmt.setString(13, orderFormData.getRecepient_mobile3());
			prstmt.setString(14, orderFormData.getRecepient_general1());
			prstmt.setString(15, orderFormData.getRecepient_general2());
			prstmt.setString(16, orderFormData.getRecepient_general3());
			prstmt.setString(17, orderFormData.getPostal_code());
			prstmt.setString(18, orderFormData.getRoad());
			prstmt.setString(19, orderFormData.getNumber());
			prstmt.setString(20, orderFormData.getDetail());
			prstmt.setString(21, orderFormData.getRequested_term());
			prstmt.setInt(22, orderFormData.getTotal_price());
			prstmt.setString(23, orderFormData.getPayment_method());
			prstmt.setString(24, orderFormData.getDelivery_method());
			prstmt.setString(25, currentTime);

			if (prstmt.executeUpdate() == 1)
			{
				connection.commit();
				codes[0] = getOrderOrSaleCode(currentTime, orderFormData.getUser_id(), -1); // ordercode
				prstmt.clearBatch();

				query = "INSERT INTO salehistory VALUES (null, ?, ?, ?, ?, ?, ?, ?, ?)";
				prstmt = connection.prepareStatement(query);

				for (int i = 0; i < ordered_items.size(); ++i)
				{
					prstmt.setInt(1, codes[0]);
					prstmt.setString(2, orderFormData.getUser_id());
					prstmt.setInt(3, ordered_items.get(i).getItem_code());
					prstmt.setString(4, ordered_items.get(i).getItem_category());
					prstmt.setString(5, currentTime);
					prstmt.setInt(6, ordered_items.get(i).getOrder_quantity());
					prstmt.setInt(7, ordered_items.get(i).getOrder_quantity() * ordered_items.get(i).getItem_price());
					prstmt.setString(8, "n");

					prstmt.addBatch();

				}

				if (prstmt.executeBatch().length == ordered_items.size())
				{
					connection.commit();
				}

				for (int i = 0; i < ordered_items.size(); ++i)
				{
					codes[i + 1] = getOrderOrSaleCode(currentTime, orderFormData.getUser_id(),
							ordered_items.get(i).getItem_code()); // salecode
				}
			}

			if (prstmt != null)
			{
				try
				{
					prstmt.close();
				} catch (Exception e)
				{
					e.printStackTrace();
				}

			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return codes;
	}

	public ArrayList<ItemsDTO> getItemsInfo(ArrayList<OrderInformation> informations)
	{
		String query = "SELECT item_code, item_name, item_author_code, item_publisher_code, item_selling_price, item_category_code FROM items WHERE item_code = ? AND item_category_code = ?";
		ArrayList<ItemsDTO> items = new ArrayList<ItemsDTO>();

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			ResultSet set = null;

			for (int i = 0; i < informations.size(); ++i)
			{
				prstmt.setInt(1, informations.get(i).getItem_code());
				prstmt.setString(2, informations.get(i).getItem_category());
				set = prstmt.executeQuery();

				while (set.next())
				{
					items.add(new ItemsDTO().setItem_code(set.getInt(1)).setItem_name(set.getString(2))
							.setItem_author_code(set.getInt(3)).setItem_publisher_code(set.getInt(4))
							.setItem_selling_price(set.getInt(5)).setItem_category_code(set.getString(6)));
				}
			}

			set.close();
		} catch (Exception e)
		{
			e.printStackTrace();
		}

		return items;
	}
	
	public ArrayList<ItemsDTO> getItemsInfoBasket(ArrayList<BasketDTO> basket)
	{
		String query = "SELECT item_code, item_name, item_author_code, item_publisher_code, item_selling_price, item_category_code FROM items WHERE item_code = ? AND item_category_code = ?";
		ArrayList<ItemsDTO> items = new ArrayList<ItemsDTO>();

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			ResultSet set = null;

			for (int i = 0; i < basket.size(); ++i)
			{
				prstmt.setInt(1, basket.get(i).getItem_code());
				prstmt.setString(2, basket.get(i).getCategory_code());
				set = prstmt.executeQuery();

				while (set.next())
				{
					items.add(new ItemsDTO().setItem_code(set.getInt(1)).setItem_name(set.getString(2))
							.setItem_author_code(set.getInt(3)).setItem_publisher_code(set.getInt(4))
							.setItem_selling_price(set.getInt(5)).setItem_category_code(set.getString(6)));
				}
			}

			set.close();
		} catch (Exception e)
		{
			e.printStackTrace();
		}

		return items;
	}

	public int getOrderOrSaleCode(String date, String userId, int itemCode)
	{
		String query = null;

		if (itemCode == -1) // true 면 ordercode
		{
			query = "SELECT orderhistory_order_code FROM orderhistory WHERE orderhistory_order_date = ? AND orderhistory_user_id = ?";
		} else
		{
			query = "SELECT salehistory_sale_code FROM salehistory WHERE salehistory_sale_date = ? AND salehistory_user_id = ? AND salehistory_item_code = ?";
		}
		ResultSet set = null;
		int code = 0;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setString(1, date);
			prstmt.setString(2, userId);

			if (itemCode != -1)
			{
				prstmt.setInt(3, itemCode);
			}

			set = prstmt.executeQuery();
			while (set.next())
			{
				code = set.getInt(1);
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		} finally
		{
			if (set != null)
			{
				try
				{
					set.close();
				} catch (Exception e)
				{
					e.printStackTrace();
				}
			}

		}

		return code;
	}

	public OrderhistoryDTO getOrderHistory(int orderCode, String userId)
	{
		ResultSet set = null;
		String query = "SELECT * FROM orderhistory WHERE orderhistory_order_code = ? AND orderhistory_user_id = ?";
		OrderhistoryDTO dto = new OrderhistoryDTO();

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			prstmt.setInt(1, orderCode);
			prstmt.setString(2, userId);

			set = prstmt.executeQuery();

			while (set.next())
			{
				dto.setOrder_code(orderCode).setUser_id(userId).setOrderer_name(set.getString(3))
						.setOrderer_mobile1(set.getString(4)).setOrderer_mobile2(set.getString(5))
						.setOrderer_mobile3(set.getString(6)).setOrderer_general1(set.getString(7))
						.setOrderer_general2(set.getString(8)).setOrderer_general3(set.getString(9))
						.setOrderer_email(set.getString(10)).setRecepient_name(set.getString(11))
						.setRecepient_mobile1(set.getString(12)).setRecepient_mobile2(set.getString(13))
						.setRecepient_mobile3(set.getString(14)).setRecepient_general1(set.getString(15))
						.setRecepient_general2(set.getString(16)).setRecepient_general3(set.getString(17))
						.setPostal_code(set.getString(18)).setRoad(set.getString(19)).setNumber(set.getString(20))
						.setDetail(set.getString(21)).setRequested_term(set.getString(22))
						.setTotal_price(set.getInt(23)).setPayment_method(set.getString(24))
						.setDelivery_method(set.getString(25)).setOrder_date(set.getString(26));
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		} finally
		{
			if (set != null)
			{
				try
				{
					set.close();
				} catch (Exception e)
				{
					e.printStackTrace();
				}
			}
		}
		return dto;
	}

	public SalehistoryDTO[] getSaleHistory(int[] codes) // index 1부터 판매 코드
	{
		String query = "SELECT * FROM salehistory WHERE salehistory_sale_code = ?";
		SalehistoryDTO[] data = new SalehistoryDTO[codes.length - 1];
		ResultSet set = null;

		try (Connection connection = ds.getConnection(); PreparedStatement prstmt = connection.prepareStatement(query);)
		{
			for (int i = 0; i < data.length; ++i)
			{
				prstmt.setInt(1, codes[i + 1]);
				set = prstmt.executeQuery();
			}
			for (int i = 0; set.next(); ++i)
			{
				data[i] = new SalehistoryDTO().setSale_code(set.getInt(1)).setOrder_code(set.getInt(2))
						.setUser_id(set.getString(3)).setItem_code(set.getInt(4)).setItem_category(set.getString(5))
						.setSale_date(set.getString(6)).setSale_quantity(set.getInt(7)).setTotal_price(set.getInt(8))
						.setStatus(set.getString(9));
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		} finally
		{
			if (set != null)
			{
				try
				{
					set.close();
				} catch (Exception e)
				{
					e.printStackTrace();
				}
			}
		}
		return data;
	}

	public String[] getOrderMethod(String delivery, String payment)
	{
		String query1 = "SELECT paymentmethod FROM paymentmethod WHERE paymentmethod_code = \'" + payment + "\'";
		String query2 = "SELECT deliverymethod FROM deliverymethod WHERE deliverymethod_code = \'" + delivery + "\'";
		String[] methods = new String[2];

		ResultSet set1 = null;
		ResultSet set2 = null;

		try (Connection connection = ds.getConnection(); Statement stmt = connection.createStatement();)
		{

			set1 = stmt.executeQuery(query1);
			set2 = stmt.executeQuery(query2);

			while (set1.next())
			{
				methods[0] = set1.getString(1); // payment
			}
			while (set2.next())
			{
				methods[1] = set2.getString(1); // delivery
			}

		} catch (Exception e)
		{
			e.printStackTrace();
		} finally
		{
			if (set1 != null)
			{
				try
				{
					set1.close();
				} catch (Exception e)
				{
					e.printStackTrace();
				}
			}
			if (set2 != null)
			{
				try
				{
					set2.close();
				} catch (Exception e)
				{
					e.printStackTrace();
				}
			}
		}
		return methods;
	}

	public Object[] getLatestOrderInfo(int[] codes, String userId, ServletContext sc)
	{
		Object[] objects = new Object[3];

		objects[0] = getOrderHistory(codes[0], userId); // 주문 정보 (이름, 휴대전화, 주소 등) ordercode
		objects[1] = getSaleHistory(codes); // salecodes

		Map<Integer, String> codeMap = new HashMap<Integer, String>(codes.length - 1);
		insertCodesToMap((SalehistoryDTO[]) objects[1], codeMap);

		ItemsDAO itemsDao = (ItemsDAO) sc.getAttribute("itemsDAO");
		objects[2] = itemsDao.getSimpleOrderedItemData(codeMap);

		return objects;
	}

	private void insertCodesToMap(SalehistoryDTO[] data, Map<Integer, String> map)
	{
		for (int i = 0; i < data.length; ++i)
		{
			map.put(data[i].getItem_code(), data[i].getItem_category());
		}
	}
}
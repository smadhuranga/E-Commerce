package lk.ijse.ecommerce.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class OrdersDTO {
    private String orderID;
    private String date;
    private int userID;
    private String address;
    private String city;
    private String state;
    private String zipCode;
    private String status;
    private double subTotal;
    private double shippingCost;
    private String paymentMethod;

}

package lk.ijse.ecommerce.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class ProductsDTO {
    private int itemCode;
    private String name;
    private double unitPrice;
    private String description;
    private int quantity;
    private byte[] image;
    private int categoryID;
}

package lk.ijse.ecommerce.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class CateDTO {
    private String id;
    private String name;
    private String description;
    private String status;
    private byte[] image;
}

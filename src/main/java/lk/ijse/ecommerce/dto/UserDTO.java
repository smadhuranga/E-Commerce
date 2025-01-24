package lk.ijse.ecommerce.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class UserDTO {
   private String userID;
   private String userName;
   private String email;
   private String password;
   private String role;
   private String fullName;
   private String address;
   private String phoneNumber;
   private String status;
   private String data;
   private byte[] image;

}

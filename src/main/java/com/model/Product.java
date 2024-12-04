package com.model;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.web.multipart.MultipartFile;

@Entity
@Table(name = "item")
public class Product implements Serializable {

    private static final long serialVersionUID = 5186013952828648626L;

    @Id
    @Column(name = "Id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long productId;

    @Column(name="category")
    private String productCategory;

    @SuppressWarnings("deprecation")
	@NotEmpty(message = "Product Description cannot be empty")
    @Pattern(regexp = "^[a-zA-Z0-9 ]*$", message = "Product Description cannot contain special characters")
    @Column(name = "description")
    private String productDescription;

    @SuppressWarnings("deprecation")
	@NotEmpty(message = "Product Manufacturer cannot be empty")
    @Pattern(regexp = "^[a-zA-Z0-9 ]*$", message = "Product Manufacturer cannot contain special characters")
    @Column(name = "manufacturer")
    private String productManufacturer;

    // Ràng buộc không để trống và không chứa ký tự đặc biệt
    @SuppressWarnings("deprecation")
	@NotEmpty(message = "Please provide a product name.")
    @Pattern(regexp = "^[a-zA-Z0-9 ]*$", message = "Product name must not contain special characters.")
    @Column(name = "name")
    private String productName;

    // Ràng buộc giá không được nhỏ hơn 0
    @NotNull(message = "Product price cannot be null.")
    @Min(value = 100, message = "The product price must not be less than 100.")
    @Column(name = "price")
    private double productPrice;
    
    @NotNull(message = "Unit stocke cannot be null.")
    @Pattern(regexp = "^[1-9][0-9]*$", message = "Unit stock  must not contain special characters and must be greater than 0.")
    @Column(name = "unit")
    private String unitStock;


    @Transient
    private MultipartFile productImage;

	// Getters and Setter

	public Long getProductId() {
		return productId;
	}

	public String getProductCategory() {
		return productCategory;
	}

	public String getProductDescription() {
		return productDescription;
	}

	public String getProductManufacturer() {
		return productManufacturer;
	}

	public String getProductName() {
		return productName;
	}

	public double getProductPrice() {
		return productPrice;
	}

	public String getUnitStock() {
		return unitStock;
	}

	public void setProductId(Long productId) {
		this.productId = productId;
	}

	public void setProductCategory(String productCategory) {
		this.productCategory = productCategory;
	}

	public void setProductDescription(String productDescription) {
		this.productDescription = productDescription;
	}

	public void setProductManufacturer(String productManufacturer) {
		this.productManufacturer = productManufacturer;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public void setProductPrice(double productPrice) {
		this.productPrice = productPrice;
	}

	public void setUnitStock(String unitStock) {
		this.unitStock = unitStock;
	}

	public MultipartFile getProductImage() {
		return productImage;
	}

	public void setProductImage(MultipartFile productImage) {
		this.productImage = productImage;
	}

	// Constructors
	public Product(Long productId, String productCategory, String productDescription, String productManufacturer,
			String productName, double productPrice, String unitStock) {
		super();
		this.productId = productId;
		this.productCategory = productCategory;
		this.productDescription = productDescription;
		this.productManufacturer = productManufacturer;
		this.productName = productName;
		this.productPrice = productPrice;
		this.unitStock = unitStock;
	}

	public Product() {

	}

}

package com.storemanagement.entities;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;
@Entity
@Table(name = "PURCHASE_INVOICE_DETAILS")
public class PurchaseInvoiceDetails {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ID")
	private int id;
	@ManyToOne
	@JoinColumn(name = "PURCHASE_INVOICE_HEADER_ID")
	private PurchaseInvoiceHeader purchaseInvoiceHeader;
	@OneToOne
	@JoinColumn(name = "ITEM_ID", referencedColumnName = "ID")
	private Item item;
	@Column(name = "QTY")
	private int qty;
	@Column(name = "PRICE")
	private double price;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public PurchaseInvoiceHeader getPurchaseInvoiceHeader() {
		return purchaseInvoiceHeader;
	}
	public void setPurchaseInvoiceHeader(
			PurchaseInvoiceHeader purchaseInvoiceHeader) {
		this.purchaseInvoiceHeader = purchaseInvoiceHeader;
	}
	public Item getItem() {
		return item;
	}
	public void setItem(Item item) {
		this.item = item;
	}
	public int getQty() {
		return qty;
	}
	public void setQty(int qty) {
		this.qty = qty;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
}

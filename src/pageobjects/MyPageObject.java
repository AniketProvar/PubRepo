package pageobjects;

import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;

import com.provar.core.testapi.annotations.*;

@Page( title="MyPageObject"                                
     , summary=""
     , relativeUrl=""
     , connection="test2"
     )             
public class MyPageObject {

WebDriver driver ; 

public MyPageObject(WebDriver driver){
this.driver=driver;

}

public void selectOnership(){
driver.findElement(By.xpath("//button[@aria-label='Ownership']")).click();
driver.findElement(By.xpath("//span[@title='Private']")).click();

}
public String errorAssertion(){
return driver.findElement(By.xpath("")).getText();
}


	@LinkType()
	@FindBy(xpath = "//a[normalize-space(.)='Accounts']")
	public WebElement accounts;
	@LinkType()
	@FindBy(xpath = "//div[contains(@class,'active') and contains(@class,'oneContent')]//a[normalize-space(.)='View Opportunities']")
	public WebElement viewOpportunities;
	@LinkType()
	@FindBy(xpath = "//div[contains(@class,'active') and contains(@class,'oneContent')]//a[normalize-space(.)='New']")
	public WebElement New;
	@LinkType()
	@FindBy(xpath = "//a[@title='Barton Media']")
	public WebElement ACCOUNT_NAME;
	@TextType()
	@FindBy(xpath = "//input[@name='Name']")
	public WebElement Name;
	@TextType()
	@FindBy(xpath = "//input[@name='Phone']")
	public WebElement Phone;
	@TextType()
	@FindBy(xpath = "//button[@aria-label='Ownership']//span[@class='slds-truncate']")
	public WebElement Ownership;
	@ButtonType()
	@FindBy(xpath = "//button[@name='SaveEdit']")
	public WebElement save;
	@TextType()
	@FindBy(xpath = "//input[@id='email']")
	public WebElement emailAddressOrPhoneNumber;
	@TextType()
	@FindBy(xpath = "//input[@id='pass']")
	public WebElement password;
	@ButtonType()
	@FindBy(xpath = "//button[@id='u_0_5_eP']")
	public WebElement _1;
	@ButtonType()
	@FindBy(xpath = "//button[@id='u_0_5_hu']")
	public WebElement _11;
	@ButtonType()
	@FindBy(xpath = "//button[@name='login']")
	public WebElement _12;
			
}

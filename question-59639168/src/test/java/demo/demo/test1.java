package demo.demo;
import org.testng.annotations.Test;

public class test1 {
    @Test(priority = 1)
    public void test1()
    {
    System.out.println("test1");
    }
    @Test(priority = 2)
    public void test2()
    {
     System.out.println("test2");
    }
}

package demo.demo;
import org.testng.annotations.Test;

public class test2 {
    @Test(priority = 1)
    public void test3()
    {
    System.out.println("test3");
    }
    @Test(priority = 2)
    public void test4()
    {
    System.out.println("test4");
    }
}

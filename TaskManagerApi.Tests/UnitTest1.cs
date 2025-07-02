using Xunit;
using TaskManagerApi.Models; 

namespace TaskManagerApi.Tests
{
    public class TaskTests
    {
        [Fact]
        public void Task_Should_Have_Title()
        {
            // Arrange
            var task = new TaskItem { Title = "Buy milk" };

            // Act & Assert
            Assert.Equal("Buy milk", task.Title);
        }
    }
}

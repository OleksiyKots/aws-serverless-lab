const { DynamoDBClient, ScanCommand } = require("@aws-sdk/client-dynamodb");
const dynamodb = new DynamoDBClient({ region: "eu-north-1" });

exports.handler = async (event) => {

  throw new Error("ТЕСТОВА ПОМИЛКА CLOUDWATCH: Функція get-all-courses впала!");

  const params = { TableName: "cloudtech-dev-courses" };
  try {
    const data = await dynamodb.send(new ScanCommand(params));
    const courses = data.Items.map(item => {
      return {
        id: item.id.S, title: item.title.S, watchHref: item.watchHref.S,
        authorId: item.authorId.S, length: item.length.S, category: item.category.S
      };
    });
    return courses;
  } catch (err) {
    console.log(err); throw err;
  }
};
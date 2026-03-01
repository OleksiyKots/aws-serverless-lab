const { DynamoDBClient, GetItemCommand } = require("@aws-sdk/client-dynamodb");
const dynamodb = new DynamoDBClient({ region: "eu-north-1" });

exports.handler = async (event) => {
  const params = { TableName: "cloudtech-dev-courses", Key: { id: { S: event.id } } };
  try {
    const data = await dynamodb.send(new GetItemCommand(params));
    return {
      id: data.Item.id.S, title: data.Item.title.S, watchHref: data.Item.watchHref.S,
      authorId: data.Item.authorId.S, length: data.Item.length.S, category: data.Item.category.S
    };
  } catch (err) {
    console.log(err); throw err;
  }
};
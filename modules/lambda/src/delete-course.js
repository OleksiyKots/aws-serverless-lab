const { DynamoDBClient, DeleteItemCommand } = require("@aws-sdk/client-dynamodb");
const dynamodb = new DynamoDBClient({ region: "eu-north-1" });

exports.handler = async (event) => {
  const params = { TableName: "cloudtech-dev-courses", Key: { id: { S: event.id } } };
  try {
    const data = await dynamodb.send(new DeleteItemCommand(params));
    return data;
  } catch (err) {
    console.log(err); throw err;
  }
};
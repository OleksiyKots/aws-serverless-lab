const { DynamoDBClient, ScanCommand } = require("@aws-sdk/client-dynamodb");
const dynamodb = new DynamoDBClient({ region: "eu-north-1" });

exports.handler = async (event) => {
  const params = { TableName: "cloudtech-dev-authors" };
  try {
    const data = await dynamodb.send(new ScanCommand(params));
    const authors = data.Items.map(item => {
      return { id: item.id.S, firstName: item.firstName.S, lastName: item.lastName.S };
    });
    return authors;
  } catch (err) {
    console.log(err); throw err;
  }
};
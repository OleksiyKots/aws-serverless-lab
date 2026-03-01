const { DynamoDBClient, PutItemCommand } = require("@aws-sdk/client-dynamodb");
const dynamodb = new DynamoDBClient({ region: "eu-north-1" });

const replaceAll = (str, find, replace) => { return str.replace(new RegExp(find, "g"), replace); };

exports.handler = async (event) => {
  const id = replaceAll(event.title, " ", "-").toLowerCase();
  const params = {
    TableName: "cloudtech-dev-courses",
    Item: {
      id: { S: id }, title: { S: event.title }, watchHref: { S: `http://www.pluralsight.com/courses/${id}` },
      authorId: { S: event.authorId }, length: { S: event.length }, category: { S: event.category }
    }
  };
  try {
    await dynamodb.send(new PutItemCommand(params));
    return {
      id: params.Item.id.S, title: params.Item.title.S, watchHref: params.Item.watchHref.S,
      authorId: params.Item.authorId.S, length: params.Item.length.S, category: params.Item.category.S
    };
  } catch (err) {
    console.log(err); throw err;
  }
};
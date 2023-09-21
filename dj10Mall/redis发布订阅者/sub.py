# 订阅者

import redis

conn = redis.Redis(host="127.0.0.1", port=6379, decode_responses=True)

# 第一步 生成一个订阅者对象
pubsub = conn.pubsub()

# 第二步 订阅一个消息
pubsub.subscribe("wenlong333") # 与发布者 发布的名字对应起来

# 创建一个接收
while True:
    print("working~~~")
    msg = pubsub.parse_response()  # 解析发布者发布的消息
    print(msg)
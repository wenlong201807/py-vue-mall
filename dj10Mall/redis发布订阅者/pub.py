# 发布者
import redis

conn = redis.Redis(host="127.0.0.1", port=6379, decode_responses=True)


conn.publish("wenlong333", "18")

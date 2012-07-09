require 'socket'      # Sockets are in standard library
require 'timeout'
module ActionControllerExtra
	module GameUpdate
		class ServerUpdate
			def queryServer(host, port)

				@s = TCPSocket.open(host, port)
				@s.write("\x66\x48\x01\x00\x00\x00\x03")
				@result = nil
				@status = Timeout::timeout(5) {
				  @result = @s.readpartial(512)
				}
				if @result != nil
					if @result.length < 300
						#error! response should be roughly 320 bytes, depending on name length
						puts "Error in response"
					else
						#puts result.inspect
						#puts result.length
						@data = @result.unpack('CCVCCCCCCZ*CCVCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
							CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
							CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
							CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
							CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
							CCCCCCCCCCCCCCCCCCCCCVC')
						#puts data.inspect
						@messageData = @data[0,9]
						@gameName = @data[9]
						@era = @data[10]
						#data[11] is a constant 0x2d
						@tth = @data[12]
						#data[13] is a constant 0x00
						@nationStatus = @data[14, 95]
						@submitted = @data[109, 95]
						@connected = @data[204 ,95]
						@turnNumber = @data[299]
						
						puts @messageData.inspect
						puts @gameName
						puts @era
						puts @tth
						#puts nationStatus.inspect
						#puts submitted.inspect
						#puts connected.inspect
						puts @turnNumber

					end
				end
				@s.close # Close the socket when done
			end
		end
	end
end

a = Thread.new{ @server = ServerUpdate.new; @server.queryServer('proactiveapathy.com', 7333)}
b = Thread.new{ @server = ServerUpdate.new; @server.queryServer('proactiveapathy.com', 7319)}
c = Thread.new{ @server = ServerUpdate.new; @server.queryServer('proactiveapathy.com', 7284)}
a.join
b.join
c.join


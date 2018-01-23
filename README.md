# Powershell-Learning
Trial and error creation of powershell scripts to help with IR

## Copied Scripts

The from others directory will hold any scripts which have been 100% lifted and shifted

## NMAP - Example XML Format

<nmaprun>
	<host comment="">
		<status state="up"></status>
		<ipaddr addrtype="ipv4" vendor="" addr="10.1.1.1"></ipaddr>
		<hostnames></hostnames>
		<ports>
			<port protocol="tcp" portid="22">
				<state reason="syn-ack" state="open" reason_ttl="250"></state>
				<service product="Cisco SSH" name="ssh" extrainfo="protocol 2.0" version="1.25" conf="10" method="probed"></service>
			</port>
			<port protocol="tcp" portid="53">
				<state reason="reset" state="closed" reason_ttl="250"></state>
				<service method="table" conf="3" name="domain"></service>
			</port>
			<port protocol="tcp" portid="135">
				<state reason="reset" state="closed" reason_ttl="250"></state>
				<service method="table" conf="3" name="msrpc"></service>
			</port>
			<port protocol="tcp" portid="445"><state reason="reset" state="closed" reason_ttl="250"></state>
			<service method="table" conf="3" name="microsoft-ds"></service>
			</port>
		</ports>
		<os>
			<portused state="open" portid="22" proto="tcp"></portused>
			<portused state="closed" portid="53" proto="tcp"></portused>
			<osmatch>
				<osclass></osclass>
			</osmatch>
		</os>
		<uptime lastboot="" seconds=""></uptime>
		<tcpsequence></tcpsequence>
		<ipidsequence></ipidsequence>
		<tcptssequence></tcptssequence>
	</host>
</nmaprun>

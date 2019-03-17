Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A07C10F05
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 20:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B302087C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 20:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbfCQUgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 16:36:03 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:44953 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfCQUgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 16:36:02 -0400
Received: from localhost ([46.189.28.64]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MOiU5-1hO77l24xL-00Q8tO; Sun, 17 Mar 2019 21:35:30 +0100
Date:   Sun, 17 Mar 2019 21:35:27 +0100
From:   Andreas Klinger <ak@it-klinger.de>
To:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        afaerber@suse.de, arnd@arndb.de, davem@davemloft.net,
        gregkh@linuxfoundation.org, johan@kernel.org, khilman@baylibre.com,
        knaack.h@gmx.de, lars@metafoo.de, linux-kernel@vger.kernel.org,
        martin.blumenstingl@googlemail.com, mchehab+samsung@kernel.org,
        m.othacehe@gmail.com, nicolas.ferre@microchip.com,
        pmeerw@pmeerw.net, robh@kernel.org, songqiang1304521@gmail.com,
        treding@nvidia.com, techsupport@maxbotix.com
Subject: [PATCH v3 2/4] dt-bindings: maxbotix,mb1232: Add MaxBotix i2c
 ultrasonic rangers
Message-ID: <20190317203526.4pcwo4gdrrng44v7@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:02yJIr+R1YtvWTALINFEyVUJqlblYDJC/bKT2YFeFpU5KbPzZsx
 TB4lq5yuWUPHSKBt8p8uxGwNZT2mx5HtEkV7WWKwcly91f0NBCNWeUTUhJy72A5hy5h8KCj
 MLJJhUx/c1M7kNj6Ju8ffRGQplirhWNmKa20Z9tCXP0cUjmHKG/LiFj7rQbQUmCP2GXNvTn
 AXwwpMODvYRGc9s4Ypcaw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Pne+EnYjylw=:BlM7TIdxBYjbZeIQ6MQW6D
 ZaQQkjKu8yDs5cpLvC5WoEYsUHCgj0BcwSbPQ4hkWnbNFUXRtJijta+73gl3Zw0JQ92uwNPgG
 xfiJ4j6Cnw3iLhAIGU82tqn5KHRc9CzvsPm1yjU7o6JWZ24U6CY/CQaro5wPeXwQATn2AF4Rq
 F9MuRC/a6/5kPmXrqC4KYEwLlUNhpCHESFbzd9dtE5J8+VxRitbPB0+jBWBxTKZ1cKv/Nj1Gb
 qLQOgeSIrRSkJSFZS5h/nspIIwFXG6RvgM0TQLicOm1u8Pm/gRXejlU1iLs9N7o2rOBEHY2/2
 B93YY48hZUzVcsa+9f5qFKj1ptHDEE16sPfkDAkNb4iMUmf9IR9OODlxxDTQQoBmlIHes+tcM
 VqT3paKhM6X1imNEfu8+mOld085LF3zMh8QbU8DCnhYlEorzckddKbr2RPhsWk30tMK2rsEBp
 sUUSNhfoDb++Zud9vOafAWhDWhvbLm0dmswCbGhm9+kx7UrwP5XZ3b7wsWnczvduVngxH5e7+
 +fgsmJLUibebTaNKWJ6xULM46ZRYf/FHa2EWZ9fGbtCLjJfeUTwS6kgf2tTD1C2KRRq0h7LKK
 A1pR3dgNjf7hYZEc8IlIWlblIUVOYMwvLDWi4HdMq/lzWVWyrdX2QxgpLg6YP6mU1EPr+kd8w
 fbi/MvkS5U8sao7J1OVfX8di8REUw0/cgmflK8maotMWKhH1sEExMi6pf9K/XitVcTj4HCc5C
 ltmyIx3DNng7uMll9J1ev+/ZfdUw+l0Q3RhX0w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add doc for dt binding maxbotix,mb1232. This binding is for MaxBotix
I2CXL-MaxSonar ultrasonic rangers which share a common i2c interface.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 .../bindings/iio/proximity/maxbotix,mb1232.txt     | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.txt

diff --git a/Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.txt b/Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.txt
new file mode 100644
index 000000000000..0e9df87eca1d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.txt
@@ -0,0 +1,31 @@
+* MaxBotix I2CXL-MaxSonar ultrasonic distance sensor of type  mb1202,
+  mb1212, mb1222, mb1232, mb1242, mb7040 or mb7137 using the i2c interface
+  for ranging
+
+Required properties:
+ - compatible:		"maxbotix,mb1202",
+			"maxbotix,mb1212",
+			"maxbotix,mb1222",
+			"maxbotix,mb1232",
+			"maxbotix,mb1242",
+			"maxbotix,mb7040" or
+			"maxbotix,mb7137"
+
+ - reg:			i2c address of the device, see also i2c/i2c.txt
+
+Optional properties:
+ - interrupt-parent:	Interrupt controller to use
+
+ - interrupts:		Interrupt used to announce the preceding reading
+			request has finished and that data is available.
+			If no interrupt is specified the device driver
+			falls back to wait a fixed amount of time until
+			data can be retrieved.
+
+Example:
+proximity@70 {
+	compatible = "maxbotix,mb1232";
+	reg = <0x70>;
+	interrupt-parent = <&gpio2>;
+	interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
+};
-- 
2.11.0

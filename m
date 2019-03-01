Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF9EC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 13:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5524A20643
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 13:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388078AbfCANnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 08:43:04 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:37819 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728313AbfCANnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 08:43:03 -0500
Received: from localhost ([2.174.161.193]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1McpW8-1hZb9D33y6-00ZxBt; Fri, 01 Mar 2019 14:42:29 +0100
Date:   Fri, 1 Mar 2019 14:42:27 +0100
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
Subject: [PATCH v2 2/4] dt-bindings: maxbotix,i2cxl: Add MaxBotix i2c
 ultrasonic rangers
Message-ID: <20190301134225.susjgtck4iktkbeg@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:eExLLS64aSo6+X08jF1pAXF19Il0EiIdEI19MaIeVKVhrpNcX3x
 l5X+WkiXWrJCnpJlYjG63HdT5IC9pD78NQf8PmWZa7pfWmJpC8IQWOtKPTLt3M6XCqrgqbx
 NwKECW4ZFiA2UssKk9cKFbt945k9+V4EPnTO9rYg4Kk7OYJoHVWZhHlfPh5ZXihzcHvpyq1
 20Sojh5r95p/1upkpE9xA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:goB2edckW0Q=:IZ5mHpbrG2/6mF2xBmDO5D
 zp0ToO6x7/4Ft1AIilyFzOGrJKRgyaEnM+XLaiLpNcs4vRiryyLTZLpgHEPKKlMjWYnLz2n+J
 g52n/FFDimnx+SCQdr0xbaDpZbkE7PaynuoCo0R5an5h2g2bowHCHiCtU2doaoyBoSokGKhNs
 dRfuq2ojAKgAoaoSHSLbID7CeFWrJrUfx2c8a0+qYs8a+rjsI7cLZP5koNkHyswgR3txhCMZ+
 92v1tvAzXUHNPvHb1EJTw9e8YdOTneXxRFolaodPwxHp8t1uE0DJq1jmzqhmY1wyzG8mXehiS
 JCDyz531nAzDL00WafOG1Hs6DanyiyXgwP0C+TjbhoUZZ/aUTCrichvQUVgjEpoFf2bQbDc9L
 WawAE68IOHAi1RVOSA9jnF2pWB4sF/4UD0l0x0UUPTLx6MgdDXN6XVO+E0oFNvPiTbQSbRqn7
 nH+9PjYWMw2BHVn6M2JwmvBEAHJbB+5/8a3Dzjeueuz3X84ncgPmIKFLH8/Pix1a8WLm9Ppef
 Nk7WJB1Fu56Rrxf/iQVFS41tzX0s5EHk5m0DD4fWdIcoCCm+2CgSFURyba5RJZdQLTmlDS5YX
 YOoj9Y8+EozkqAM57xF3lpDCzjCjYUoRtxtLJF2Visraq95vm9dZym65e+UpQK0INFHraSwCZ
 K8Aso9Z3x+WGb1Uf9y/PA7AH7VtBD4H+QVsp8XZWMt/V68JIqUiZcVDeLYFSFIEylLMkstPOY
 KIhJ5H8VYNTGEXR8itQO5gvUbzPtK/S6GKb2iw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add doc for dt binding maxbotix,i2cxl. This binding is for MaxBotix
I2CXL-MaxSonar ultrasonic rangers which share a common i2c interface.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 .../bindings/iio/proximity/maxbotix,i2cxl.txt       | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/maxbotix,i2cxl.txt

diff --git a/Documentation/devicetree/bindings/iio/proximity/maxbotix,i2cxl.txt b/Documentation/devicetree/bindings/iio/proximity/maxbotix,i2cxl.txt
new file mode 100644
index 000000000000..528f428fc583
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/maxbotix,i2cxl.txt
@@ -0,0 +1,21 @@
+* MaxBotix I2CXL-MaxSonar ultrasonic distance sensor of type mb12x2 using
+  the i2c interface for ranging
+
+Required properties:
+ - compatible:		Should be "maxbotix,i2cxl"
+
+ - reg:			i2c address of the device
+
+Optional properties:
+ - status-gpios:	Status gpio (input) used to announce the preceding
+			reading request has finished and that data is
+			available. If no status gpio is specified the
+			device driver falls back to wait until data can be
+			retrieved.
+
+Example:
+proximity@70 {
+	compatible = "maxbotix,i2cxl";
+	reg = <0x70>;
+	status-gpios = <&gpio2 2 GPIO_ACTIVE_HIGH>;
+};
-- 
2.11.0

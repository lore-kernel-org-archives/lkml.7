Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FF3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E60AB218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="n1k5hGpM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbfCORDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 13:03:25 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:46368 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727651AbfCORDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 13:03:25 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2FH3IGA038982;
        Fri, 15 Mar 2019 12:03:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552669399;
        bh=9DDQ7Yk8DSWkm7QHkZOvTRVZKyG7IBKIxcWiKKKIsUM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=n1k5hGpMGPvRu9CiJ262TsAoRPqkpyXHmzxoicmBnCmMVfW7RzD6xrYz/JgtpLyO1
         pcKRgMPlVDYVjDc+EDb7BX5Ja9T+MVS+vsS1txGLecqmRrBvxhpB5oW0uZ0pFY/egO
         nHv3xKLnYchGhWqacoXp3Vn1UVkFxOPa6nv5nB+o=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2FH3I19071586
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Mar 2019 12:03:18 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 15
 Mar 2019 12:03:18 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Fri, 15 Mar 2019 12:03:18 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2FH3Is2007594;
        Fri, 15 Mar 2019 12:03:18 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v10 3/4] dt-bindings: can: tcan4x5x: Add DT bindings for TCAN4x5X driver
Date:   Fri, 15 Mar 2019 12:02:56 -0500
Message-ID: <20190315170257.12847-3-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20190315170257.12847-1-dmurphy@ti.com>
References: <20190315170257.12847-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT binding documentation for TI TCAN4x5x driver.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

v10 - No changes - https://lore.kernel.org/patchwork/patch/1050488/

v9 - No Changes - https://lore.kernel.org/patchwork/patch/1050118/
v8 - No Changes - https://lore.kernel.org/patchwork/patch/1047981/
v7 - Made device state optional - https://lore.kernel.org/patchwork/patch/1047218/
v6 - No changes - https://lore.kernel.org/patchwork/patch/1042445/

 .../devicetree/bindings/net/can/tcan4x5x.txt  | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/can/tcan4x5x.txt

diff --git a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
new file mode 100644
index 000000000000..c388f7d9feb1
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
@@ -0,0 +1,37 @@
+Texas Instruments TCAN4x5x CAN Controller
+================================================
+
+This file provides device node information for the TCAN4x5x interface contains.
+
+Required properties:
+	- compatible: "ti,tcan4x5x"
+	- reg: 0
+	- #address-cells: 1
+	- #size-cells: 0
+	- spi-max-frequency: Maximum frequency of the SPI bus the chip can
+			     operate at should be less than or equal to 18 MHz.
+	- data-ready-gpios: Interrupt GPIO for data and error reporting.
+	- device-wake-gpios: Wake up GPIO to wake up the TCAN device.
+
+See Documentation/devicetree/bindings/net/can/m_can.txt for additional
+required property details.
+
+Optional properties:
+	- reset-gpios: Hardwired output GPIO. If not defined then software
+		       reset.
+	- device-state-gpios: Input GPIO that indicates if the device is in
+			      a sleep state or if the device is active.
+
+Example:
+tcan4x5x: tcan4x5x@0 {
+		compatible = "ti,tcan4x5x";
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <10000000>;
+		bosch,mram-cfg = <0x0 0 0 32 0 0 1 1>;
+		data-ready-gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
+		device-state-gpios = <&gpio3 21 GPIO_ACTIVE_HIGH>;
+		device-wake-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio1 27 GPIO_ACTIVE_LOW>;
+};
-- 
2.20.1.390.gb5101f9297


Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E1DC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB7D20657
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tnEG3+dU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbfCEPwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 10:52:46 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:50172 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727626AbfCEPwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 10:52:45 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x25Fqc20065509;
        Tue, 5 Mar 2019 09:52:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1551801158;
        bh=5raF2BBzA/MPB8MxpCh4q+p42RjInP1ckXCpdT20HS0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=tnEG3+dU7EGmwE8ipPuHa1RR/fMKS21PbePfgrNrc50A/jECvAy6uwtEQ8yz63RYG
         yHZjEzZ9nkHWPmdm5xRL2YLy4aAirAdP8w3TN5o/O/vwPD8HuOKaQ3j6Izaoq407xe
         EfN+DALMqlEr0S/UeJbJ/NayrDYKgDCg4PzaahoM=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x25FqcR0112402
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Mar 2019 09:52:38 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 5
 Mar 2019 09:52:38 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 5 Mar 2019 09:52:38 -0600
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x25FqbRf016597;
        Tue, 5 Mar 2019 09:52:37 -0600
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.71.209])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x25FqbU00547;
        Tue, 5 Mar 2019 09:52:37 -0600 (CST)
From:   Dan Murphy <dmurphy@ti.com>
To:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v7 3/4] dt-bindings: can: tcan4x5x: Add DT bindings for TCAN4x5X driver
Date:   Tue, 5 Mar 2019 09:52:19 -0600
Message-ID: <20190305155220.14037-3-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20190305155220.14037-1-dmurphy@ti.com>
References: <20190305155220.14037-1-dmurphy@ti.com>
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


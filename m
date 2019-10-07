Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EC8C352AA
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBDEB21D6C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oYTfw1Nm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfJGLl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 07:41:57 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:40264 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbfJGLlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:41:55 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x97BfpMc013352;
        Mon, 7 Oct 2019 06:41:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1570448511;
        bh=y1z2wcp4iLwDQh1C3s96kKE7RBiZN0e673AxPcqD950=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=oYTfw1NmWswNjVRHpSvQ0K6xR6dBgwyHlazjUhes8X85XFF3xizaiRXI4tNpJWmeB
         BKo+XqzXbxKFyd9Frr11qC+27nagHBg+bl+zDn6kgN/tUD17Zgz7QQjA9/6FIitLsx
         R6MhqiXgxQHzuaBLgcSUQYJwV0qaBqs55hkDPEn4=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x97BfoCt056610;
        Mon, 7 Oct 2019 06:41:50 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 7 Oct
 2019 06:41:47 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 7 Oct 2019 06:41:49 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x97BfjML024908;
        Mon, 7 Oct 2019 06:41:48 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <felipe.balbi@linux.intel.com>
CC:     <gregkh@linuxfoundation.org>, <pawell@cadence.com>,
        <nsekhar@ti.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>
Subject: [PATCH 1/2] dt-bindings: usb: Add binding for the TI wrapper for Cadence USB3 controller
Date:   Mon, 7 Oct 2019 14:41:41 +0300
Message-ID: <20191007114142.5182-2-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191007114142.5182-1-rogerq@ti.com>
References: <20191007114142.5182-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TI platforms have a wrapper module around the Cadence USB3
controller. Add binding information for that.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 .../devicetree/bindings/usb/cdns-usb3-ti.txt  | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/cdns-usb3-ti.txt

diff --git a/Documentation/devicetree/bindings/usb/cdns-usb3-ti.txt b/Documentation/devicetree/bindings/usb/cdns-usb3-ti.txt
new file mode 100644
index 000000000000..12c7c903e6da
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/cdns-usb3-ti.txt
@@ -0,0 +1,59 @@
+Binding for the TI specific wrapper for the Cadence USBSS-DRD controller
+
+Required properties:
+  - compatible: Should contain "ti,j721e-usb"
+  - reg: Physical base address and size of the wrappers register area.
+  - power-domains: Should contain a phandle to a PM domain provider node
+                   and an args specifier containing the USB device id
+                   value. This property is as per the binding documentation:
+                   Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
+  - clocks: Clock phandles to usb2_refclk and lpm_clk
+  - clock-names: Should contain "usb2_refclk" and "lpm_clk"
+
+Optional properties:
+ - ti,usb2-only: If present, it restricts the controller to USB2.0 mode of
+		 operation. Must be present if USB3 PHY is not available
+		 for USB.
+ - ti,modestrap-host: Set controller modestrap to HOST mode.
+ - ti,modestrap-peripheral: Set controller modestrap to PERIPHERAL mode.
+ - ti,vbus-divider: Should be present if USB VBUS line is connected to the
+		 VBUS pin of the SoC via a 1/3 voltage divider.
+
+Sub-nodes:
+The USB2 PHY and the Cadence USB3 controller should be the sub-nodes.
+
+Example:
+
+	ti_usb0: cdns_usb@4104000 {
+		compatible = "ti,j721e-usb";
+		reg = <0x00 0x4104000 0x00 0x100>;
+		power-domains = <&k3_pds 288 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 288 15>, <&k3_clks 288 3>;
+		clock-names = "usb2_refclk", "lpm_clk";
+		assigned-clocks = <&k3_clks 288 15>;	/* USB2_REFCLK */
+		assigned-clock-parents = <&k3_clks 288 16>; /* HFOSC0 */
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		phy@4108000 {
+			compatible = "ti,j721e-usb2-phy";
+			reg = <0x00 0x4108000 0x00 0x400>;
+		};
+
+		usb0: usb@6000000 {
+			compatible = "cdns,usb3-1.0.1";
+			reg = <0x00 0x6000000 0x00 0x10000>,
+			      <0x00 0x6010000 0x00 0x10000>,
+			      <0x00 0x6020000 0x00 0x10000>;
+			reg-names = "otg", "xhci", "dev";
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,	/* irq.0 */
+				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,	/* irq.6 */
+				     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;	/* otgirq.0 */
+			interrupt-names = "host",
+					  "peripheral",
+					  "otg";
+			maximum-speed = "super-speed";
+			dr_mode = "otg";
+		};
+	};
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki


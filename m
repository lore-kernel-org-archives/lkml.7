Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A48CA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A9222089C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vx3vntD3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbfJUNO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:14:29 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33406 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728840AbfJUNO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:14:28 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9LDEKJ6083939;
        Mon, 21 Oct 2019 08:14:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571663660;
        bh=HV6iaivoaFG9onDrZhTj+eWHfIehxFTqG6sv4XHOH80=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=vx3vntD3GVVm6efCVc5xOZ3unu/awcqin8fki0KiMBfcpeLns31LNr9BY+PJc9l1M
         JbeFSBs6gLlOs/xzrDpr8aOPF5mIOMb1GiThOrI9OawPGJ5JueD1b1v/7hURrI+pkb
         9JR7OPkp7yQ8XndeXQU/WFRJ+wxNF40adFjuJX0w=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9LDE5nu044321
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Oct 2019 08:14:05 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 21
 Oct 2019 08:13:55 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 21 Oct 2019 08:14:04 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9LDDE7f017365;
        Mon, 21 Oct 2019 08:13:17 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <felipe.balbi@linux.intel.com>, <gregkh@linuxfoundation.org>
CC:     <pawell@cadence.com>, <peter.chen@nxp.com>, <nsekhar@ti.com>,
        <kurahul@cadence.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: usb: Add binding for the TI wrapper for Cadence USB3 controller
Date:   Mon, 21 Oct 2019 16:13:04 +0300
Message-ID: <20191021131305.8689-2-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191021131305.8689-1-rogerq@ti.com>
References: <20191021131305.8689-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TI platforms have a wrapper module around the Cadence USB3
controller. Add binding information for that.

Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 .../devicetree/bindings/usb/ti,j721e-usb.txt  | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ti,j721e-usb.txt

diff --git a/Documentation/devicetree/bindings/usb/ti,j721e-usb.txt b/Documentation/devicetree/bindings/usb/ti,j721e-usb.txt
new file mode 100644
index 000000000000..bac57c26b09b
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ti,j721e-usb.txt
@@ -0,0 +1,52 @@
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
+  - clock-names: Should contain "ref" and "lpm"
+
+Optional properties:
+ - ti,usb2-only: If present, it restricts the controller to USB2.0 mode of
+		 operation. Must be present if USB3 PHY is not available
+		 for USB.
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
+		clock-names = "ref", "lpm";
+		assigned-clocks = <&k3_clks 288 15>;	/* USB2_REFCLK */
+		assigned-clock-parents = <&k3_clks 288 16>; /* HFOSC0 */
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		usb0: usb@6000000 {
+			compatible = "cdns,usb3";
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


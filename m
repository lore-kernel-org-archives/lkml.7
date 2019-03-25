Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB09C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7786021473
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbfCYPzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 11:55:41 -0400
Received: from mga07.intel.com ([134.134.136.100]:61246 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbfCYPzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 11:55:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 08:55:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,269,1549958400"; 
   d="scan'208";a="137124516"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by orsmga003.jf.intel.com with ESMTP; 25 Mar 2019 08:55:37 -0700
From:   thor.thayer@linux.intel.com
To:     bp@alien8.de, dinguyen@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     mchehab@kernel.org, james.morse@arm.com,
        thor.thayer@linux.intel.com, devicetree@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCHv3 2/3] Documentation: dt: edac: Add Stratix10 Peripheral bindings
Date:   Mon, 25 Mar 2019 10:57:55 -0500
Message-Id: <1553529476-26181-3-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553529476-26181-1-git-send-email-thor.thayer@linux.intel.com>
References: <1553529476-26181-1-git-send-email-thor.thayer@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Add peripheral bindings for Stratix10 EDAC to capture
the differences between the ARM64 and ARM32 architecture.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
v2-3 No change
---
 .../devicetree/bindings/edac/socfpga-eccmgr.txt    | 106 +++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt b/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt
index acb211c098c0..8f52206cfd2a 100644
--- a/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt
+++ b/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt
@@ -258,6 +258,49 @@ Required Properties:
 - compatible : Should be "altr,sdram-edac-s10"
 - interrupts : Should be single bit error interrupt.
 
+On-Chip RAM ECC
+Required Properties:
+- compatible      : Should be "altr,socfpga-s10-ocram-ecc"
+- reg             : Address and size for ECC block registers.
+- altr,ecc-parent : phandle to parent OCRAM node.
+- interrupts      : Should be single bit error interrupt.
+
+Ethernet FIFO ECC
+Required Properties:
+- compatible      : Should be "altr,socfpga-s10-eth-mac-ecc"
+- reg             : Address and size for ECC block registers.
+- altr,ecc-parent : phandle to parent Ethernet node.
+- interrupts      : Should be single bit error interrupt.
+
+NAND FIFO ECC
+Required Properties:
+- compatible      : Should be "altr,socfpga-s10-nand-ecc"
+- reg             : Address and size for ECC block registers.
+- altr,ecc-parent : phandle to parent NAND node.
+- interrupts      : Should be single bit error interrupt.
+
+DMA FIFO ECC
+Required Properties:
+- compatible      : Should be "altr,socfpga-s10-dma-ecc"
+- reg             : Address and size for ECC block registers.
+- altr,ecc-parent : phandle to parent DMA node.
+- interrupts      : Should be single bit error interrupt.
+
+USB FIFO ECC
+Required Properties:
+- compatible      : Should be "altr,socfpga-s10-usb-ecc"
+- reg             : Address and size for ECC block registers.
+- altr,ecc-parent : phandle to parent USB node.
+- interrupts      : Should be single bit error interrupt.
+
+SDMMC FIFO ECC
+Required Properties:
+- compatible      : Should be "altr,socfpga-s10-sdmmc-ecc"
+- reg             : Address and size for ECC block registers.
+- altr,ecc-parent : phandle to parent SD/MMC node.
+- interrupts      : Should be single bit error interrupt for port A
+		    and then single bit error interrupt for port B.
+
 Example:
 
 	eccmgr {
@@ -274,4 +317,67 @@ Example:
 			compatible = "altr,sdram-edac-s10";
 			interrupts = <16 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		ocram-ecc@ff8cc000 {
+			compatible = "altr,socfpga-s10-ocram-ecc";
+			reg = <ff8cc000 0x100>;
+			altr,ecc-parent = <&ocram>;
+			interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		emac0-rx-ecc@ff8c0000 {
+			compatible = "altr,socfpga-s10-eth-mac-ecc";
+			reg = <0xff8c0000 0x100>;
+			altr,ecc-parent = <&gmac0>;
+			interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		emac0-tx-ecc@ff8c0400 {
+			compatible = "altr,socfpga-s10-eth-mac-ecc";
+			reg = <0xff8c0400 0x100>;
+			altr,ecc-parent = <&gmac0>;
+			interrupts = <5 IRQ_TYPE_LEVEL_HIGH>'
+		};
+
+		nand-buf-ecc@ff8c8000 {
+			compatible = "altr,socfpga-s10-nand-ecc";
+			reg = <0xff8c8000 0x100>;
+			altr,ecc-parent = <&nand>;
+			interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		nand-rd-ecc@ff8c8400 {
+			compatible = "altr,socfpga-s10-nand-ecc";
+			reg = <0xff8c8400 0x100>;
+			altr,ecc-parent = <&nand>;
+			interrupts = <13 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		nand-wr-ecc@ff8c8800 {
+			compatible = "altr,socfpga-s10-nand-ecc";
+			reg = <0xff8c8800 0x100>;
+			altr,ecc-parent = <&nand>;
+			interrupts = <12 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		dma-ecc@ff8c9000 {
+			compatible = "altr,socfpga-s10-dma-ecc";
+			reg = <0xff8c9000 0x100>;
+			altr,ecc-parent = <&pdma>;
+			interrupts = <10 IRQ_TYPE_LEVEL_HIGH>;
+
+		usb0-ecc@ff8c4000 {
+			compatible = "altr,socfpga-s10-usb-ecc";
+			reg = <0xff8c4000 0x100>;
+			altr,ecc-parent = <&usb0>;
+			interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		sdmmc-ecc@ff8c8c00 {
+			compatible = "altr,socfpga-s10-sdmmc-ecc";
+			reg = <0xff8c8c00 0x100>;
+			altr,ecc-parent = <&mmc>;
+			interrupts = <14 IRQ_TYPE_LEVEL_HIGH>,
+				     <15 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
-- 
2.7.4


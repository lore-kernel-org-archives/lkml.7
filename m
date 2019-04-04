Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2D1C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9384621734
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbfDDOek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 10:34:40 -0400
Received: from mga03.intel.com ([134.134.136.65]:5070 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729091AbfDDOei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 10:34:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Apr 2019 07:34:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,308,1549958400"; 
   d="scan'208";a="128612695"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by orsmga007.jf.intel.com with ESMTP; 04 Apr 2019 07:34:37 -0700
From:   thor.thayer@linux.intel.com
To:     bp@alien8.de, dinguyen@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     mchehab@kernel.org, james.morse@arm.com,
        thor.thayer@linux.intel.com, devicetree@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCHv3 3/3] arm64: dts: stratix10: Use new Stratix10 EDAC bindings
Date:   Thu,  4 Apr 2019 09:36:37 -0500
Message-Id: <1554388597-28019-4-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554388597-28019-1-git-send-email-thor.thayer@linux.intel.com>
References: <1554388597-28019-1-git-send-email-thor.thayer@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Use the new Stratix10 binding format for EDAC nodes.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
Acked-by: Dinh Nguyen <dinguyen@kernel.org>
---
v2-3 No change
Resend adds Acked-by.
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 25 ++++++++++++-----------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index e3f5eaa3657d..41109995563c 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -531,11 +531,12 @@
 		};
 
 		eccmgr {
-			compatible = "altr,socfpga-a10-ecc-manager";
+			compatible = "altr,socfpga-s10-ecc-manager",
+				     "altr,socfpga-a10-ecc-manager";
 			altr,sysmgr-syscon = <&sysmgr>;
 			#address-cells = <1>;
 			#size-cells = <1>;
-			interrupts = <0 15 4>, <0 95 4>;
+			interrupts = <0 15 4>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			ranges;
@@ -543,31 +544,31 @@
 			sdramedac {
 				compatible = "altr,sdram-edac-s10";
 				altr,sdr-syscon = <&sdr>;
-				interrupts = <16 4>, <48 4>;
+				interrupts = <16 4>;
 			};
 
 			usb0-ecc@ff8c4000 {
-				compatible = "altr,socfpga-usb-ecc";
+				compatible = "altr,socfpga-s10-usb-ecc",
+					     "altr,socfpga-usb-ecc";
 				reg = <0xff8c4000 0x100>;
 				altr,ecc-parent = <&usb0>;
-				interrupts = <2 4>,
-					     <34 4>;
+				interrupts = <2 4>;
 			};
 
 			emac0-rx-ecc@ff8c0000 {
-				compatible = "altr,socfpga-eth-mac-ecc";
+				compatible = "altr,socfpga-s10-eth-mac-ecc",
+					     "altr,socfpga-eth-mac-ecc";
 				reg = <0xff8c0000 0x100>;
 				altr,ecc-parent = <&gmac0>;
-				interrupts = <4 4>,
-					     <36 4>;
+				interrupts = <4 4>;
 			};
 
 			emac0-tx-ecc@ff8c0400 {
-				compatible = "altr,socfpga-eth-mac-ecc";
+				compatible = "altr,socfpga-s10-eth-mac-ecc",
+					     "altr,socfpga-eth-mac-ecc";
 				reg = <0xff8c0400 0x100>;
 				altr,ecc-parent = <&gmac0>;
-				interrupts = <5 4>,
-					     <37 4>;
+				interrupts = <5 4>;
 			};
 
 		};
-- 
2.7.4


Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CC6C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2DD21738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfDWOeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:34:18 -0400
Received: from mga11.intel.com ([192.55.52.93]:54833 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728123AbfDWOeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:34:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP; 23 Apr 2019 07:34:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,386,1549958400"; 
   d="scan'208";a="136653923"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by orsmga008.jf.intel.com with ESMTP; 23 Apr 2019 07:34:15 -0700
From:   thor.thayer@linux.intel.com
To:     bp@alien8.de, mchehab@kernel.org, james.morse@arm.com,
        dinguyen@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     thor.thayer@linux.intel.com, devicetree@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arm64: dts: stratix10: Add SDMMC EDAC node
Date:   Tue, 23 Apr 2019 09:36:37 -0500
Message-Id: <1556030197-24534-5-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556030197-24534-1-git-send-email-thor.thayer@linux.intel.com>
References: <1556030197-24534-1-git-send-email-thor.thayer@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Add the Stratix10 SDMMC EDAC node.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
index 2e3863ee12b3..91fed85cf8e5 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
@@ -67,6 +67,17 @@
 				clock-frequency = <25000000>;
 			};
 		};
+
+		eccmgr {
+			sdmmca-ecc@ff8c8c00 {
+				compatible = "altr,socfpga-s10-sdmmc-ecc",
+					     "altr,socfpga-sdmmc-ecc";
+				reg = <0xff8c8c00 0x100>;
+				altr,ecc-parent = <&mmc>;
+				interrupts = <14 4>,
+					     <15 4>;
+			};
+		};
 	};
 };
 
-- 
2.7.4


Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393D8C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 08:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C1DA206C2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 08:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730405AbfJHItF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 04:49:05 -0400
Received: from mga07.intel.com ([134.134.136.100]:30193 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729767AbfJHItF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 04:49:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2019 01:49:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,270,1566889200"; 
   d="scan'208";a="223175848"
Received: from unknown (HELO ubuntu.localdomain) ([10.226.250.216])
  by fmsmga002.fm.intel.com with ESMTP; 08 Oct 2019 01:49:02 -0700
From:   Joyce Ooi <joyce.ooi@intel.com>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joyce Ooi <joyce.ooi@intel.com>,
        Ong Hean Loong <hean.loong.ong@intel.com>,
        See Chin Liang <chin.liang.see@intel.com>,
        Tan Ley Foon <ley.foon.tan@intel.com>
Subject: [PATCH] arm64: dts: altera: update QSPI reg addresses for Stratix10
Date:   Tue,  8 Oct 2019 01:48:59 -0700
Message-Id: <1570524539-7411-1-git-send-email-joyce.ooi@intel.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Ooi, Joyce" <joyce.ooi@intel.com>

This patch updates the reg addresses for QSPI boot and QSPI rootfs in
the device tree for Stratix10

Signed-off-by: Ooi, Joyce <joyce.ooi@intel.com>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
index 66e4ffb4e929..fb11ef05d556 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
@@ -178,12 +178,12 @@
 
 			qspi_boot: partition@0 {
 				label = "Boot and fpga data";
-				reg = <0x0 0x4000000>;
+				reg = <0x0 0x034B0000>;
 			};
 
 			qspi_rootfs: partition@4000000 {
 				label = "Root Filesystem - JFFS2";
-				reg = <0x4000000 0x4000000>;
+				reg = <0x034B0000 0x0EB50000>;
 			};
 		};
 	};
-- 
2.13.0


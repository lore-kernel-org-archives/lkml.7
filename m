Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDB0CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF9A205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404226AbfJWKNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 06:13:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:53872 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404104AbfJWKNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 06:13:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 062C4B53E;
        Wed, 23 Oct 2019 10:13:30 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v2 06/11] arm64: dts: realtek: Add RTD129x reset controller nodes
Date:   Wed, 23 Oct 2019 12:13:12 +0200
Message-Id: <20191023101317.26656-7-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191023101317.26656-1-afaerber@suse.de>
References: <20191023101317.26656-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes for the Realtek RTD1295 reset controllers.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v1 -> v2:
 * Rebased, moved from rtd1295.dtsi to rtd129x.dtsi
 
 arch/arm64/boot/dts/realtek/rtd129x.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/realtek/rtd129x.dtsi b/arch/arm64/boot/dts/realtek/rtd129x.dtsi
index 0b2ac0c33b8b..282ab8bfaad1 100644
--- a/arch/arm64/boot/dts/realtek/rtd129x.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd129x.dtsi
@@ -37,6 +37,36 @@
 		/* Exclude up to 2 GiB of RAM */
 		ranges = <0x80000000 0x80000000 0x80000000>;
 
+		reset1: reset-controller@98000000 {
+			compatible = "snps,dw-low-reset";
+			reg = <0x98000000 0x4>;
+			#reset-cells = <1>;
+		};
+
+		reset2: reset-controller@98000004 {
+			compatible = "snps,dw-low-reset";
+			reg = <0x98000004 0x4>;
+			#reset-cells = <1>;
+		};
+
+		reset3: reset-controller@98000008 {
+			compatible = "snps,dw-low-reset";
+			reg = <0x98000008 0x4>;
+			#reset-cells = <1>;
+		};
+
+		reset4: reset-controller@98000050 {
+			compatible = "snps,dw-low-reset";
+			reg = <0x98000050 0x4>;
+			#reset-cells = <1>;
+		};
+
+		iso_reset: reset-controller@98007088 {
+			compatible = "snps,dw-low-reset";
+			reg = <0x98007088 0x4>;
+			#reset-cells = <1>;
+		};
+
 		wdt: watchdog@98007680 {
 			compatible = "realtek,rtd1295-watchdog";
 			reg = <0x98007680 0x100>;
-- 
2.16.4


Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8361C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 07:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA86920855
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 07:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbfKQHVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 02:21:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:40800 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726082AbfKQHVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 02:21:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CC3B2B313;
        Sun, 17 Nov 2019 07:21:21 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v3 6/8] ARM: dts: rtd1195: Add reset nodes
Date:   Sun, 17 Nov 2019 08:21:07 +0100
Message-Id: <20191117072109.20402-7-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191117072109.20402-1-afaerber@suse.de>
References: <20191117072109.20402-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset controller nodes for Realtek RTD1195 SoC.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v3: from RTD1295 reset v2
 * Rebased onto r-bus - reg, unit address, indentation
 
 arch/arm/boot/dts/rtd1195.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/rtd1195.dtsi b/arch/arm/boot/dts/rtd1195.dtsi
index f5174f828a28..e0f133a1354f 100644
--- a/arch/arm/boot/dts/rtd1195.dtsi
+++ b/arch/arm/boot/dts/rtd1195.dtsi
@@ -99,6 +99,30 @@
 			#size-cells = <1>;
 			ranges = <0x0 0x18000000 0x70000>;
 
+			reset1: reset-controller@0 {
+				compatible = "snps,dw-low-reset";
+				reg = <0x0 0x4>;
+				#reset-cells = <1>;
+			};
+
+			reset2: reset-controller@4 {
+				compatible = "snps,dw-low-reset";
+				reg = <0x4 0x4>;
+				#reset-cells = <1>;
+			};
+
+			reset3: reset-controller@8 {
+				compatible = "snps,dw-low-reset";
+				reg = <0x8 0x4>;
+				#reset-cells = <1>;
+			};
+
+			iso_reset: reset-controller@7088 {
+				compatible = "snps,dw-low-reset";
+				reg = <0x7088 0x4>;
+				#reset-cells = <1>;
+			};
+
 			wdt: watchdog@7680 {
 				compatible = "realtek,rtd1295-watchdog";
 				reg = <0x7680 0x100>;
-- 
2.16.4


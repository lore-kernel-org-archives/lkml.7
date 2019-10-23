Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CE0CA9EB7
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DDCB2084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404242AbfJWKNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 06:13:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:54006 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404135AbfJWKNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 06:13:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E6D88B595;
        Wed, 23 Oct 2019 10:13:30 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v2 08/11] ARM: dts: rtd1195: Add reset nodes
Date:   Wed, 23 Oct 2019 12:13:14 +0200
Message-Id: <20191023101317.26656-9-afaerber@suse.de>
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

Add reset controller nodes for Realtek RTD1195 SoC.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v2: New
 
 arch/arm/boot/dts/rtd1195.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/rtd1195.dtsi b/arch/arm/boot/dts/rtd1195.dtsi
index 475740c67d26..fdcaf48a26f2 100644
--- a/arch/arm/boot/dts/rtd1195.dtsi
+++ b/arch/arm/boot/dts/rtd1195.dtsi
@@ -93,6 +93,30 @@
 		#size-cells = <1>;
 		ranges;
 
+		reset1: reset-controller@18000000 {
+			compatible = "snps,dw-low-reset";
+			reg = <0x18000000 0x4>;
+			#reset-cells = <1>;
+		};
+
+		reset2: reset-controller@18000004 {
+			compatible = "snps,dw-low-reset";
+			reg = <0x18000004 0x4>;
+			#reset-cells = <1>;
+		};
+
+		reset3: reset-controller@18000008 {
+			compatible = "snps,dw-low-reset";
+			reg = <0x18000008 0x4>;
+			#reset-cells = <1>;
+		};
+
+		iso_reset: reset-controller@18007088 {
+			compatible = "snps,dw-low-reset";
+			reg = <0x18007088 0x4>;
+			#reset-cells = <1>;
+		};
+
 		wdt: watchdog@18007680 {
 			compatible = "realtek,rtd1295-watchdog";
 			reg = <0x18007680 0x100>;
-- 
2.16.4


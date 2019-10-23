Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE329CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808D521928
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404271AbfJWKNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 06:13:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:54006 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404204AbfJWKNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 06:13:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3EFF2B67E;
        Wed, 23 Oct 2019 10:13:33 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v2 11/11] ARM: dts: rtd1195: Adopt reset constants
Date:   Wed, 23 Oct 2019 12:13:17 +0200
Message-Id: <20191023101317.26656-12-afaerber@suse.de>
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

Replace reset controller indices with constants.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v2: New
 
 arch/arm/boot/dts/rtd1195.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rtd1195.dtsi b/arch/arm/boot/dts/rtd1195.dtsi
index e2cdcbcf70f4..9ccf8fa04718 100644
--- a/arch/arm/boot/dts/rtd1195.dtsi
+++ b/arch/arm/boot/dts/rtd1195.dtsi
@@ -13,6 +13,7 @@
 /memreserve/ 0x18100000 0x01000000; /* nor */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/reset/realtek,rtd1195.h>
 
 / {
 	compatible = "realtek,rtd1195";
@@ -128,7 +129,7 @@
 			reg = <0x18007800 0x400>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			resets = <&iso_reset 8>;
+			resets = <&iso_reset RTD1195_ISO_RSTN_UR0>;
 			clock-frequency = <27000000>;
 			status = "disabled";
 		};
@@ -138,7 +139,7 @@
 			reg = <0x1801b200 0x100>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			resets = <&reset2 28>;
+			resets = <&reset2 RTD1195_RSTN_UR1>;
 			clock-frequency = <27000000>;
 			status = "disabled";
 		};
-- 
2.16.4


Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BB4CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD3E2173B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404350AbfJWKOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 06:14:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:53884 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404124AbfJWKNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 06:13:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 69B9AB55C;
        Wed, 23 Oct 2019 10:13:30 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v2 07/11] arm64: dts: realtek: Add RTD129x UART resets
Date:   Wed, 23 Oct 2019 12:13:13 +0200
Message-Id: <20191023101317.26656-8-afaerber@suse.de>
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

Associate the UART nodes with the corresponding reset controller bits.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v1 -> v2:
 * Rebased, moved from rtd1295.dtsi to rtd129x.dtsi
 
 arch/arm64/boot/dts/realtek/rtd129x.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/realtek/rtd129x.dtsi b/arch/arm64/boot/dts/realtek/rtd129x.dtsi
index 282ab8bfaad1..15d321d9515c 100644
--- a/arch/arm64/boot/dts/realtek/rtd129x.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd129x.dtsi
@@ -79,6 +79,7 @@
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clock-frequency = <27000000>;
+			resets = <&iso_reset 8>;
 			status = "disabled";
 		};
 
@@ -88,6 +89,7 @@
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clock-frequency = <432000000>;
+			resets = <&reset2 28>;
 			status = "disabled";
 		};
 
@@ -97,6 +99,7 @@
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clock-frequency = <432000000>;
+			resets = <&reset2 27>;
 			status = "disabled";
 		};
 
-- 
2.16.4


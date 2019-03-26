Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92624C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B2FE2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbfCZL3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 07:29:17 -0400
Received: from unicorn.mansr.com ([81.2.72.234]:39268 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfCZL3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 07:29:16 -0400
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 00E6B1562F; Tue, 26 Mar 2019 11:29:14 +0000 (GMT)
From:   Mans Rullgard <mans@mansr.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Werner=20B=C3=B6llmann?= 
        <Werner.Boellmann@fh-dortmund.de>
Subject: [PATCH] ARM: dts: sun7i: fix typos in uart pin mux
Date:   Tue, 26 Mar 2019 11:29:02 +0000
Message-Id: <20190326112902.30080-1-mans@mansr.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recently added uart mux options had a few typos.  Fix them.

Fixes: 43d0fe112585 ("ARM: dts: sun7i: add pinctrl for missing uart mux options")
Reported-by: Werner Böllmann <Werner.Boellmann@fh-dortmund.de>
Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 9f8bd8f3164b..9234cf8f72bf 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -1006,19 +1006,19 @@
 
 			/omit-if-no-ref/
 			uart1_cts_rts_pa_pins: uart1-cts-rts-pa-pins {
-				pins = "PA12", "PIA13";
-				function = "uart2";
+				pins = "PA12", "PA13";
+				function = "uart1";
 			};
 
 			/omit-if-no-ref/
 			uart2_pa_pins: uart2-pa-pins {
-				pins = "PIA2", "PIA3";
+				pins = "PA2", "PA3";
 				function = "uart2";
 			};
 
 			/omit-if-no-ref/
 			uart2_cts_rts_pa_pins: uart2-cts-rts-pa-pins {
-				pins = "PA0", "PIA1";
+				pins = "PA0", "PA1";
 				function = "uart2";
 			};
 
-- 
2.21.0


Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73877C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C77206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfCKH6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 03:58:30 -0400
Received: from mail.sysgo.com ([176.9.12.79]:34324 "EHLO mail.sysgo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbfCKH63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 03:58:29 -0400
From:   David Engraf <david.engraf@sysgo.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Engraf <david.engraf@sysgo.com>
Subject: [PATCH] ARM: dts: at91: Fix typo in ISC_D0 on PC9
Date:   Mon, 11 Mar 2019 08:57:42 +0100
Message-Id: <20190311075742.23320-1-david.engraf@sysgo.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function argument for the ISC_D0 on PC9 was incorrect. According to
the documentation it should be 'C' aka 3.

Signed-off-by: David Engraf <david.engraf@sysgo.com>
---
 arch/arm/boot/dts/sama5d2-pinfunc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d2-pinfunc.h b/arch/arm/boot/dts/sama5d2-pinfunc.h
index 1c01a6f843d8..28a2e45752fe 100644
--- a/arch/arm/boot/dts/sama5d2-pinfunc.h
+++ b/arch/arm/boot/dts/sama5d2-pinfunc.h
@@ -518,7 +518,7 @@
 #define PIN_PC9__GPIO			PINMUX_PIN(PIN_PC9, 0, 0)
 #define PIN_PC9__FIQ			PINMUX_PIN(PIN_PC9, 1, 3)
 #define PIN_PC9__GTSUCOMP		PINMUX_PIN(PIN_PC9, 2, 1)
-#define PIN_PC9__ISC_D0			PINMUX_PIN(PIN_PC9, 2, 1)
+#define PIN_PC9__ISC_D0			PINMUX_PIN(PIN_PC9, 3, 1)
 #define PIN_PC9__TIOA4			PINMUX_PIN(PIN_PC9, 4, 2)
 #define PIN_PC10			74
 #define PIN_PC10__GPIO			PINMUX_PIN(PIN_PC10, 0, 0)
-- 
2.17.1


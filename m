Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A8EC43215
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 22:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D932075C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 22:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="FZGRNfQH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfKQW2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 17:28:35 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:22503 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfKQW2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 17:28:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574029713;
        s=strato-dkim-0002; d=gerhold.net;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=urCVRDxjtlkSW6YxW0DTjykMpr66oVfNWnAF+7LY2IM=;
        b=FZGRNfQH4aViZE0gVOXp4F2EjLg3MEz3FvkPrPzWzFpwSfnMpyJAT/8LSu2U+BXrL2
        q6R0HKzHABI7m0rkbhwt27MPyhuAqUdEz6ripalMnZk5xyJYG7W9ZVIBe79cq6xrsa0I
        O8amA9RuWFgJBfIZ3DIaKyF6yhbdBtro6I8Ju0AafKKD8olYxdvC+3d0CxkSEXEqrW99
        G9cKs92zF2NLNVWzOlJf9hvAZtQTwG8pFqPRDN9V3/LCDZ6Sh7r/C74NjmFnGKE2vHFC
        4x57FinYk1ZXHpcy/Hn24kQXHrOBVEl4UKooviFJgbwcgxwZ0rDY8JL5WHsel8V3RPpF
        zjYg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQrEOHTIXsMvvtBRRPA=="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id e07688vAHMSWbCW
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sun, 17 Nov 2019 23:28:32 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH] ARM: dts: ux500: snowball: Remove unused PRCMU cpufreq node
Date:   Sun, 17 Nov 2019 23:27:32 +0100
Message-Id: <20191117222732.283673-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a435adbec264 ("ARM: dts: augment Ux500 to use DT cpufreq")
switched the Ux500 device tree to use the generic DT cpufreq driver
and removed the PRCMU cpufreq node.

The snowball DTS still references it, without effect, since cpufreq
is now enabled by default. Remove the unused node.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm/boot/dts/ste-snowball.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index efbc4467b8b7..566b35ac0d0c 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -377,10 +377,6 @@
 		};
 
 		prcmu@80157000 {
-			cpufreq {
-				status = "okay";
-			};
-
 			ab8500 {
 				ab8500-gpio {
 					/*
-- 
2.23.0


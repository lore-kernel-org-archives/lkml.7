Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E77C43215
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 22:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 718CC20729
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 22:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="TkDUt0Rp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfKQWOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 17:14:47 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.164]:25841 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfKQWOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 17:14:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574028885;
        s=strato-dkim-0002; d=gerhold.net;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=7hCz+5DTC5n2Pi08W82Wd1z0wbmsZs12qI1M9dEPLlQ=;
        b=TkDUt0Rp14NLJr0km8Rpsd+k0pKkjts5JfiBDKTsjha8Dq+J4bnvMDuaoBO+90Wh2d
        pJI6A/53VC1qK3YzjXTFm7ihypAPLgZUmn/leLTe73VB1okKfp3C0lQgUYy0NRZUY+O6
        /5uc0qBMAHxxQf8L8t3XPXL4U0vG9YZ2vgyqgqiSFocEcTK+y2Tl9mDu70Eq46xMaLVA
        oqQEOO/HfLqLSkp27BaFNMwv/DMRUGZvg168q7BTadg7hI3PZqjAwC5muupM080rXQqQ
        4xnlI17kx+0DJSiKq693O74u7p65YgBgMQplS7Nscvbzx6G9lpkwUMq7wC1MNrNghRVi
        BHMQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQrEOHTIXsMvvtBRRPA=="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id e07688vAHMEdbBN
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sun, 17 Nov 2019 23:14:39 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/2] dt-bindings: mfd: ab8500: Document AB8505 bindings
Date:   Sun, 17 Nov 2019 23:10:52 +0100
Message-Id: <20191117221053.278415-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AB8505 can now be configured from the device tree.
The configuration is almost identical to AB8500, so just add a note
for the nodes/compatibles that differ between the two revisions.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 Documentation/devicetree/bindings/mfd/ab8500.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/ab8500.txt b/Documentation/devicetree/bindings/mfd/ab8500.txt
index cd9e90c5d171..5c12a65ea8df 100644
--- a/Documentation/devicetree/bindings/mfd/ab8500.txt
+++ b/Documentation/devicetree/bindings/mfd/ab8500.txt
@@ -1,7 +1,7 @@
 * AB8500 Multi-Functional Device (MFD)
 
 Required parent device properties:
-- compatible             : contains "stericsson,ab8500";
+- compatible             : contains "stericsson,ab8500" or "stericsson,ab8505";
 - interrupts             : contains the IRQ line for the AB8500
 - interrupt-controller   : describes the AB8500 as an Interrupt Controller (has its own domain)
 - #interrupt-cells       : should be 2, for 2-cell format
@@ -49,11 +49,13 @@ ab8500-charger		 :			: vddadc       : Charger interface
 			 : CH_WD_EXP		:	       : Charger watchdog detected
 ab8500-gpadc             : HW_CONV_END          : vddadc       : Analogue to Digital Converter
                            SW_CONV_END          :              :
-ab8500-gpio              :                      :              : GPIO Controller
+ab8500-gpio              :                      :              : GPIO Controller (AB8500)
+ab8505-gpio              :                      :              : GPIO Controller (AB8505)
 ab8500-ponkey            : ONKEY_DBF            :              : Power-on Key
                            ONKEY_DBR            :              :
 ab8500-pwm               :                      :              : Pulse Width Modulator
-ab8500-regulator         :                      :              : Regulators
+ab8500-regulator         :                      :              : Regulators (AB8500)
+ab8505-regulator         :                      :              : Regulators (AB8505)
 ab8500-rtc               : 60S                  :              : Real Time Clock
                          : ALARM                :              :
 ab8500-sysctrl           :                      :              : System Control
-- 
2.23.0


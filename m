Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B060C3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 11:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D1321726
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 11:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="WtnDF4O+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388066AbfHVLIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 07:08:49 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:9551 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388054AbfHVLIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 07:08:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1566472123;
        s=strato-dkim-0002; d=gerhold.net;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=yvf49CAu3fmg+P2WBBt8i91nERkxMMvX30Z/QFcWGDY=;
        b=WtnDF4O+YxXJ4u6AOxLm+DDt64PwCd30OOX14uNzwG4KFZdgtyB2GRq+tYyfBDZc1Z
        ftcmoPNL9VV6T+VqFV6W6aBVZSOgWiRL6cRJEKndKvE/44aqfar8Iy9hkow7CRx6PlcU
        PkJU4ZQ+eRMaa2EPA1f3GpJ3jrdhzqc6A/AztaE+Z3PQ+D+goiWVYA1634luJXVvEyw0
        p8DNFdS6UBfV77iwz9zbskE3I3yMMQXD8DP2hTTjScmRSjwm1XX5KBOF/zeGWZJVTr5v
        EEQmQav2+oH3zxJ5qQuVBa6P+W0jhDv8FuNrx/ws5nkwml4fmAKuHJ7m4gtV779yD8zk
        AcfQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQr4OGUPX+1RgWArOaRE="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 44.26.1 DYNA|AUTH)
        with ESMTPSA id g064fdv7MB8heHu
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 22 Aug 2019 13:08:43 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 2/2] ARM: dts: ux500: Remove ab8500_ldo_usb regulator from device tree
Date:   Thu, 22 Aug 2019 13:07:20 +0200
Message-Id: <20190822110720.118828-2-stephan@gerhold.net>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190822110720.118828-1-stephan@gerhold.net>
References: <20190822110720.118828-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for the USB regulator of AB8500 was removed in
commit 41a06aa738ad ("regulator: ab8500: Remove USB regulator").
However, the configuration was never removed from the device tree.

It does no longer have any effect, remove it from the device tree.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm/boot/dts/ste-ab8500.dtsi  | 4 ----
 arch/arm/boot/dts/ste-href.dtsi    | 4 ----
 arch/arm/boot/dts/ste-snowball.dts | 4 ----
 3 files changed, 12 deletions(-)

diff --git a/arch/arm/boot/dts/ste-ab8500.dtsi b/arch/arm/boot/dts/ste-ab8500.dtsi
index 3ef1906e375c..55fff4d44277 100644
--- a/arch/arm/boot/dts/ste-ab8500.dtsi
+++ b/arch/arm/boot/dts/ste-ab8500.dtsi
@@ -182,10 +182,6 @@
 					ab8500_ldo_tvout_reg: ab8500_ldo_tvout {
 					};
 
-					// supply for ab8500-usb; USB LDO
-					ab8500_ldo_usb_reg: ab8500_ldo_usb {
-					};
-
 					// supply for ab8500-vaudio; VAUDIO LDO
 					ab8500_ldo_audio_reg: ab8500_ldo_audio {
 					};
diff --git a/arch/arm/boot/dts/ste-href.dtsi b/arch/arm/boot/dts/ste-href.dtsi
index 6422c53f2046..4f6acbd8c040 100644
--- a/arch/arm/boot/dts/ste-href.dtsi
+++ b/arch/arm/boot/dts/ste-href.dtsi
@@ -234,10 +234,6 @@
 						regulator-name = "V-TVOUT";
 					};
 
-					ab8500_ldo_usb_reg: ab8500_ldo_usb {
-						regulator-name = "dummy";
-					};
-
 					ab8500_ldo_audio_reg: ab8500_ldo_audio {
 						regulator-name = "V-AUD";
 					};
diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index 3428290644ba..c6074912c368 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -474,10 +474,6 @@
 						regulator-name = "V-TVOUT";
 					};
 
-					ab8500_ldo_usb_reg: ab8500_ldo_usb {
-						regulator-name = "dummy";
-					};
-
 					ab8500_ldo_audio_reg: ab8500_ldo_audio {
 						regulator-name = "V-AUD";
 					};
-- 
2.22.1


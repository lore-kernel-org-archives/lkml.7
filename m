Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134F8C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 23:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D8F20644
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 23:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfECXFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 19:05:36 -0400
Received: from mail2.sp2max.com.br ([138.185.4.9]:50460 "EHLO
        mail2.sp2max.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfECXFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 19:05:36 -0400
Received: from pgsop.sopnet.com.ar (unknown [179.40.38.12])
        (Authenticated sender: pablo@fliagreco.com.ar)
        by mail2.sp2max.com.br (Postfix) with ESMTPA id DCD307B305F;
        Fri,  3 May 2019 20:05:25 -0300 (-03)
From:   Pablo Greco <pgreco@centosproject.org>
To:     linux-sunxi@googlegroups.com
Cc:     Pablo Greco <pgreco@centosproject.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: sun8i: r40: bananapi-m2-ultra: Remove regulator-always-on
Date:   Fri,  3 May 2019 20:05:19 -0300
Message-Id: <1556924720-49372-1-git-send-email-pgreco@centosproject.org>
X-Mailer: git-send-email 1.8.3.1
X-SP2Max-MailScanner-Information: Please contact the ISP for more information
X-SP2Max-MailScanner-ID: DCD307B305F.A4ECF
X-SP2Max-MailScanner: Sem Virus encontrado
X-SP2Max-MailScanner-SpamCheck: nao spam, SpamAssassin (not cached,
        escore=-2.9, requerido 6, autolearn=not spam, ALL_TRUSTED -1.00,
        BAYES_00 -1.90)
X-SP2Max-MailScanner-From: pgreco@centosproject.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the regulators are tied to the GPIO bank, we can remove the
unneeded regulator-always-on in reg_aldo2

Signed-off-by: Pablo Greco <pgreco@centosproject.org>
---
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
index 699579d..42d62d1 100644
--- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
+++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
@@ -210,7 +210,6 @@
 };
 
 &reg_aldo2 {
-	regulator-always-on;
 	regulator-min-microvolt = <2500000>;
 	regulator-max-microvolt = <2500000>;
 	regulator-name = "vcc-pa";
-- 
1.8.3.1


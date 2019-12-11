Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B11C2BD09
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 05:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE947214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 05:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="wETvnV3e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfLKFG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 00:06:57 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:40411 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfLKFG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 00:06:56 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id xBB56RdY030450;
        Wed, 11 Dec 2019 14:06:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com xBB56RdY030450
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1576040787;
        bh=YtASyUS1UyPV1rSLOWOP9wW3Od7ds2m3vN7ApaY5Vfk=;
        h=From:To:Cc:Subject:Date:From;
        b=wETvnV3eobnEfUxcfdrivgO82tMV7fypCJBC97uKPCtRZvBqSnX+wRrmycB4wcwqr
         2LdRYpXlhvJJ4JfIQiSnT2CV47XRCFdMX2db1cudzBBl2pftJTTF8EzLKQPTCmi0Vx
         BM1cZThZlpcfGGh9E6w0IWhzkivvtHIEWTsegbU36FRY3koZVJf3Si99IIAMB7dNhV
         MjkLuruE26sH3PuCfkVLTzkkbr76wOEY9TGwONrfv1SXKvVqqMvwtWKMopwPwvxj4O
         VdAc6J2/qbev64v/DwyvDY8TueYY369O0WvBJQFTyaNHtD/Zli95wugqYqRQWiEp1A
         /6uPLEXMOZIXA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: uniphier: add pinmux nodes for I2C ch5, ch6
Date:   Wed, 11 Dec 2019 14:06:26 +0900
Message-Id: <20191211050626.862-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The next generation SoC can connect on-board slave devices via
I2C ch5 and ch6.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-pinctrl.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-pinctrl.dtsi b/arch/arm/boot/dts/uniphier-pinctrl.dtsi
index 1fee5ffbfb9c..bfdfb764b25b 100644
--- a/arch/arm/boot/dts/uniphier-pinctrl.dtsi
+++ b/arch/arm/boot/dts/uniphier-pinctrl.dtsi
@@ -106,6 +106,16 @@
 		function = "i2c4";
 	};
 
+	pinctrl_i2c5: i2c5 {
+		groups = "i2c5";
+		function = "i2c5";
+	};
+
+	pinctrl_i2c6: i2c6 {
+		groups = "i2c6";
+		function = "i2c6";
+	};
+
 	pinctrl_nand: nand {
 		groups = "nand";
 		function = "nand";
-- 
2.17.1


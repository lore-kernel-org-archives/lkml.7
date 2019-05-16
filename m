Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8B6C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 09:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F712082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 09:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="jH2ib0aB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfEPJh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 05:37:56 -0400
Received: from plaes.org ([188.166.43.21]:58908 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbfEPJhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 05:37:55 -0400
X-Greylist: delayed 542 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 May 2019 05:37:55 EDT
Received: from localhost (unknown [IPv6:2001:bb8:4008:20:21a:64ff:fe97:f60])
        by plaes.org (Postfix) with ESMTPSA id 69D87403C4;
        Thu, 16 May 2019 09:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1557998932; bh=kd8HHQHYAXLACCGTSACw8a42kGWpfQ/F8JYYcsX/XT8=;
        h=From:To:Cc:Subject:Date:From;
        b=jH2ib0aB8kM/3QqLSov54Qsvzt1Gz6UDaSf3xKUE1ERRcNWA6GTDMwbatPoPCYAl8
         0sUvQhWVe4kOF96+8yUpsrTcIOJj9lnO4kHOzRh5y2pPmBMDseHcBu+M4k8ZAfhxPt
         78eWowcQbsKwn8f4OkVKsaO3a32bZHhXIaZo9qJKJEcn8D1+VuT/stjcPvsAzuxH9i
         RoVCd9nLHBTKd3cInIc2R+elbR1EBV5BD+iOZZ0sjka1YNDLqTqbJRkRAaDXvx7bTC
         GF+iMeunzSF4JAQXJlhjVhC2SLGnvLyYd7VYdHJX72afshMvMxm26NI3BXSkjXMo8x
         hRMXmq4JAoSOQ==
From:   Priit Laes <plaes@plaes.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux-sunxi@googlegroups.com, Priit Laes <plaes@plaes.org>
Subject: [PATCH] ARM: dts: sun7i: olimex-lime2: Enable ac and power supplies
Date:   Thu, 16 May 2019 12:28:50 +0300
Message-Id: <20190516092850.3200-1-plaes@plaes.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lime2 has battery connector so enable these supplies.

Signed-off-by: Priit Laes <plaes@plaes.org>
---
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
index 9c8eecf4337a..9001b5527615 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
@@ -206,6 +206,14 @@
 
 #include "axp209.dtsi"
 
+&ac_power_supply {
+	status = "okay";
+};
+
+&battery_power_supply {
+	status = "okay";
+};
+
 &reg_dcdc2 {
 	regulator-always-on;
 	regulator-min-microvolt = <1000000>;
-- 
2.11.0


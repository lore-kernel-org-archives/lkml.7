Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F30C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 06:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B212520883
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 06:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="TEvuUTVh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfE1Gft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 02:35:49 -0400
Received: from plaes.org ([188.166.43.21]:52992 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbfE1Gfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 02:35:48 -0400
Received: from localhost (unknown [IPv6:2001:bb8:4008:20:21a:64ff:fe97:f60])
        by plaes.org (Postfix) with ESMTPSA id 5DC37402DD;
        Tue, 28 May 2019 06:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1559025346; bh=kd8HHQHYAXLACCGTSACw8a42kGWpfQ/F8JYYcsX/XT8=;
        h=From:To:Cc:Subject:Date:From;
        b=TEvuUTVh4pdYVKL7ECC0h7Ez7SmZsh0B4YFSfMl45Rbi7nTqCc2Jnzif3X4dc4CoY
         Tg8dPecXfAaXSevxJfhYMoEhorkYaKojfRIZki/o6HYZDgo6/bhgI2K1qwrodsADDK
         4MRg5ryjdllptfioOBCNuB+dz07JwUuK0mTchhRF7OnJJaW5BFyFvPpnI3EnTo5iqv
         WSTelNes6qCy06XKhN2cQ+cs/hyVN5vbzPchFJmLQSN1GUGKfhBb/V80Z3P/dFXBqA
         o1jiiInXe7Zz2JUM2X7bZiR6yFHk6f1UqNFQZ/k1pjtnfKOmpx6rLkw4DZvPxn6wdv
         xoBA6jJCBd9Iw==
From:   Priit Laes <plaes@plaes.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux-sunxi@googlegroups.com, Priit Laes <plaes@plaes.org>
Subject: [RESEND PATCH] ARM: dts: sun7i: olimex-lime2: Enable ac and power supplies
Date:   Tue, 28 May 2019 09:35:44 +0300
Message-Id: <20190528063544.17408-1-plaes@plaes.org>
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


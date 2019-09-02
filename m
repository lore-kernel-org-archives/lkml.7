Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE3DC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 10:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC46D21744
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 10:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="GBNH2xTn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731257AbfIBK4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 06:56:07 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.81]:33273 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbfIBK4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 06:56:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1567421762;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=066Rqa4dJD1flQL69Q2YCPKoI7wVEYGXrGAi/IMoM5o=;
        b=GBNH2xTnuZB04j9PeDOkPNquE4mcMt2YC7oR/dBhTfhRcqXsA9QXvDk2yUjr0JpI7f
        aeGxCFvxXm2l3cRCTWloSHT2pG+UK8ckuyVxDxcyXqUZ0RYq13Ih9NIUnCks9m4H3CQe
        JOtJLZhuxZo38/rJ3Zp0RLqlnQafcFxqaH0LY7iE7xQOOlyCPv4DXgfnyR7rF/BujwFq
        nqxv64vldP1t8ZCfWaxpqodRWmbLukLRi965jQ4frB/fRsLLzsVM2U0aG6XVhPT7DQOx
        rfLtpldEoebyADxfArOpZ8LAVB3c4oFFLpqd5LbS4/+fcky4IEamJEak/FJUAzjOfIwp
        h8UA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1mfYzBGHXL8GTnvuHRT"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.27.0 DYNA|AUTH)
        with ESMTPSA id u036f9v82AtsPvk
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 2 Sep 2019 12:55:54 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        =?UTF-8?q?Andr=C3=A9=20Roth?= <neolynx@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [RFC 3/5] ARM: dts: omap3-evm-37xx: fix compatible from omap3630 to omap36xx
Date:   Mon,  2 Sep 2019 12:55:49 +0200
Message-Id: <ed0a59b81da33ec0989cffb94b07091f95c4927e.1567421751.git.hns@goldelico.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1567421750.git.hns@goldelico.com>
References: <cover.1567421750.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All other boards use compatible = "omap36xx".

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-evm-37xx.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-evm-37xx.dts b/arch/arm/boot/dts/omap3-evm-37xx.dts
index e0c0382388f0..311550ee4eae 100644
--- a/arch/arm/boot/dts/omap3-evm-37xx.dts
+++ b/arch/arm/boot/dts/omap3-evm-37xx.dts
@@ -10,7 +10,7 @@
 
 / {
 	model = "TI OMAP37XX EVM (TMDSEVM3730)";
-	compatible = "ti,omap3-evm-37xx", "ti,omap3630", "ti,omap3";
+	compatible = "ti,omap3-evm-37xx", "ti,omap36xx", "ti,omap3";
 };
 
 &omap3_pmx_core2 {
-- 
2.19.1


Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE13FC47E49
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 01:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABAFA21897
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 01:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="p/uZlNxJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbfKBBOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 21:14:15 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:40031 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbfKBBOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 21:14:15 -0400
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 676BC22EE4;
        Sat,  2 Nov 2019 02:14:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
        s=mail2016061301; t=1572657253;
        bh=9jBTRlgT0tA/JEQgM/JP3C7ZF4qFmUkZTYW+fX9iAik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p/uZlNxJgtfiIuUuvwHsDubGyBJWiz44BmGk3uuwKtcKxU6Ou9av+FyogsT/xhcg0
         wp5uGtLQTETtpESAcXKbsRJZM27OlQT3bUWKKDCKYL3SoM36LoBSD776+139R2QF+F
         Qfy6Yr73Ueud8UO8981kvD4Haiq943iga8J/Ir10=
From:   Michael Walle <michael@walle.cc>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Michael Walle <michael@walle.cc>
Subject: [PATCH 1/5] net: phy: at803x: fix Kconfig description
Date:   Sat,  2 Nov 2019 02:13:47 +0100
Message-Id: <20191102011351.6467-2-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191102011351.6467-1-michael@walle.cc>
References: <20191102011351.6467-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.101.4 at web
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name of the PHY is actually AR803x not AT803x. Additionally, add the
name of the vendor and mention the AR8031 support.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/net/phy/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index fe602648b99f..1b884ebb4e48 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -282,11 +282,6 @@ config AX88796B_PHY
 	  Currently supports the Asix Electronics PHY found in the X-Surf 100
 	  AX88796B package.
 
-config AT803X_PHY
-	tristate "AT803X PHYs"
-	---help---
-	  Currently supports the AT8030 and AT8035 model
-
 config BCM63XX_PHY
 	tristate "Broadcom 63xx SOCs internal PHY"
 	depends on BCM63XX || COMPILE_TEST
@@ -444,6 +439,11 @@ config NXP_TJA11XX_PHY
 	---help---
 	  Currently supports the NXP TJA1100 and TJA1101 PHY.
 
+config AT803X_PHY
+	tristate "Qualcomm Atheros AR803X PHYs"
+	help
+	  Currently supports the AR8030, AR8031 and AR8035 model
+
 config QSEMI_PHY
 	tristate "Quality Semiconductor PHYs"
 	---help---
-- 
2.20.1


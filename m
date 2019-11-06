Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75D5C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 22:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E80221D82
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 22:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="S9twNAJZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732839AbfKFWg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 17:36:59 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:38597 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbfKFWg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 17:36:58 -0500
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 0628B23E46;
        Wed,  6 Nov 2019 23:36:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
        s=mail2016061301; t=1573079816;
        bh=KUmWb8hbgelgYHG2KnGE1LTw4puVHmuuwDCpfOcUbkU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S9twNAJZmEaGqc4NmAviYdUHZPx8o5ApHJdNlgIUKv+ykTLW0waCall5IlfZ+v11B
         rUQAkxSCepUC12EkVmA4yxbcX5m7WKWmWKAKYbi5xMQmU4FLGJ0tc3fqNDy+OGJ5/z
         KFt0Zt/HWVyRBxVxDQTt3bYiL7IUVIKIP0e9jC/Q=
From:   Michael Walle <michael@walle.cc>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, David Miller <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Simon Horman <simon.horman@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 1/6] net: phy: at803x: fix Kconfig description
Date:   Wed,  6 Nov 2019 23:36:12 +0100
Message-Id: <20191106223617.1655-2-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191106223617.1655-1-michael@walle.cc>
References: <20191106223617.1655-1-michael@walle.cc>
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
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
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


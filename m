Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E0AC74A23
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 13:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8BF320861
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 13:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfGJNo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 09:44:28 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:38563 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbfGJNoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 09:44:24 -0400
X-Originating-IP: 92.137.69.152
Received: from localhost (alyon-656-1-672-152.w92-137.abo.wanadoo.fr [92.137.69.152])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id E31E6E000C;
        Wed, 10 Jul 2019 13:44:20 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH v7 5/6] arm64: marvell: enable the  Armada 7K/8K CPU clk driver
Date:   Wed, 10 Jul 2019 15:43:45 +0200
Message-Id: <20190710134346.30239-6-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190710134346.30239-1-gregory.clement@bootlin.com>
References: <20190710134346.30239-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit makes sure the driver for the Armada 7K/8K CPU clock is
enabled.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 42eca656faa8..3cf5769fd17d 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -138,6 +138,7 @@ config ARCH_MESON
 
 config ARCH_MVEBU
 	bool "Marvell EBU SoC Family"
+	select ARMADA_AP_CPU_CLK
 	select ARMADA_AP806_SYSCON
 	select ARMADA_CP110_SYSCON
 	select ARMADA_37XX_CLK
-- 
2.20.1


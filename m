Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEA1CA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 22:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49BD521906
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 22:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="r3e8NuIr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfJ3WnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 18:43:05 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:53741 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfJ3WnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 18:43:05 -0400
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 41C4422EE3;
        Wed, 30 Oct 2019 23:43:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
        s=mail2016061301; t=1572475383;
        bh=LVpFkrvneLlxSnx5RW94rXimjPkbIlgIYaVp+0K1aq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r3e8NuIrMos30upFUridXoHzXwkLovyG8VyOa/KmBKF2LWijvK6RuRvB0KqLCG+6a
         vcPgZ6g+WEy8oICrrjGkmMWINbd+m4s6v5J46rbHHSJ77K9SltVyLuUdYGnLeVxZC7
         yXkY1PcbguCCprKNVLM4TCxLKgGRRE14IVK6Tufc=
From:   Michael Walle <michael@walle.cc>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Michael Walle <michael@walle.cc>
Subject: [RFC PATCH 1/3] net: phy: at803x: fix Kconfig description
Date:   Wed, 30 Oct 2019 23:42:49 +0100
Message-Id: <20191030224251.21578-2-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191030224251.21578-1-michael@walle.cc>
References: <20191030224251.21578-1-michael@walle.cc>
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
 drivers/net/phy/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index fe602648b99f..38f180f9ca42 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -283,9 +283,9 @@ config AX88796B_PHY
 	  AX88796B package.
 
 config AT803X_PHY
-	tristate "AT803X PHYs"
+	tristate "Atheros AR803X PHYs"
 	---help---
-	  Currently supports the AT8030 and AT8035 model
+	  Currently supports the AR8030, AR8031 and AR8035 model
 
 config BCM63XX_PHY
 	tristate "Broadcom 63xx SOCs internal PHY"
-- 
2.20.1


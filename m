Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F4AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D012184A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551366503;
	bh=sNqcpBrNbYAymDMCfOq+RbDaqf4p0AlS67Z91fAN9IU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AEXcklcM+gRHkilgSj8D0dQg7GfV7e0LOOlZuthiBrqbvz3YGfEdVtPmYECzaqmrb
	 yVybLGMetrvyq9iH9qQZ6PsYOGdezMrTD8/eKzVNUI/f7u7Nl2CEynl4Sw2o9g29vE
	 wO0BQFLs7IqGPvfoXENtLFOWQIkP4wuNLOsw8gaY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731169AbfB1PIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:08:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:40328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731275AbfB1PIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:08:18 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63542218B0;
        Thu, 28 Feb 2019 15:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366498;
        bh=sNqcpBrNbYAymDMCfOq+RbDaqf4p0AlS67Z91fAN9IU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xxo0G97Q9/+Sp/T4C0xGSYDz9i2QVWkxAp79M1ZR2C8LZA+tF97v6ps84ztMzIJeM
         Y/vtQi8vNUA4bKQmnubozQDTsg5UWXeJ/k+Il1B8lBWexgwPenf50Wu3n219OHuo+R
         n/h4ZDkiUvT3b2kZV1UVyb4tfiKSbM9iOOhdw3Es=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 03/81] ARM: dts: sun8i: h3: Add ethernet0 alias to Beelink X2
Date:   Thu, 28 Feb 2019 10:06:55 -0500
Message-Id: <20190228150813.10256-3-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228150813.10256-1-sashal@kernel.org>
References: <20190228150813.10256-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

[ Upstream commit cc4bddade114b696ab27c1a77cfc7040151306da ]

Because "ethernet0" alias is missing, U-Boot doesn't generate board
specific MAC address. Effect of this is random MAC address every boot
and thus new IP address is assigned to the board.

Fix this by adding alias.

Fixes: 7389172fc3ed ("ARM: dts: sun8i: h3: Enable dwmac-sun8i on the Beelink X2")
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
[Maxime: Removed unneeded comment]
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
index 5d23667dc2d2e..25540b7694d59 100644
--- a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
@@ -53,7 +53,7 @@
 
 	aliases {
 		serial0 = &uart0;
-		/* ethernet0 is the H3 emac, defined in sun8i-h3.dtsi */
+		ethernet0 = &emac;
 		ethernet1 = &sdiowifi;
 	};
 
-- 
2.19.1


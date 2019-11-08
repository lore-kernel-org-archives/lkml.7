Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B6AC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB4821924
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573214062;
	bh=H9WHMuJKONkrdmTXS911D1LW5nFnegvaA9HCD7XFBuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vgaOdh8/la1Mw4qLJSnLWZcSNWcGB75VxRL8Rccsy/lB3TxtGdSYZl8cGNg6XTdb8
	 i4RuDRBQABfAbtFxYfbaEqnO/COB4C5R7O3aIMSNi5pfs+XFPua3/D+YVGxvGORTYX
	 WZs3fMFCfzY7m4Tyx3Psn468O8nwIa16kTnK5BYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390089AbfKHLyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:54:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:34154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387396AbfKHLq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:46:26 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC2FA22480;
        Fri,  8 Nov 2019 11:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213585;
        bh=H9WHMuJKONkrdmTXS911D1LW5nFnegvaA9HCD7XFBuU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TB5xmufmBP2GtXEL8XlYALYua72jHi6k7sbfiNy+web34tF2b+IFnAYYoGH6ciRrh
         bnPecutFNrXHpKlQZoSVeTkkrtgy6jAuidW7VOz55qS0I0lDwaUZnGhIdiXYV7b4UY
         37i9hKsoWIumFF53lkinsH8zts+pin7RBr/A8iyU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 28/64] ARM: dts: omap3-gta04: give spi_lcd node a label so that we can overwrite in other DTS files
Date:   Fri,  8 Nov 2019 06:45:09 -0500
Message-Id: <20191108114545.15351-28-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108114545.15351-1-sashal@kernel.org>
References: <20191108114545.15351-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Nikolaus Schaller" <hns@goldelico.com>

[ Upstream commit fa0d7dc355c890725b6178dab0cc11b194203afa ]

needed for device variants based on GTA04 board but with
different display panel (driver).

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index b3a8b1f24499a..95c6ac44e307f 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -70,7 +70,7 @@
 		#sound-dai-cells = <0>;
 	};
 
-	spi_lcd {
+	spi_lcd: spi_lcd {
 		compatible = "spi-gpio";
 		#address-cells = <0x1>;
 		#size-cells = <0x0>;
-- 
2.20.1


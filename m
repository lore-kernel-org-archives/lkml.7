Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FAFC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 982E52071B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142430;
	bh=zFPQ1tZ8WPFC4nPv7rixmYalJ61USt/GBMONtM5RLm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bdl+zMMnLZrBKcROyuC5gcNNt6qX+14sVe7ENyzFmn/wNLEp5JKb5RSrkuBP1HqOf
	 6j6EbByAS12+Kp0q1olX6qJG2wmTYwZ+S/txO2mvbJSpnGNP+Bp8SVg8kkN05Amd1C
	 7IsdmYAIb6JldN5T+e0i/HBIcZQXlDQMKE+V9FKw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730912AbfKSFrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:47:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:43390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731195AbfKSFrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:47:06 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1535208CC;
        Tue, 19 Nov 2019 05:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142426;
        bh=zFPQ1tZ8WPFC4nPv7rixmYalJ61USt/GBMONtM5RLm0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IKWHRwjcgmnYWty9U1A4JqCA2gn73VzaXSqjo6u13tTVpX4PP1UeN9p4demolHZzO
         jOm5qYpo05O/kFjDaXvAdtghI0XNVmgTRZFgU3Y2HvG6nqLKz9rEoF5wpQiDkKGbWt
         F6wltoRT65b4riYVE4yLHTuTR1K7YgVarspzZj14=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 076/239] ARM: dts: omap3-gta04: give spi_lcd node a label so that we can overwrite in other DTS files
Date:   Tue, 19 Nov 2019 06:17:56 +0100
Message-Id: <20191119051314.135337130@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
References: <20191119051255.850204959@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: H. Nikolaus Schaller <hns@goldelico.com>

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
index 4504908c23fe9..0b0aa020a8d5d 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -71,7 +71,7 @@
 		#sound-dai-cells = <0>;
 	};
 
-	spi_lcd {
+	spi_lcd: spi_lcd {
 		compatible = "spi-gpio";
 		#address-cells = <0x1>;
 		#size-cells = <0x0>;
-- 
2.20.1




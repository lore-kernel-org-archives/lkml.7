Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923B7CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F53E20856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572450752;
	bh=eICZE3qefE9ZCdHbOAwX78xPp8umXPpj1jH6Sgk+c9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0BujVgCAHSdgkqv6vPPnjtBD1vB4va8N4KFW0eZAgLzFbOWgBXjQZFvVJuYVDvxUT
	 gSy7hwV7bEK7Vm05kwx6+SX6z2tuV6vbGA8T5TuwnzGuQJKT20XLUHyTVweIE54v9u
	 agvwkzAJ7L95CCQRkhJa7sLRq5ZrX617YPAk0xQA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbfJ3Pwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:52:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727547AbfJ3Pw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:52:26 -0400
Received: from sasha-vm.mshome.net (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1DC620856;
        Wed, 30 Oct 2019 15:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572450746;
        bh=eICZE3qefE9ZCdHbOAwX78xPp8umXPpj1jH6Sgk+c9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LAwxMTJXJs99KBdfn7wz+6vXbxn9d39NMn8GVSZUg/XU2lsoBauu8Q10eA0CxdITi
         rYJ5HMx8UqY99oQ523i9rjMB+PhXeFj9UVF+6Wil4njLoPw3DvXDHomAtpK9uJB5de
         hA8cFkxi1Ms2QrFiPdSHHCUx2qcAUDGupXRy0UXE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Soeren Moch <smoch@web.de>, Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 5.3 41/81] arm64: dts: rockchip: fix RockPro64 sdmmc settings
Date:   Wed, 30 Oct 2019 11:48:47 -0400
Message-Id: <20191030154928.9432-41-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191030154928.9432-1-sashal@kernel.org>
References: <20191030154928.9432-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Soeren Moch <smoch@web.de>

[ Upstream commit 5234c14531152702a9f3e575cb552b7e9cea9f94 ]

According to the RockPro64 schematic [1] the rk3399 sdmmc controller is
connected to a microSD (TF card) slot. Remove the cap-mmc-highspeed
property of the sdmmc controller, since no mmc card can be connected here.

[1] http://files.pine64.org/doc/rockpro64/rockpro64_v21-SCH.pdf

Fixes: e4f3fb490967 ("arm64: dts: rockchip: add initial dts support for Rockpro64")
Signed-off-by: Soeren Moch <smoch@web.de>
Link: https://lore.kernel.org/r/20191004203213.4995-1-smoch@web.de
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
index 1ff617230f6c4..99d65d2fca5e1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
@@ -613,7 +613,6 @@
 
 &sdmmc {
 	bus-width = <4>;
-	cap-mmc-highspeed;
 	cap-sd-highspeed;
 	cd-gpios = <&gpio0 7 GPIO_ACTIVE_LOW>;
 	disable-wp;
-- 
2.20.1


Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC665C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACFB2214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334241;
	bh=POioTTXZKI4CfItPHYq8TEC4Kjx/U6aX/MyYTSc8JqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a/FtRjg7wxOL7GHddUOLgqcVHaINIA241iCXkm1Q9/xakxKckwLQVBPUPCRWb3mTI
	 HBp+hHV3jQL+m3T95XPfDqzvKzWiTjrdGI1Kx7G+vg3SteQxtIMRAI0xuRbev/Fw0c
	 Fva1aETbYelh5MI+VS8xBKnoFdZ8fLqjtS47jhH4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbfCKT5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:57:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727830AbfCKT5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:57:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11BA82084F;
        Mon, 11 Mar 2019 19:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334237;
        bh=POioTTXZKI4CfItPHYq8TEC4Kjx/U6aX/MyYTSc8JqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=luKn4tqNo31/UpHoTwDnPP3To19t1z4WdRnZziTJdTIy2MWsDKkFZkiP5qdE15CvM
         JV8e/hPgGjhlWr7O7troiCkizMdjASQNVMsYaFHKmkFKnOVOG4sX7jpJTHfINtjIiR
         N4syX1DwVXJ/CQX71OtFPpGTaNMKmFUimXxrHKcg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 08/44] arm64: dts: rockchip: fix graph_port warning on rk3399 bob kevin and excavator
Date:   Mon, 11 Mar 2019 15:56:24 -0400
Message-Id: <20190311195700.138462-8-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195700.138462-1-sashal@kernel.org>
References: <20190311195700.138462-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Enric Balletbo i Serra <enric.balletbo@collabora.com>

[ Upstream commit 26cd8657c7e745686a4c54a5cccf721ede208a25 ]

Ports are described by child 'port' nodes contained in the device node.
'ports' is optional and is used to group all 'port' nodes which is not
the case here.

This patch fixes the following warnings:

arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts:25.9-29.5: Warning (graph_port): /edp-panel/ports: graph port node name should be 'port'
arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts:46.9-50.5: Warningi (graph_port): /edp-panel/ports: graph port node name should be 'port'
arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts:94.9-98.5: Warning (graph_port): /edp-panel/ports: graph port node name should be 'port'

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts            | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts          | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts b/arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts
index 1ee0dc0d9f10..d1cf404b8708 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts
@@ -22,7 +22,7 @@
 		backlight = <&backlight>;
 		power-supply = <&pp3300_disp>;
 
-		ports {
+		port {
 			panel_in_edp: endpoint {
 				remote-endpoint = <&edp_out_panel>;
 			};
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
index 2cc7c47d6a85..65637a5a4b21 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
@@ -43,7 +43,7 @@
 		backlight = <&backlight>;
 		power-supply = <&pp3300_disp>;
 
-		ports {
+		port {
 			panel_in_edp: endpoint {
 				remote-endpoint = <&edp_out_panel>;
 			};
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts b/arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts
index fef2c0608999..b14d83919f14 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts
@@ -50,7 +50,7 @@
 		pinctrl-0 = <&lcd_panel_reset>;
 		power-supply = <&vcc3v3_s0>;
 
-		ports {
+		port {
 			panel_in_edp: endpoint {
 				remote-endpoint = <&edp_out_panel>;
 			};
-- 
2.19.1


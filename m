Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EC8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 063F82192B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255846;
	bh=xEQvpefz+2BL5BbUwZKsEPzWuI+VpLJYfud0x8LzfOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q/0o4/QT6ERkL7B8VsIp4rruAd8rkOtsJrp2lHxeBfCgi2WyreSY1z9/HcGWz5lUq
	 /8wdPKixbtVLunCUA/hornl2ZLv2/h/nkC/aXiaFeHElhGHXSRfOeklaJVWVQpfIht
	 /Au1ja/koIL0hqyk2lizkRAk7xmKz5YIzdGcqCdg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387647AbfCVL5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:57:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:33776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387636AbfCVL5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:57:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7666221916;
        Fri, 22 Mar 2019 11:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255838;
        bh=xEQvpefz+2BL5BbUwZKsEPzWuI+VpLJYfud0x8LzfOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xs88PqJI3p1IBl8fQoGy3l9rFDE/ojTWHwr6e/Wkhqy3J81tkTSh1jX6kcExTJris
         xse6ZxZWmvt6pANbMH6SifuaujR7hlrrxOwhL+2o/v/hFopPyrH/Fk9rMRL4mitqvB
         mr1Us5HfszlkR6rXNcb90hdqtCePjQacuTj4owSs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 030/280] arm64: dts: rockchip: fix graph_port warning on rk3399 bob kevin and excavator
Date:   Fri, 22 Mar 2019 12:13:03 +0100
Message-Id: <20190322111307.994373591@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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




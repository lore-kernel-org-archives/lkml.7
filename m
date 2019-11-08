Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE837FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4FA2085B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573214689;
	bh=O+hpQNM8vSWD7A1+s0aJwWD0EvD+GBBQijCDJuTiYxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PZ5yg/rk56J7we0vuUxSUPNjUBAItkthc3/ferXgrHYRvD2poOjfCzdUeFcgbLBrB
	 nAOzynVGJo7IAcRto4CzKFjBpNbYmwDxqBl1CDM9S2Yy7sFKbudtfNBMT4nfW1EBLr
	 WaaA9khz4Ly9A+zLL+0cJBOeLbZbVE44043FuFPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391525AbfKHMEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 07:04:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:55602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733104AbfKHLmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:42:01 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF7BB21D82;
        Fri,  8 Nov 2019 11:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213320;
        bh=O+hpQNM8vSWD7A1+s0aJwWD0EvD+GBBQijCDJuTiYxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uRx+gVqzzuoazu4GYljMpM/ortNfG/NbCefMYhm33XWKUWyLZrq0R+fSv/9e7XqAa
         jAA84ymRkoiBt3heJJQGGOxihzJgQh+g1WxgfZ2ufM8JcUm7ljKPrLpHFSb4v2dQCw
         xgRANwWWIOHk+SYja8LITBLE+sBeRPUKZmMPK288=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 164/205] arm64: dts: meson-axg: use the proper compatible for ethmac
Date:   Fri,  8 Nov 2019 06:37:11 -0500
Message-Id: <20191108113752.12502-164-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neil Armstrong <narmstrong@baylibre.com>

[ Upstream commit eaf8f57c0bf5451132932616ab62f9481adefb55 ]

Use the correct compatible for the AXG ethernet mac node.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index c518130e5ce73..3c34f14fa5086 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -458,7 +458,7 @@
 		};
 
 		ethmac: ethernet@ff3f0000 {
-			compatible = "amlogic,meson-gxbb-dwmac", "snps,dwmac";
+			compatible = "amlogic,meson-axg-dwmac", "snps,dwmac";
 			reg = <0x0 0xff3f0000 0x0 0x10000
 				0x0 0xff634540 0x0 0x8>;
 			interrupts = <GIC_SPI 8 IRQ_TYPE_EDGE_RISING>;
-- 
2.20.1


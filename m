Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99A1C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC3B208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141541;
	bh=O+hpQNM8vSWD7A1+s0aJwWD0EvD+GBBQijCDJuTiYxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2mBJpFYoNqjBCc7qXkOi3p33fRv81ReADyiGqP3BdmQopekfQhd2DtJOCUpssGopE
	 s+YuNBXwrcJI7UuMPa4L7biwMkrkSZLNbr8+T/J6dMG6z6Raya3NyUDE82ZRMLHwGo
	 JGNPuxA9OkS0JEfHh9RaFygMvgvgMi/69z3xDedE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbfKSFcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:32:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:52518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728595AbfKSFcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:32:16 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C56C8208C3;
        Tue, 19 Nov 2019 05:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141536;
        bh=O+hpQNM8vSWD7A1+s0aJwWD0EvD+GBBQijCDJuTiYxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fjDb3CF4ZS4nJHc3QHtF53YLOQ0z+c12rmBBiYcGOr+AVKTLchQI5OUODO9RsHWNh
         OAVxSWpmv0tJOZPsO+eFjbJdYtfJ61yso1rvqscRYZtQuX77OxlwEoFJocYtukDTpJ
         UJULb8woBAxz50dDNED0ID08by05xbIsYEPxzkR8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 195/422] arm64: dts: meson-axg: use the proper compatible for ethmac
Date:   Tue, 19 Nov 2019 06:16:32 +0100
Message-Id: <20191119051411.192443800@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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




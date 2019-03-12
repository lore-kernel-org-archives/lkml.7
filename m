Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E55C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C8C205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413926;
	bh=2+f/W6oiNq8/wEKYnKmYnCE/jlWKyAuzIpIslB8bIcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=En90Ni6PXM2WXquTekuToHYEUayMEAF5s3f0jlAazqsYDV5K29NvozuQeMuTNkOJk
	 jAwxHmiM7mO8k/cfMg+dbIoClytMhDagQ9pYqgZ8voQciCAL7X4sBiSyic8iZGzkto
	 mBg65ZXaPSgYqQR3pdQW/qvIjtwonSsxDoAXrQXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbfCLSFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:05:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:48272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727581AbfCLRMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:12:40 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F202206DF;
        Tue, 12 Mar 2019 17:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410759;
        bh=2+f/W6oiNq8/wEKYnKmYnCE/jlWKyAuzIpIslB8bIcE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=snfuTwge5Wc8pm60Q+p95dD92+c/b7+FXx0NlCg5SzqiOhN1HiiFbVJ7d4HIWPHQY
         a0WjdTIxExtn8LN6EC24rn8gHaDzLvhKxglSNU/fxaQKzdxGfJPwQXSNz46NDsPD9s
         rwtPUq+N1qh8LbMfgXll/OZPYvi7vNQT/vqkMdIM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiko Schocher <hs@denx.de>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 091/171] ARM: dts: am335x-shc.dts: fix wrong cd pin level
Date:   Tue, 12 Mar 2019 10:07:51 -0700
Message-Id: <20190312170355.800033027@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 063c20e12f8bbbc10cabc2413606b140085beb62 ]

cd pin on mmc1 is GPIO_ACTIVE_LOW not GPIO_ACTIVE_HIGH

Fixes: e63201f19438 ("mmc: omap_hsmmc: Delete platform data GPIO CD and WP")
Signed-off-by: Heiko Schocher <hs@denx.de>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/am335x-shc.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-shc.dts b/arch/arm/boot/dts/am335x-shc.dts
index 1d925ed2b102..8fbbad11a80c 100644
--- a/arch/arm/boot/dts/am335x-shc.dts
+++ b/arch/arm/boot/dts/am335x-shc.dts
@@ -215,7 +215,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
 	bus-width = <0x4>;
-	cd-gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
+	cd-gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
 	cd-inverted;
 	max-frequency = <26000000>;
 	vmmc-supply = <&vmmcsd_fixed>;
-- 
2.19.1




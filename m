Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AA6C10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5FD20882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554365862;
	bh=0cUF760ZQ1xbrU/qpL0iZGhnBhp2iq/+jRwQ7EUXlMY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=JN1j8Sq+z6aUWUq5B8PgcXq024VetET/DrVyIujFQm9g0Jdid7JwmYSjoFmEYGsP1
	 qpTJcF5LTe5ErkUMnSC8EZtOG7YNbZaHX9ZRK+Gl53H8yUUIbZ2rM/8uOnvXaGydK8
	 vjh+mAC18soP5QmfFU/mZ6G42b4SNNqsPVSAXzHg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbfDDIRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:17:41 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50812 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728698AbfDDIRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:17:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=fNooqyxM34aHEVQCIchrHIYTKgW6Wmag4Ee+l+yfzmI=; b=dmQnR/EWgEZb
        xzQ1yM0IZ7tqWndgVnUU6OgFmXpj3FyK8Q2CakFZDhCrNUOyr/S2lxvTLesC+YF5cJ1ZfraNg+TrR
        nqz5Rzj0B0YZ4X0ZOoKT00moxE0c9OTpAw4W6cd7QVV4RkzlJ1nEUmceBMofupzvee0RXA/w/44Mz
        nFmHs=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBxYF-00051s-Om; Thu, 04 Apr 2019 08:16:48 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id E1230441D3E; Thu,  4 Apr 2019 15:16:43 +0700 (+07)
From:   Mark Brown <broonie@kernel.org>
To:     Sugar Zhang <sugar.zhang@rock-chips.com>
Cc:     Mark Brown <broonie@kernel.org>, heiko@sntech.de,
        broonie@kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Subject: Applied "dt-bindings: sound: rockchip: add compatible for rk3308/px30" to the asoc tree
In-Reply-To:  <1554349995-23944-1-git-send-email-sugar.zhang@rock-chips.com>
X-Patchwork-Hint: ignore
Message-Id: <20190404081643.E1230441D3E@finisterre.ee.mobilebroadband>
Date:   Thu,  4 Apr 2019 15:16:43 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   dt-bindings: sound: rockchip: add compatible for rk3308/px30

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 6bfff707985fff14fa79c851e53f9630e76a4860 Mon Sep 17 00:00:00 2001
From: Sugar Zhang <sugar.zhang@rock-chips.com>
Date: Thu, 4 Apr 2019 11:53:15 +0800
Subject: [PATCH] dt-bindings: sound: rockchip: add compatible for rk3308/px30

This patch adds bindings for rk3308/px30.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/rockchip,pdm.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip,pdm.txt b/Documentation/devicetree/bindings/sound/rockchip,pdm.txt
index 47f164fbd1d7..3e0eb7354ba6 100644
--- a/Documentation/devicetree/bindings/sound/rockchip,pdm.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip,pdm.txt
@@ -3,6 +3,8 @@
 Required properties:
 
 - compatible: "rockchip,pdm"
+  - "rockchip,px30-pdm"
+  - "rockchip,rk3308-pdm"
 - reg: physical base address of the controller and length of memory mapped
   region.
 - dmas: DMA specifiers for rx dma. See the DMA client binding,
@@ -12,6 +14,8 @@ Required properties:
 - clock-names: should contain following:
    - "pdm_hclk": clock for PDM BUS
    - "pdm_clk" : clock for PDM controller
+- resets: a list of phandle + reset-specifer paris, one for each entry in reset-names.
+- reset-names: reset names, should include "pdm-m".
 - pinctrl-names: Must contain a "default" entry.
 - pinctrl-N: One property must exist for each entry in
 	     pinctrl-names. See ../pinctrl/pinctrl-bindings.txt
-- 
2.20.1


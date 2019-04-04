Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41712C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111FC2171F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554365823;
	bh=DxmDFyvsJMaZBt2kImIPHGHtFjBKZ2lR1EORtriPXEQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=HVm+cChOr/RQ4c/qvQMRWRQ6hopzd4O3SLFx4UItMQ+VfXErBW8kQQReY5ehW81rT
	 KEFF+V3zkY7CKcNbn6Lf0/DComDvA1651sfksMEu3fmm+DPGcfBZlDQZPdM0AkIRYn
	 H2whKLU+OoU6ApBlardzgbKX4GTM5praGKcZx5h8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbfDDIRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:17:01 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50748 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfDDIQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:16:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ZSt2x4mIRF61VBd74288zKTDRhmLXsqhfoQCOXwJsFs=; b=ZjLnh9Yp1WjX
        n1xknBgd8G3zRGQNiHS6ftP7u1hxrl6qageUZOsm9RqdAMdYa33M2pJCbZSjPo9eycDMAG+7cXV4L
        Oj72ZDjyHO1XG/bslabYSdC+j1UAnjHArP8CdWEbEmEtvmvzkncIM/KFerEBVPBKeGSDMnSquhzS6
        DPddg=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBxYD-00051W-J3; Thu, 04 Apr 2019 08:16:46 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 77C79441D3D; Thu,  4 Apr 2019 15:16:37 +0700 (+07)
From:   Mark Brown <broonie@kernel.org>
To:     Sugar Zhang <sugar.zhang@rock-chips.com>
Cc:     Mark Brown <broonie@kernel.org>, heiko@sntech.de,
        broonie@kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Subject: Applied "dt-bindings: sound: add compatible for rk1808" to the asoc tree
In-Reply-To:  <1554350145-24198-1-git-send-email-sugar.zhang@rock-chips.com>
X-Patchwork-Hint: ignore
Message-Id: <20190404081637.77C79441D3D@finisterre.ee.mobilebroadband>
Date:   Thu,  4 Apr 2019 15:16:37 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   dt-bindings: sound: add compatible for rk1808

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

From 2a050b7a746e2c59a733a3641eb1c01cf2e573b4 Mon Sep 17 00:00:00 2001
From: Sugar Zhang <sugar.zhang@rock-chips.com>
Date: Thu, 4 Apr 2019 11:55:45 +0800
Subject: [PATCH] dt-bindings: sound: add compatible for rk1808

This patch adds bindings for rk1808 soc.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/rockchip,pdm.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip,pdm.txt b/Documentation/devicetree/bindings/sound/rockchip,pdm.txt
index 3e0eb7354ba6..98572a25122f 100644
--- a/Documentation/devicetree/bindings/sound/rockchip,pdm.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip,pdm.txt
@@ -4,6 +4,7 @@ Required properties:
 
 - compatible: "rockchip,pdm"
   - "rockchip,px30-pdm"
+  - "rockchip,rk1808-pdm"
   - "rockchip,rk3308-pdm"
 - reg: physical base address of the controller and length of memory mapped
   region.
-- 
2.20.1


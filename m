Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CFBC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FCE8208E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554708828;
	bh=d5VGHFiT5qEhSD4XieXKYCzu88uEDGAi4s0W1iICO0c=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=TvP91UiUFGkh0LEyl5PA9nGKnHq5HwXYUaV2ubE3vX5XhdVBEYDk7JF2H1HMOhx5t
	 mWP0cT8Lq59low9AUE+3YILYCzd9VF5FtWXa4rayTorp67MW1Zyh5nl91FCx3YoL8d
	 KH8n2JxOrPdTEO2QY9mcwLODR89rBezJNuWbi4UU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfDHHdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:33:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46716 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfDHHdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:33:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=il5M6Thq8kPtFHK4gYBZhZ16Q+tE8hb6y/KVQbmfV7I=; b=p4f8JnY8VU2P
        qXFvw9tk7XiXykUceAoe8rzpGLzyaux1gcOTFmBQaglk52JGbru/7pGxjkVrwiPbAMkflYfvNVW6C
        V0WzFvAgEqpP4CJkkUNCLVA5jzPGTWGViOR8Rn5FzgToNQSrfGw5O+G7NqklR9j45+cfYpwal+bG8
        iVL5A=;
Received: from [8.46.76.46] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hDOme-000403-8Z; Mon, 08 Apr 2019 07:33:37 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id BFBA8441D3B; Mon,  8 Apr 2019 14:33:24 +0700 (+07)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Hulk Robot <hulkci@huawei.com>, Mark Brown <broonie@kernel.org>,
        broonie@kernel.org, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        eric@anholt.net, stefan.wahren@i2se.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: bcm2835aux: Fix build error without CONFIG_DEBUG_FS" to the spi tree
In-Reply-To:  <20190406151457.32104-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190408073324.BFBA8441D3B@finisterre.ee.mobilebroadband>
Date:   Mon,  8 Apr 2019 14:33:24 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: bcm2835aux: Fix build error without CONFIG_DEBUG_FS

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

From 9b186e9a65bffaef5ed56878095544b64584c29c Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Sat, 6 Apr 2019 23:14:57 +0800
Subject: [PATCH] spi: bcm2835aux: Fix build error without CONFIG_DEBUG_FS

When building CONFIG_DEBUG_FS is not set
gcc warn this:

drivers/spi/spi-bcm2835aux.c: In function bcm2835aux_spi_probe:
drivers/spi/spi-bcm2835aux.c:591:2: error: too many arguments to function bcm2835aux_debugfs_create
  bcm2835aux_debugfs_create(bs, dev_name(&pdev->dev));
  ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/spi/spi-bcm2835aux.c:145:13: note: declared here
 static void bcm2835aux_debugfs_create(struct bcm2835aux_spi *bs)

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 8048d151eb4d ("spi: bcm2835aux: add driver stats to debugfs")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-bcm2835aux.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index fd8252dce4a2..bbf87adb3ff8 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -142,7 +142,8 @@ static void bcm2835aux_debugfs_remove(struct bcm2835aux_spi *bs)
 	bs->debugfs_dir = NULL;
 }
 #else
-static void bcm2835aux_debugfs_create(struct bcm2835aux_spi *bs)
+static void bcm2835aux_debugfs_create(struct bcm2835aux_spi *bs,
+				      const char *dname)
 {
 }
 
-- 
2.20.1


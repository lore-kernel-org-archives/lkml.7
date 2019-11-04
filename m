Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E9ECA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6862184C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572874050;
	bh=20SnpaG1EgbvORmKhBqTBCb/FuFlveobTD8Nf06CCOc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=qbnmXyylYpQuKyHkjiZd5SVY4jPjzrVq0eYjyk+K523BH1Sqipu3816E7Y94AnNdC
	 tCg8QOmUCSdcTZ+tBQGBP/ICnmKDZICiKEr476zpz3TmPycfJtoaGD0glE1rvhZ5xD
	 9CDdL0T3W7s7Ita3OfrjfH2Applhad1JI4ajV77M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbfKDN12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 08:27:28 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58156 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbfKDN11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 08:27:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=KjOFqC3LpLokCguUrWPascEa+8RC7whRG2pGwXHTHq8=; b=QPIbZUhyhI8A
        hrhMyqH9Y8uKjJ/GSa9AjVML7+vOEkULPQx7aokJ7+nONV3KEgTvrqgm0Dw3Yp/Q3aGZ74oBcHZzJ
        Y74BuMWwYT6zDR8a/HcI8vRV4Tb9pSWPgP7woVOkON65WkPn554k0tbYVltxUtr7OQBptg4KZdVE8
        +P1i8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iRcO2-0002f4-Vb; Mon, 04 Nov 2019 13:27:15 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 64AE3274301E; Mon,  4 Nov 2019 13:27:14 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, perex@perex.cz,
        tiwai@suse.com, zhongjiang@huawei.com
Subject: Applied "ASoC: ux500: Remove redundant variable "status"" to the asoc tree
In-Reply-To: <1572528855-25990-1-git-send-email-zhongjiang@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20191104132714.64AE3274301E@ypsilon.sirena.org.uk>
Date:   Mon,  4 Nov 2019 13:27:14 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: ux500: Remove redundant variable "status"

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.5

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

From e0859710516c98b189879966b48ea1c77e0cd979 Mon Sep 17 00:00:00 2001
From: zhong jiang <zhongjiang@huawei.com>
Date: Thu, 31 Oct 2019 21:34:15 +0800
Subject: [PATCH] ASoC: ux500: Remove redundant variable "status"

local variable "status" is not used. hence it is safe to remove and
just return 0.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
Link: https://lore.kernel.org/r/1572528855-25990-1-git-send-email-zhongjiang@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/ux500/ux500_msp_i2s.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/ux500/ux500_msp_i2s.c b/sound/soc/ux500/ux500_msp_i2s.c
index a90e0d7f0b73..394d8b2a4a16 100644
--- a/sound/soc/ux500/ux500_msp_i2s.c
+++ b/sound/soc/ux500/ux500_msp_i2s.c
@@ -533,7 +533,6 @@ static void disable_msp_tx(struct ux500_msp *msp)
 static int disable_msp(struct ux500_msp *msp, unsigned int dir)
 {
 	u32 reg_val_GCR;
-	int status = 0;
 	unsigned int disable_tx, disable_rx;
 
 	reg_val_GCR = readl(msp->registers + MSP_GCR);
@@ -566,7 +565,7 @@ static int disable_msp(struct ux500_msp *msp, unsigned int dir)
 	else if (disable_rx)
 		disable_msp_rx(msp);
 
-	return status;
+	return 0;
 }
 
 int ux500_msp_i2s_trigger(struct ux500_msp *msp, int cmd, int direction)
-- 
2.20.1


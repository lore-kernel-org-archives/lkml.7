Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F54C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 17:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF0A320828
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 17:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567705174;
	bh=KlZQtUVewqsP7ZIlPYUIB62uAyxzUuQsn+6PGWIWFHE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=MPFOMSM3QzJdX8xvsoorcu+JfS08nHixQyWEIHzlZ9LibNSfSrAbQo+AaDpL2fJ3Z
	 dCOrqNTxbDJiYB57beo08l3rTpDgnQuHrsvfIsT3NZ6PRrSeNWqN0+nTMRoh6HpmE6
	 oCeXXK7nz81PE3lbP/S6RwTIiuixc9GvzxLEIl4w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391148AbfIERjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 13:39:32 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58364 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391131AbfIERj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 13:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=AP3QXYgc2oODBwjsiyyDTEmHz/ojfNEQngmM1GZg4jc=; b=ZSyEwwWkzeYr
        ciXUA8MJrAoSIFRCwbqGVE9a/25h+JPRZPLQ+ADVW9nMktvi70e2pFva1ZWtmK+aXjOrstXWTAICc
        n3r/D9FuOGayRr9FafsbqFzw1g1EqHgMcBuvONYDzUxd5jZIm+n4uKI1plXOpYQFoI0pAzZtmgOnE
        6KAMQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i5vie-0005Ge-5O; Thu, 05 Sep 2019 17:38:52 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 3861B2742D07; Thu,  5 Sep 2019 18:38:51 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        daniel.baluta@nxp.com, festevam@gmail.com,
        Hulk Robot <hulkci@huawei.com>, kernel@pengutronix.de,
        lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com, s.hauer@pengutronix.de,
        shawnguo@kernel.org, tiwai@suse.com, yuehaibing@huawei.com
Subject: Applied "ASoC: SOF: imx8: Fix COMPILE_TEST error" to the asoc tree
In-Reply-To: <20190905064400.24800-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190905173851.3861B2742D07@ypsilon.sirena.org.uk>
Date:   Thu,  5 Sep 2019 18:38:51 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: SOF: imx8: Fix COMPILE_TEST error

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

From f4df4e4042b045c6ddbaff878a17ae169fe68ba6 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 5 Sep 2019 14:44:00 +0800
Subject: [PATCH] ASoC: SOF: imx8: Fix COMPILE_TEST error

When do compile test, if SND_SOC_SOF_OF is not set, we get:

sound/soc/sof/imx/imx8.o: In function `imx8_dsp_handle_request':
imx8.c:(.text+0xb0): undefined reference to `snd_sof_ipc_msgs_rx'
sound/soc/sof/imx/imx8.o: In function `imx8_ipc_msg_data':
imx8.c:(.text+0xf4): undefined reference to `sof_mailbox_read'
sound/soc/sof/imx/imx8.o: In function `imx8_dsp_handle_reply':
imx8.c:(.text+0x160): undefined reference to `sof_mailbox_read'

Make SND_SOC_SOF_IMX_TOPLEVEL always depends on SND_SOC_SOF_OF

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 202acc565a1f ("ASoC: SOF: imx: Add i.MX8 HW support")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20190905064400.24800-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/imx/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/imx/Kconfig b/sound/soc/sof/imx/Kconfig
index fd73d8402dbf..5acae75f5750 100644
--- a/sound/soc/sof/imx/Kconfig
+++ b/sound/soc/sof/imx/Kconfig
@@ -2,7 +2,8 @@
 
 config SND_SOC_SOF_IMX_TOPLEVEL
 	bool "SOF support for NXP i.MX audio DSPs"
-	depends on ARM64 && SND_SOC_SOF_OF || COMPILE_TEST
+	depends on ARM64|| COMPILE_TEST
+	depends on SND_SOC_SOF_OF
 	help
           This adds support for Sound Open Firmware for NXP i.MX platforms.
           Say Y if you have such a device.
-- 
2.20.1


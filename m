Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231FDC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB60B218EA
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563798144;
	bh=rRSx73gx6prR9zEFuJQnMRVZDMUIx1uzB5Ds1S0T+10=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=fIsgUtsLSEv9xjZGRYH9fkv+bKicOL3xtfBMlmyeJa5TGSdiOmJhG25+YR0thF9w0
	 w0ymWLp39Fo3ak8wCgmEL5iClydZOL4FAGTUQknuyujtjgBfxdPfCR+2HmPzsyNWeI
	 NbfLk7B2HsUozZeYy10GhTShfu2GnAwepbubOOt8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730290AbfGVMWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 08:22:22 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58606 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbfGVMWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 08:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=pxUJWhZ25yHUxPiSqRCgCdedu7AEcSBCRQ4DgPSgERA=; b=u9+rSVMBKZ1Y
        WaHP3zX4NIjP2JLNV2DivzNdfj8VmA2zcF181yPOgEYdW6mwBtnlkmf07ReTSbX9od0rV+q76P0wO
        UNYxxVOhSI2i3yaonUd4gVptifywcotkqyRadsCxouLYh+/SLmFxQXVFMMU25eQVk+lwZKO4qbXex
        d9v4A=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hpXKS-0007cy-S9; Mon, 22 Jul 2019 12:22:08 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 1E4492742B67; Mon, 22 Jul 2019 13:22:08 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     alsa-devel@alsa-project.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Gen Zhang <blackgod016574@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Takashi Iwai <tiwai@suse.com>, Vinod Koul <vkoul@kernel.org>
Subject: Applied "sound: soc: codecs: wcd9335: add irqflag IRQF_ONESHOT flag" to the asoc tree
In-Reply-To: <20190710021627.GA13396@hari-Inspiron-1545>
X-Patchwork-Hint: ignore
Message-Id: <20190722122208.1E4492742B67@ypsilon.sirena.org.uk>
Date:   Mon, 22 Jul 2019 13:22:08 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   sound: soc: codecs: wcd9335: add irqflag IRQF_ONESHOT flag

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

From 866e55ac49a8be478d89f23c941155721187be9a Mon Sep 17 00:00:00 2001
From: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Date: Wed, 10 Jul 2019 07:46:27 +0530
Subject: [PATCH] sound: soc: codecs: wcd9335: add irqflag IRQF_ONESHOT flag

Add IRQF_ONESHOT to ensure "Interrupt is not reenabled after the hardirq
handler finished".

fixes below issue reported by coccicheck

sound/soc/codecs/wcd9335.c:4068:8-33: ERROR: Threaded IRQ with no
primary handler requested without IRQF_ONESHOT

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Link: https://lore.kernel.org/r/20190710021627.GA13396@hari-Inspiron-1545
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wcd9335.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 1bbbe421b999..956602788d0e 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -4062,7 +4062,8 @@ static int wcd9335_setup_irqs(struct wcd9335_codec *wcd)
 
 		ret = devm_request_threaded_irq(wcd->dev, irq, NULL,
 						wcd9335_irqs[i].handler,
-						IRQF_TRIGGER_RISING,
+						IRQF_TRIGGER_RISING |
+						IRQF_ONESHOT,
 						wcd9335_irqs[i].name, wcd);
 		if (ret) {
 			dev_err(wcd->dev, "Failed to request %s\n",
-- 
2.20.1


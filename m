Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D43C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E5E23BB7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559144736;
	bh=r1khDvJXXHYH56OBNs3NXuRdIi29217+tEOioMVOG/w=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=QOvLlr0lGuBbR5FwZFKLamHdnjg1vtEzHvIWsXPwNPpuxqvpPCqnsr/zS770XKfR/
	 S6FiCmISOQfl998N7NxIPCzSCWoQIS1PVSeIj6pkKW2MbV2nZUJKnlx5OupcBTrPzQ
	 rL7LgssK8fwT2TEBiRlItPAkD5vpLQ6Hd5QOFtzE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfE2Ppg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 11:45:36 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41484 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfE2Ppf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 11:45:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=rp4ARE/txgmWIiLjaBU33yEAvu9H/UEQOwbwY0L4/HM=; b=DA+VfPAveRlI
        LGNKsUTSfU0iEQPQwALmuW0UMk0LivRlRyVDSgAJWXld4aapIZ+d/1NOLmI1/Nf0+/+YHu5EtLDea
        D5XgzHzWShmh3QoaJicT98+He73Loh9yHwefAy3IjNck/8SPq6SAhjmCaEwpymDkYD5+PIJnxtj7A
        4F5PM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hW0ld-00051n-Oa; Wed, 29 May 2019 15:45:29 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 3178944004A; Wed, 29 May 2019 16:45:29 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, perex@perex.cz,
        wen.yang99@zte.com.cn
Subject: Applied "wcd9335: fix a incorrect use of kstrndup()" to the asoc tree
In-Reply-To: <20190529015305.GA4700@zhanggen-UX430UQ>
X-Patchwork-Hint: ignore
Message-Id: <20190529154529.3178944004A@finisterre.sirena.org.uk>
Date:   Wed, 29 May 2019 16:45:29 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   wcd9335: fix a incorrect use of kstrndup()

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

From a54988113985ca22e414e132054f234fc8a92604 Mon Sep 17 00:00:00 2001
From: Gen Zhang <blackgod016574@gmail.com>
Date: Wed, 29 May 2019 09:53:05 +0800
Subject: [PATCH] wcd9335: fix a incorrect use of kstrndup()

In wcd9335_codec_enable_dec(), 'widget_name' is allocated by kstrndup().
However, according to doc: "Note: Use kmemdup_nul() instead if the size
is known exactly." So we should use kmemdup_nul() here instead of
kstrndup().

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wcd9335.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index a04a7cedd99d..85737fe54474 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -2734,7 +2734,7 @@ static int wcd9335_codec_enable_dec(struct snd_soc_dapm_widget *w,
 	char *dec;
 	u8 hpf_coff_freq;
 
-	widget_name = kstrndup(w->name, 15, GFP_KERNEL);
+	widget_name = kmemdup_nul(w->name, 15, GFP_KERNEL);
 	if (!widget_name)
 		return -ENOMEM;
 
-- 
2.20.1


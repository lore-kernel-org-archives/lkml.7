Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFFDC5B579
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147EA208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561741001;
	bh=QkBNEdmX/H3/l1teEu0uZoDZD8t9RC3V6jjGJ09soY4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=UHC8LO5hN2UoPLrcI+Tc/7hjtR1r6KjFFZyDQmhoppQ2I9b8s1XAQAwPeZISOrnTf
	 h4sVvhKHyv8JTNwxHpeAizE+7IwAbtaG53RizI+dUOQMr2YF9Zk93Q8y9rkhOxwGSR
	 OdqHiiCixn9ZPo7DKDXUJC9N+CIxvy4Dm6RI7lcc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfF1Q4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 12:56:39 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42514 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbfF1Q4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 12:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=GjcHksA4qGiaUnr9QTbALLeGH/gj9DkhMrZ1SbHiikw=; b=oCkunyEKReYW
        4gnQc44v2vTEo2iacdCajWGkArNGwSog1x2I5M2pXvT5EYfFVoX1gmqFPsw+NauMsl67SlUgOtHWB
        vp/U+MmYkgpuTKiFFwqORf8UsFlaW0iOuc2aszy1orc/dpEUqAiAPBzEKXhapa4kLhEb4R33z7xA4
        lJZvw=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hguAm-0007BF-D7; Fri, 28 Jun 2019 16:56:28 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id CAB93440049; Fri, 28 Jun 2019 17:56:27 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        kernel-janitors@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Subject: Applied "ASoC: topology: fix memory leaks on sm, se and sbe" to the asoc tree
In-Reply-To: <20190627133208.9550-1-colin.king@canonical.com>
X-Patchwork-Hint: ignore
Message-Id: <20190628165627.CAB93440049@finisterre.sirena.org.uk>
Date:   Fri, 28 Jun 2019 17:56:27 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: topology: fix memory leaks on sm, se and sbe

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

From 1ad741d0e8e8ecccc16aa9ccb8362575197d91bf Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Thu, 27 Jun 2019 14:32:08 +0100
Subject: [PATCH] ASoC: topology: fix memory leaks on sm, se and sbe

Currently when a kstrdup fails the error exit paths don't free
the allocations for sm, se and sbe.  This can be fixed by assigning
kc[i].private_value to these before doing the ksrtdup so that the error
exit path will be able to free these objects.

Addresses-Coverity: ("Resource leak")
Fixes: 9f90af3a9952 ("ASoC: topology: Consolidate and fix asoc_tplg_dapm_widget_*_create flow")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index fc1f1d6f9e92..dc463f1a9e24 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1326,10 +1326,10 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_dmixer_create(
 		dev_dbg(tplg->dev, " adding DAPM widget mixer control %s at %d\n",
 			mc->hdr.name, i);
 
+		kc[i].private_value = (long)sm;
 		kc[i].name = kstrdup(mc->hdr.name, GFP_KERNEL);
 		if (kc[i].name == NULL)
 			goto err_sm;
-		kc[i].private_value = (long)sm;
 		kc[i].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 		kc[i].access = mc->hdr.access;
 
@@ -1412,10 +1412,10 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_denum_create(
 		dev_dbg(tplg->dev, " adding DAPM widget enum control %s\n",
 			ec->hdr.name);
 
+		kc[i].private_value = (long)se;
 		kc[i].name = kstrdup(ec->hdr.name, GFP_KERNEL);
 		if (kc[i].name == NULL)
 			goto err_se;
-		kc[i].private_value = (long)se;
 		kc[i].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 		kc[i].access = ec->hdr.access;
 
@@ -1524,10 +1524,10 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_dbytes_create(
 			"ASoC: adding bytes kcontrol %s with access 0x%x\n",
 			be->hdr.name, be->hdr.access);
 
+		kc[i].private_value = (long)sbe;
 		kc[i].name = kstrdup(be->hdr.name, GFP_KERNEL);
 		if (kc[i].name == NULL)
 			goto err_sbe;
-		kc[i].private_value = (long)sbe;
 		kc[i].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 		kc[i].access = be->hdr.access;
 
-- 
2.20.1


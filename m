Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EAAC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 13:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0942C206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 13:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564665073;
	bh=Pjfp5/FPJktZUmBdEwkYtGdpQNdHhkrH5WVL39P6TSo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=yVhgG6QFKuDqo8IEn2pPMPSm3UDWQT1AoXx3oiKwWqhbFVrHP8+MBxKs1SYjQgiDX
	 R4ej4eK52pZ8amorOUHItpph0aKR5V/x2S9O6aDgvWup8RBC98fztFEoVZapxS2MEG
	 TY0mtLUS6r120F4VjCABnWtmKAq6AyzzweE/ECmM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731691AbfHANLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 09:11:00 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54710 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731644AbfHANKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 09:10:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=SIcw7oNKmi9/Oc/uKvmWuwiOyL3ZlEHWKaiCWsI5Vic=; b=CsMVNHLewrYU
        GoAXdPWw6hVq4eBBZUcEtyfKsToI+qs6d2uDxXfgqtlMqtm5WaAjWpexFKyqaufpkPXFc2OaZfC+B
        /krFVFC8QGkG2kvt8KB/Vhde1PD3h7Vc1OIDYu9Yf3hW2fmZC86Beupb1xQpFkX8OAC4uUv+j/KKv
        jhqO8=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1htAqu-0004ip-Jr; Thu, 01 Aug 2019 13:10:40 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id EAD042742D2C; Thu,  1 Aug 2019 14:10:39 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: Intel: SoC: skylake: no need to check return value of debugfs_create functions" to the asoc tree
In-Reply-To: <20190731131716.9764-1-gregkh@linuxfoundation.org>
X-Patchwork-Hint: ignore
Message-Id: <20190801131039.EAD042742D2C@ypsilon.sirena.org.uk>
Date:   Thu,  1 Aug 2019 14:10:39 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: Intel: SoC: skylake: no need to check return value of debugfs_create functions

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

From d8701fae95c0e6cb587b293cb8e01acc96dd1095 Mon Sep 17 00:00:00 2001
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed, 31 Jul 2019 15:17:14 +0200
Subject: [PATCH] ASoC: Intel: SoC: skylake: no need to check return value of
 debugfs_create functions

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Also, if a debugfs call fails, userspace is notified with an error in
the log, so no need to log the error again.

Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Jie Yang <yang.jie@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/r/20190731131716.9764-1-gregkh@linuxfoundation.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-debug.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-debug.c b/sound/soc/intel/skylake/skl-debug.c
index fb232428109f..212370bf704c 100644
--- a/sound/soc/intel/skylake/skl-debug.c
+++ b/sound/soc/intel/skylake/skl-debug.c
@@ -164,10 +164,8 @@ void skl_debug_init_module(struct skl_debug *d,
 			struct snd_soc_dapm_widget *w,
 			struct skl_module_cfg *mconfig)
 {
-	if (!debugfs_create_file(w->name, 0444,
-				d->modules, mconfig,
-				&mcfg_fops))
-		dev_err(d->dev, "%s: module debugfs init failed\n", w->name);
+	debugfs_create_file(w->name, 0444, d->modules, mconfig,
+			    &mcfg_fops);
 }
 
 static ssize_t fw_softreg_read(struct file *file, char __user *user_buf,
@@ -224,34 +222,18 @@ struct skl_debug *skl_debugfs_init(struct skl_dev *skl)
 		return NULL;
 
 	/* create the debugfs dir with platform component's debugfs as parent */
-	d->fs = debugfs_create_dir("dsp",
-				   skl->component->debugfs_root);
-	if (IS_ERR(d->fs) || !d->fs) {
-		dev_err(&skl->pci->dev, "debugfs root creation failed\n");
-		return NULL;
-	}
+	d->fs = debugfs_create_dir("dsp", skl->component->debugfs_root);
 
 	d->skl = skl;
 	d->dev = &skl->pci->dev;
 
 	/* now create the module dir */
 	d->modules = debugfs_create_dir("modules", d->fs);
-	if (IS_ERR(d->modules) || !d->modules) {
-		dev_err(&skl->pci->dev, "modules debugfs create failed\n");
-		goto err;
-	}
 
-	if (!debugfs_create_file("fw_soft_regs_rd", 0444, d->fs, d,
-				 &soft_regs_ctrl_fops)) {
-		dev_err(d->dev, "fw soft regs control debugfs init failed\n");
-		goto err;
-	}
+	debugfs_create_file("fw_soft_regs_rd", 0444, d->fs, d,
+			    &soft_regs_ctrl_fops);
 
 	return d;
-
-err:
-	debugfs_remove_recursive(d->fs);
-	return NULL;
 }
 
 void skl_debugfs_exit(struct skl_dev *skl)
-- 
2.20.1


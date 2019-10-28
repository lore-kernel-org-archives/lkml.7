Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D26CA9EC1
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 14:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33405208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 14:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572274613;
	bh=IhxCXzDYni/8yl//7apJB4pRA0tjr/HghX/4URUHPAA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=fNe0be/KQr5tFIy29dbDehqzovc8xC2CE4z9UlY0Ga2ws4wdRaxI0TXBcpc8xw0rN
	 fJmk+EOOZgarvbCi2xd/+fGHWNEmcbGQlfH/gdmZhGG8Fs7AYRKgOrEX4SIN9+A9Ls
	 53nchvQ4fsa7l8AAk4kfnuH0KMSeLwE1Z9ergltg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390459AbfJ1O4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 10:56:52 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39886 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390428AbfJ1O4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 10:56:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=tN8epsZEkS31NtdlX45cDOmGF5PCzR59bS9MnzLxSmg=; b=BlTZDNucaG1B
        kxm0DU1bGKzsOQw96Q+YQqdQrdJSBmRSPt3YiBXWZYnVqeOZwTh5ybIKq65Ybktnp1pZSbLBHnPeb
        YFvUMyj0QqiJJI+DP8LQsNT1jquBZ4kK3//kxlYFxXMe3j5ACViX2bRNToEsbRiDliprT/JOrLKaA
        VsgpA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iP6Rj-0008Rp-Hj; Mon, 28 Oct 2019 14:56:39 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 3045F27414F2; Mon, 28 Oct 2019 14:56:38 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     alsa-devel@alsa-project.org, "Cc:"@sirena.co.uk,
        "Cc:"@sirena.co.uk, emamd001@umn.edu,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>, kjlu@umn.edu,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Pan Xiuli <xiuli.pan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Slawomir Blauciak <slawomir.blauciak@linux.intel.com>,
        smccaman@umn.edu, Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: SOF: ipc: Fix memory leak in sof_set_get_large_ctrl_data" to the asoc tree
In-Reply-To: <20191027215330.12729-1-navid.emamdoost@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20191028145638.3045F27414F2@ypsilon.sirena.org.uk>
Date:   Mon, 28 Oct 2019 14:56:38 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: SOF: ipc: Fix memory leak in sof_set_get_large_ctrl_data

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

From 45c1380358b12bf2d1db20a5874e9544f56b34ab Mon Sep 17 00:00:00 2001
From: Navid Emamdoost <navid.emamdoost@gmail.com>
Date: Sun, 27 Oct 2019 16:53:24 -0500
Subject: [PATCH] ASoC: SOF: ipc: Fix memory leak in
 sof_set_get_large_ctrl_data

In the implementation of sof_set_get_large_ctrl_data() there is a memory
leak in case an error. Release partdata if sof_get_ctrl_copy_params()
fails.

Fixes: 54d198d5019d ("ASoC: SOF: Propagate sof_get_ctrl_copy_params() error properly")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Link: https://lore.kernel.org/r/20191027215330.12729-1-navid.emamdoost@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/ipc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/ipc.c b/sound/soc/sof/ipc.c
index b2f359d2f7e5..086eeeab8679 100644
--- a/sound/soc/sof/ipc.c
+++ b/sound/soc/sof/ipc.c
@@ -572,8 +572,10 @@ static int sof_set_get_large_ctrl_data(struct snd_sof_dev *sdev,
 	else
 		err = sof_get_ctrl_copy_params(cdata->type, partdata, cdata,
 					       sparams);
-	if (err < 0)
+	if (err < 0) {
+		kfree(partdata);
 		return err;
+	}
 
 	msg_bytes = sparams->msg_bytes;
 	pl_size = sparams->pl_size;
-- 
2.20.1


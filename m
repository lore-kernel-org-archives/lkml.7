Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC754C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 09:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C0F2168B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 09:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561456468;
	bh=wcgMvcVDpuK5jcwPvIR2jhhTHxNps0emCnUkCQ8yiV8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=x3kmTZ8GS2ucY8R4EFhwfJ8B+U8jlxk+QjecK4joKVMcRL2VElfP6VgoQNSlT+OHG
	 xqYZ3u3sl2urbKZrOjQ0PwogCeHpIsz2REIAJTJ7kJ2+JVKJHH3x4YLgupH/IPpJIe
	 dMhSjHtCcKL203TDwV8b7yGZq11EWpi4+60otQ2M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731782AbfFYJy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 05:54:27 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37858 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbfFYJy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 05:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=g8e7LN5W+icCyPVPUZHVbZsiHWowuU5Bzf2USy1hwRc=; b=J52ajW99TBzE
        dwXWMvIbw43krhBM2dpHWopP5KozXZUn96zPLHOvDcYumdIUZRvJoWr1L8ragsCp+m1GTq9GYmAFz
        7HK6gedmdfH98/N4iFgxyx+oATXvyuzegF1uu4AFzsKtcpFaALgxY1j0rDQi2N4g+Y2qeJuKhl7A2
        gFnI0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hfi9E-0004mN-Th; Tue, 25 Jun 2019 09:53:57 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 33351440055; Mon, 24 Jun 2019 17:32:14 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        kernel-janitors@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Zhu Yingjiang <yingjiang.zhu@linux.intel.com>
Subject: Applied "ASoC: SOF: Intel: hda: remove duplicated include from hda.c" to the asoc tree
In-Reply-To: <20190620145709.122498-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190624163214.33351440055@finisterre.sirena.org.uk>
Date:   Mon, 24 Jun 2019 17:32:14 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: SOF: Intel: hda: remove duplicated include from hda.c

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

From a2438253ba73ae51d9521c90ad8d3989bcdda74e Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 20 Jun 2019 14:57:09 +0000
Subject: [PATCH] ASoC: SOF: Intel: hda: remove duplicated include from hda.c

Remove duplicated include.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/intel/hda.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 8754dfe75000..136f98bf5d7e 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -19,7 +19,6 @@
 #include <sound/hda_register.h>
 
 #include <linux/module.h>
-#include <sound/hdaudio_ext.h>
 #include <sound/sof.h>
 #include <sound/sof/xtensa.h>
 #include "../ops.h"
-- 
2.20.1


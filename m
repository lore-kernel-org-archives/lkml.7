Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F65AC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F32020673
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570531991;
	bh=3KNWvdTJxLRG8wrfAZLCmIUFtbUSGxWGbISeTogTaf8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=M8AowWh4C7BA9CbdpEWjLno30IIPQp6kuYSJmN3InLNDCzWb0c+r8p82HVYqzKOeu
	 iK8kc0E1PodHGa2BwtveO0jh6pFb/BtE5x8kn8XS5EoJ5+omtkA39tftucSq8+Eu9B
	 iJBuASNwwxeNVhadHAiB+82LjEWc5AHQM1lSW7Ag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730605AbfJHKxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 06:53:10 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47772 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730218AbfJHKw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 06:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=H7lh+AWXkJkKYtvaH82vN4KeDEGiFTNPJ+CxtZRgMF0=; b=LK5kW98pBTIc
        mCO1prLLF9UIoBr81ENVMaf6R85emPL1suoNSQsSrg5DVfmwxILI6QeWFyD3JelFJsSVy2eStKARc
        ZXVYfWnR0ps8lUDwu9LJOc9+GlKqIG7N2ddkZWkve6HFP+SZYY/YN5bMnRq9AOAML5R7s0VckOMxd
        9vtrg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iHn6h-00083J-Eg; Tue, 08 Oct 2019 10:52:43 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id ED3C12742998; Tue,  8 Oct 2019 11:52:42 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        slawomir.blauciak@intel.com, srinivas.kandagatla@linaro.org,
        Takashi Iwai <tiwai@suse.com>, tiwai@suse.de, vkoul@kernel.org
Subject: Applied "ASoC: SOF: support alternate list of machines" to the asoc tree
In-Reply-To: <20190916214251.13130-3-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20191008105242.ED3C12742998@ypsilon.sirena.org.uk>
Date:   Tue,  8 Oct 2019 11:52:42 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: SOF: support alternate list of machines

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

From 1466327e8eb3e59ae8e65e5c728055102fe0a60e Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Mon, 16 Sep 2019 16:42:41 -0500
Subject: [PATCH] ASoC: SOF: support alternate list of machines

For cases where an interface can be pin-muxed, we need to assess at
probe time which configuration should be used. In cases such as
SoundWire, we need to maintain an alternate list of machines and walk
through them when the primary detection based on ACPI _HID fails.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20190916214251.13130-3-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/sof.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/sound/sof.h b/include/sound/sof.h
index 4640566b54fe..479101736ee0 100644
--- a/include/sound/sof.h
+++ b/include/sound/sof.h
@@ -61,6 +61,9 @@ struct sof_dev_desc {
 	/* list of machines using this configuration */
 	struct snd_soc_acpi_mach *machines;
 
+	/* alternate list of machines using this configuration */
+	struct snd_soc_acpi_mach *alt_machines;
+
 	/* Platform resource indexes in BAR / ACPI resources. */
 	/* Must set to -1 if not used - add new items to end */
 	int resindex_lpe_base;
-- 
2.20.1


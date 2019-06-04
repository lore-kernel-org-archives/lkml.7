Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593C1C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D9F724AB7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559660362;
	bh=lN+qBEnZ0s/tloxLdpm+NpwQ58sif7RQAdcaFE5YLpo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=dShti5L2Rj+X5ZHCv5CR7jm1FpIY26XZAfSTSASYwfag33t/af4xNlX9r1LVpjU6X
	 2MSJHFdUhZBBco+r3DhymNhee9LN9qFdQ3tjbqdr/fjvAMoPFe9kBsxiSMPGM/y4UO
	 mbhWE5QWeidSM8DejUji0xlGEnehztgHDezpLaTw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbfFDO7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 10:59:20 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48966 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727967AbfFDO7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 10:59:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=KJndiTBlNhoODFuKB7HEW0uTpDTeJGa/gjvrJqwZm40=; b=ashcMC599Hot
        FC9kiBFa0K0pnuu/h8v/cv2VNuqFJnrsgDpJvxi4hFDIA5R7wRNmjkBqE+d4GCRaLkP+vBaCzQ6Kz
        Lboi0QxeFj/+nExh+13db+yPkrxeJdJ8bcjP3rs7msVfHaJZ7FkG74r0v2/aNlqh5pvTwToUr/GIc
        pbpLU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hYAtv-0006EW-Lw; Tue, 04 Jun 2019 14:58:59 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 3CED2440046; Tue,  4 Jun 2019 15:58:59 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        Hulk Robot <hulkci@huawei.com>, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        perex@perex.cz, pierre-louis.bossart@linux.intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        tiwai@suse.com, yingjiang.zhu@linux.intel.com
Subject: Applied "ASoC: SOF: Intel: hda: Fix COMPILE_TEST build error" to the asoc tree
In-Reply-To: <20190531142526.12712-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190604145859.3CED2440046@finisterre.sirena.org.uk>
Date:   Tue,  4 Jun 2019 15:58:59 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: SOF: Intel: hda: Fix COMPILE_TEST build error

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

From ad169f9f0dbb531cd68db921b351ccafcf684ae4 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Fri, 31 May 2019 22:25:26 +0800
Subject: [PATCH] ASoC: SOF: Intel: hda: Fix COMPILE_TEST build error

while building without PCI:

sound/soc/sof/intel/hda.o: In function `hda_dsp_probe':
hda.c:(.text+0x79c): undefined reference to `pci_ioremap_bar'
hda.c:(.text+0x79c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `pci_ioremap_bar'
hda.c:(.text+0x7c4): undefined reference to `pci_ioremap_bar'
hda.c:(.text+0x7c4): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `pci_ioremap_bar'

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: e13ef82a9ab8 ("ASoC: SOF: add COMPILE_TEST for PCI options")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/intel/hda.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 8f5c68861bbc..9e2e0f21524e 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -227,7 +227,9 @@ static int hda_init(struct snd_sof_dev *sdev)
 
 	/* initialise hdac bus */
 	bus->addr = pci_resource_start(pci, 0);
+#if IS_ENABLED(CONFIG_PCI)
 	bus->remap_addr = pci_ioremap_bar(pci, 0);
+#endif
 	if (!bus->remap_addr) {
 		dev_err(bus->dev, "error: ioremap error\n");
 		return -ENXIO;
@@ -454,7 +456,9 @@ int hda_dsp_probe(struct snd_sof_dev *sdev)
 		goto hdac_bus_unmap;
 
 	/* DSP base */
+#if IS_ENABLED(CONFIG_PCI)
 	sdev->bar[HDA_DSP_BAR] = pci_ioremap_bar(pci, HDA_DSP_BAR);
+#endif
 	if (!sdev->bar[HDA_DSP_BAR]) {
 		dev_err(sdev->dev, "error: ioremap error\n");
 		ret = -ENXIO;
-- 
2.20.1


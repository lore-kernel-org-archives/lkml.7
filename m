Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99303C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F96D217D7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570531980;
	bh=cPN/oXb+tsdCCMcT4KIVmdquVqDq6EQzyoe8tU87rwQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=y3aWcc0YuyZu04oci5TnSMBFbTN62PUKrmX802aoj0aK3cPJa6QhSzYHs9OVxNlyC
	 hENAjAH9wGKFEWA+TpVHNSSHWFvSXL0OcHWhD8s7LMusCYsWyqWW9LsEofR7ESdcKV
	 D9NHU8zhC2Q2FCgRlC4AaNSO8DZYQytae/ssaKyo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730565AbfJHKw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 06:52:59 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47770 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730532AbfJHKw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 06:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=aQWLP7shEvQVOd1gmFs3OAaCkBEiFu5+HvYLjGdA7Dk=; b=WCX/oiMR4Mbj
        tvcNM4c/J9yqw9Jn+IPYQWMqehcP85a3NKx/c9dFH7tDbyCmIjxEEt5Bsw95UcHjGsecKDbzw3D/S
        ootrCS1jkO8NhvHfAMMvjtSzIK02fkVhtgx0p8vyLLxWNGA3KQ/5veNFZMs81/IlHPP79Dkiedf5b
        mzs80=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iHn6h-00083K-OZ; Tue, 08 Oct 2019 10:52:43 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 3A5CA274299B; Tue,  8 Oct 2019 11:52:43 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        slawomir.blauciak@intel.com, srinivas.kandagatla@linaro.org,
        Takashi Iwai <tiwai@suse.com>, tiwai@suse.de, vkoul@kernel.org
Subject: Applied "ASoC: soc-acpi: add link_mask field" to the asoc tree
In-Reply-To: <20190916214251.13130-2-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20191008105243.3A5CA274299B@ypsilon.sirena.org.uk>
Date:   Tue,  8 Oct 2019 11:52:43 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: soc-acpi: add link_mask field

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

From af78cec45f2d01be9d14c177e403c8021ebfd40e Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Mon, 16 Sep 2019 16:42:40 -0500
Subject: [PATCH] ASoC: soc-acpi: add link_mask field

When interfaces can be pin-muxed, static information from ACPI might
not be enough. Add information on which links needs to be enabled by
hardware/firmware for a specific machine driver to be selected.

When walking through the list of possible machines, links will be
checked, which implies that configurations where multiple links are
required need to be checked first.

Additional criteria will be needed later, such as which SoundWire
Slave devices are actually enabled, but for now this helps detect
between basic configurations.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20190916214251.13130-2-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-acpi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/sound/soc-acpi.h b/include/sound/soc-acpi.h
index 35b38e41e5b2..c0fb71c7b3ad 100644
--- a/include/sound/soc-acpi.h
+++ b/include/sound/soc-acpi.h
@@ -75,6 +75,7 @@ struct snd_soc_acpi_mach_params {
  * all firmware/topology related fields.
  *
  * @id: ACPI ID (usually the codec's) used to find a matching machine driver.
+ * @link_mask: describes required board layout, e.g. for SoundWire.
  * @drv_name: machine driver name
  * @fw_filename: firmware file name. Used when SOF is not enabled.
  * @board: board name
@@ -90,6 +91,7 @@ struct snd_soc_acpi_mach_params {
 /* Descriptor for SST ASoC machine driver */
 struct snd_soc_acpi_mach {
 	const u8 id[ACPI_ID_LEN];
+	const u32 link_mask;
 	const char *drv_name;
 	const char *fw_filename;
 	const char *board;
-- 
2.20.1


Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6382C04A6B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 02:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93A0206BF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 02:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557196158;
	bh=zJPWwJMvATfR83H/bjPYsuPUuEhmn7i8rK5/BFXuX/Q=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=JsKV+fIgrdSHOPmUUSJsby8wVgkOUQLyRu0hQHOqHHQHEs4JpiHc3F/ZNc3WIrukX
	 iCEAuMt2TspWDB37K0biqXyGmkiaUsFjngXkeafC36q1Jh9baTw0pSyKVWAqX6oYtT
	 E+x1epPWhk6v6kUEKyWl2B9JY0BwooYymXd9Vsa0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfEGC3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 22:29:17 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46662 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfEGC3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 22:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=eFy0U8s/yw48UFL0gk7vE97JZ4glVfukIkTzC7rlsKo=; b=hkL9gH6C+4M7
        YV5wkZZw318IHWXS16qCfNWU2hdf92mk8N08ALaNYA+jrkuopLX52awoAlNRyOdG/SGpj2MnqQ/1G
        12eaJNqkPzuNCjfpmMseq0WHjqsRjlchL+S0pMBkecRnzkOPxon/alcnYXzvI/m/bR2nHlwkDbCqd
        OsWWA=;
Received: from kd111239185057.au-net.ne.jp ([111.239.185.57] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hNpqp-0003RG-ME; Tue, 07 May 2019 02:29:04 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id EFDB8440034; Tue,  7 May 2019 03:28:52 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        moderated for non-subscribers <alsa-devel@alsa-project.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Applied "ASoC: sound/soc/sof/: fix kconfig dependency warning" to the asoc tree
In-Reply-To: <418abbd5-f01c-19ef-c9f2-7de5662f10a2@infradead.org>
X-Patchwork-Hint: ignore
Message-Id: <20190507022852.EFDB8440034@finisterre.sirena.org.uk>
Date:   Tue,  7 May 2019 03:28:52 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: sound/soc/sof/: fix kconfig dependency warning

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

From 4c88519133bdd802fb0df4707b5a8c066af7154d Mon Sep 17 00:00:00 2001
From: Randy Dunlap <rdunlap@infradead.org>
Date: Mon, 6 May 2019 12:01:40 -0700
Subject: [PATCH] ASoC: sound/soc/sof/: fix kconfig dependency warning

Fix kconfig warning for unmet dependency for IOSF_MBI when
PCI is not set/enabled.  Fixes this warning:

WARNING: unmet direct dependencies detected for IOSF_MBI
  Depends on [n]: PCI [=n]
  Selected by [y]:
  - SND_SOC_SOF_ACPI [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_SOF_TOPLEVEL [=y] && (ACPI [=y] || COMPILE_TEST [=n]) && X86 [=y]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/Kconfig b/sound/soc/sof/Kconfig
index a1a9ffe605dc..b204c65698f9 100644
--- a/sound/soc/sof/Kconfig
+++ b/sound/soc/sof/Kconfig
@@ -28,7 +28,7 @@ config SND_SOC_SOF_ACPI
 	select SND_SOC_ACPI if ACPI
 	select SND_SOC_SOF_OPTIONS
 	select SND_SOC_SOF_INTEL_ACPI if SND_SOC_SOF_INTEL_TOPLEVEL
-	select IOSF_MBI if X86
+	select IOSF_MBI if X86 && PCI
 	help
 	  This adds support for ACPI enumeration. This option is required
 	  to enable Intel Haswell/Broadwell/Baytrail/Cherrytrail devices
-- 
2.20.1


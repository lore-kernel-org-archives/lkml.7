Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2238DC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC6A420854
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571069558;
	bh=6fgBtO62mZBLTVpjQ/XdUcdPxurG/FPvcAMlM0ciDns=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=yCUrWCZ49S69VJq7e4Va4oUCWSf/4edv7ALVohErqM0UygYMVB7xe+g0yoM2fO4ph
	 zgcZMPnRHTs3cXZGC2RnsESrniMGqL5PKxAzvlX7NKDNVg4CGUknecrSnSOQrPwMA/
	 UhmHzwDq6KFSG+vlRT2tsHuPvujQyUbKlxtAE9V0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387971AbfJNQMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 12:12:37 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54810 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732195AbfJNQMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 12:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=2lucGtC5FgFnkQOwXgFW6LIHJ1tEIf7HqGz9IDto4us=; b=J7Fsb/Eu9Ao9
        +0W6VbhNrfvcxYfqsERKsz/ohtt6gTdLZtA32MltYmlne6Yq3Psc/q+6XwhEPuEqkqIvaHqmfn6N8
        vQO++KVVYsGl+FD1odllUQ/GS8rcvv0VOdz+BNQu6XcaLP7DucU+Il2V/lLqXs/MaTUsP8/x46zT6
        skR3E=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iK2xK-0007yg-HJ; Mon, 14 Oct 2019 16:12:22 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id E13102741EF2; Mon, 14 Oct 2019 17:12:21 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        Hulk Robot <hulkci@huawei.com>, jaska.uimonen@linux.intel.com,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        tiwai@suse.com, yang.jie@linux.intel.com, yuehaibing@huawei.com,
        yung-chuan.liao@linux.intel.com
Subject: Applied "ASoC: SOF: Fix randbuild error" to the asoc tree
In-Reply-To:  <20191014091308.23688-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20191014161221.E13102741EF2@ypsilon.sirena.org.uk>
Date:   Mon, 14 Oct 2019 17:12:21 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: SOF: Fix randbuild error

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

From 9899a7a869935c4c93247b290ac7a70e0deab202 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Mon, 14 Oct 2019 17:13:08 +0800
Subject: [PATCH] ASoC: SOF: Fix randbuild error

When LEDS_TRIGGER_AUDIO is m and SND_SOC_SOF is y,

sound/soc/sof/control.o: In function `snd_sof_switch_put':
control.c:(.text+0x587): undefined reference to `ledtrig_audio_set'
control.c:(.text+0x593): undefined reference to `ledtrig_audio_set'

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 5d43001ae436 ("ASoC: SOF: acpi led support for switch controls")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20191014091308.23688-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/control.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/sof/control.c b/sound/soc/sof/control.c
index 41551e8f6ac3..2c4abd406c4f 100644
--- a/sound/soc/sof/control.c
+++ b/sound/soc/sof/control.c
@@ -36,10 +36,12 @@ static void update_mute_led(struct snd_sof_control *scontrol,
 
 	scontrol->led_ctl.led_value = temp;
 
+#if IS_REACHABLE(CONFIG_LEDS_TRIGGER_AUDIO)
 	if (!scontrol->led_ctl.direction)
 		ledtrig_audio_set(LED_AUDIO_MUTE, temp ? LED_OFF : LED_ON);
 	else
 		ledtrig_audio_set(LED_AUDIO_MICMUTE, temp ? LED_OFF : LED_ON);
+#endif
 }
 
 static inline u32 mixer_to_ipc(unsigned int value, u32 *volume_map, int size)
-- 
2.20.1


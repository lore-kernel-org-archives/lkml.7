Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE41C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12F22067C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556273004;
	bh=DG0loXfvj9yaq+mAx7xlD/0tgG4NXVG8lcHKfbdXLNw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=yeBYj/R+kF68o1S2T3UpZBnKmuYI0BD90r83y7Tw+aLFax2ZvPFphnGv9+F4RrQWO
	 K7w5uLEpghO28rv6o2gbTfFZ4jVEiA9KJNdAq+MlBhhNPzlgCKKREtq1BSdR89MTVJ
	 gy+QhWhuMlQQSbR1UB+5uo7f23FbIrvmqDErzlqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfDZKDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 06:03:22 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56388 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbfDZKDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 06:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=yn1VngQRjJiFNRmEx4lMx8PUCcq5l+a7FmYTSWE1Dso=; b=NJz7NIQZnj5S
        YL9ac3m6xaUCm/VQjQKOcqI8y55vtpcPoEguDraqeGvo5/OaSP9JdKi4+NlLMo4uxNU1u/7P+vNGB
        Zll92WdRG1F2xntLpEPVszZ0q6ipZctd8uBh6S0MoqqHiepyj/IhB1Uq39sBCOzwqCNwRUWiuSDCG
        6NjOw=;
Received: from [37.205.61.202] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJxhJ-0003kn-EC; Fri, 26 Apr 2019 10:03:13 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 44169441D3C; Fri, 26 Apr 2019 11:03:12 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     alsa-devel@alsa-project.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        od@zcrc.me
Subject: Applied "ASoC: simple-card-utils: add asoc_simple_parse_pin_switches()" to the asoc tree
In-Reply-To: <20190426022550.31359-1-paul@crapouillou.net>
X-Patchwork-Hint: ignore
Message-Id: <20190426100312.44169441D3C@finisterre.ee.mobilebroadband>
Date:   Fri, 26 Apr 2019 11:03:12 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: simple-card-utils: add asoc_simple_parse_pin_switches()

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

From 90194281ee8b01fc5a223a12ac90006ae98862c4 Mon Sep 17 00:00:00 2001
From: Paul Cercueil <paul@crapouillou.net>
Date: Fri, 26 Apr 2019 04:25:49 +0200
Subject: [PATCH] ASoC: simple-card-utils: add asoc_simple_parse_pin_switches()

This function is a helper that permits to create pin switch controls for
a list of widgets whose names are listed in the PREFIX "pin-switches"
devicetree property.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/simple_card_utils.h     |  2 +
 sound/soc/generic/simple-card-utils.c | 57 +++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index 67dc3ee6ed01..3429888347e7 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -133,6 +133,8 @@ int asoc_simple_parse_routing(struct snd_soc_card *card,
 				      char *prefix);
 int asoc_simple_parse_widgets(struct snd_soc_card *card,
 				      char *prefix);
+int asoc_simple_parse_pin_switches(struct snd_soc_card *card,
+				   char *prefix);
 
 int asoc_simple_init_jack(struct snd_soc_card *card,
 			       struct asoc_simple_jack *sjack,
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index db1458a19985..f4c6375d11c7 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -430,6 +430,63 @@ int asoc_simple_parse_widgets(struct snd_soc_card *card,
 }
 EXPORT_SYMBOL_GPL(asoc_simple_parse_widgets);
 
+int asoc_simple_parse_pin_switches(struct snd_soc_card *card,
+				   char *prefix)
+{
+	const unsigned int nb_controls_max = 16;
+	const char **strings, *control_name;
+	struct snd_kcontrol_new *controls;
+	struct device *dev = card->dev;
+	unsigned int i, nb_controls;
+	char prop[128];
+	int ret;
+
+	if (!prefix)
+		prefix = "";
+
+	snprintf(prop, sizeof(prop), "%s%s", prefix, "pin-switches");
+
+	if (!of_property_read_bool(dev->of_node, prop))
+		return 0;
+
+	strings = devm_kcalloc(dev, nb_controls_max,
+			       sizeof(*strings), GFP_KERNEL);
+	if (!strings)
+		return -ENOMEM;
+
+	ret = of_property_read_string_array(dev->of_node, prop,
+					    strings, nb_controls_max);
+	if (ret < 0)
+		return ret;
+
+	nb_controls = (unsigned int)ret;
+
+	controls = devm_kcalloc(dev, nb_controls,
+				sizeof(*controls), GFP_KERNEL);
+	if (!controls)
+		return -ENOMEM;
+
+	for (i = 0; i < nb_controls; i++) {
+		control_name = devm_kasprintf(dev, GFP_KERNEL,
+					      "%s Switch", strings[i]);
+		if (!control_name)
+			return -ENOMEM;
+
+		controls[i].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+		controls[i].name = control_name;
+		controls[i].info = snd_soc_dapm_info_pin_switch;
+		controls[i].get = snd_soc_dapm_get_pin_switch;
+		controls[i].put = snd_soc_dapm_put_pin_switch;
+		controls[i].private_value = (unsigned long)strings[i];
+	}
+
+	card->controls = controls;
+	card->num_controls = nb_controls;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(asoc_simple_parse_pin_switches);
+
 int asoc_simple_init_jack(struct snd_soc_card *card,
 			  struct asoc_simple_jack *sjack,
 			  int is_hp, char *prefix)
-- 
2.20.1


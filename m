Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D58C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17FEA20866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406625AbfFKRty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 13:49:54 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:36923 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405488AbfFKRtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 13:49:52 -0400
Received: from [167.98.27.226] (helo=ct-lt-1124.office.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1haktd-0001PN-DW; Tue, 11 Jun 2019 18:49:21 +0100
From:   Thomas Preston <thomas.preston@codethink.co.uk>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Kirill Marinushkin <kmarinushkin@birdec.tech>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        Annaliese McDermond <nh6z@nh6z.net>,
        Thomas Preston <thomas.preston@codethink.co.uk>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/4] ASoC: Codecs: Add TDA7802 codec
Date:   Tue, 11 Jun 2019 18:49:05 +0100
Message-Id: <20190611174909.12162-1-thomas.preston@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a driver for the ST TDA7802 amplifier.

Thanks,
Thomas

Cc: Patrick Glaser <pglaser@tesla.com>
Cc: Rob Duncan <rduncan@tesla.com>
Cc: Nate Case <ncase@tesla.com>

Thomas Preston (4):
  dt-bindings: ASoC: Add TDA7802 amplifier
  ASoC: Add codec driver for ST TDA7802
  ASoC: tda7802: Add enable device attribute
  ASoC: tda7802: Add speaker-test sysfs

 .../devicetree/bindings/sound/tda7802.txt          |  26 +
 sound/soc/codecs/Kconfig                           |   6 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/tda7802.c                         | 815 +++++++++++++++++++++
 4 files changed, 849 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tda7802.txt
 create mode 100644 sound/soc/codecs/tda7802.c

-- 
2.11.0


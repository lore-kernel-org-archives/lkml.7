Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768C5C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 19:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C00206A3
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 19:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbfJMTAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 15:00:18 -0400
Received: from inva021.nxp.com ([92.121.34.21]:39228 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728481AbfJMTAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 15:00:18 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2682F20031D;
        Sun, 13 Oct 2019 21:00:16 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 23BF120014F;
        Sun, 13 Oct 2019 21:00:16 +0200 (CEST)
Received: from fsr-ub1864-103.ea.freescale.net (fsr-ub1864-103.ea.freescale.net [10.171.82.17])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 761BC20624;
        Sun, 13 Oct 2019 21:00:15 +0200 (CEST)
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     perex@perex.cz, tiwai@suse.com, broonie@kernel.org,
        kuninori.morimoto.gx@renesas.com
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [RFC PATCH 0/2] Introduce for-dpcm DT property
Date:   Sun, 13 Oct 2019 22:00:12 +0300
Message-Id: <20191013190014.32138-1-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to be able to create DPCM links even if we have a single CPU DAI
or just a dummy CPU DAI.

Daniel Baluta (2):
  ASoC: simple-card: Introduce force-dpcm DT property
  ASoC: simple-card: Add documentation for force-dpcm property

 .../devicetree/bindings/sound/simple-card.txt |  1 +
 include/sound/simple_card_utils.h             |  4 +++
 sound/soc/generic/simple-card-utils.c         | 17 +++++++++++++
 sound/soc/generic/simple-card.c               | 25 +++++++++++++++++--
 4 files changed, 45 insertions(+), 2 deletions(-)

-- 
2.17.1


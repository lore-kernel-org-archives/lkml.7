Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C238FC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 10:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E3C21743
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 10:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfEAKXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 06:23:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44649 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfEAKXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 06:23:23 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hLmOL-0004HA-AE; Wed, 01 May 2019 10:23:09 +0000
From:   Colin King <colin.king@canonical.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Keyon Jie <yang.jie@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ASoC: SOF: Intel: fix spelling mistake "incompatble" -> "incompatible"
Date:   Wed,  1 May 2019 11:23:08 +0100
Message-Id: <20190501102308.30390-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a hda_dsp_rom_msg message, fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/sof/intel/hda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index b8fc19790f3b..84baf275b467 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -54,7 +54,7 @@ static const struct hda_dsp_msg_code hda_dsp_rom_msg[] = {
 	{HDA_DSP_ROM_L2_CACHE_ERROR, "error: L2 cache error"},
 	{HDA_DSP_ROM_LOAD_OFFSET_TO_SMALL, "error: load offset too small"},
 	{HDA_DSP_ROM_API_PTR_INVALID, "error: API ptr invalid"},
-	{HDA_DSP_ROM_BASEFW_INCOMPAT, "error: base fw incompatble"},
+	{HDA_DSP_ROM_BASEFW_INCOMPAT, "error: base fw incompatible"},
 	{HDA_DSP_ROM_UNHANDLED_INTERRUPT, "error: unhandled interrupt"},
 	{HDA_DSP_ROM_MEMORY_HOLE_ECC, "error: ECC memory hole"},
 	{HDA_DSP_ROM_KERNEL_EXCEPTION, "error: kernel exception"},
-- 
2.20.1


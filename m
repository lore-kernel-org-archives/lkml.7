Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1364C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E01420651
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbfHMOoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 10:44:08 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4253 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729407AbfHMOoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 10:44:08 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8C3EACE55FB74A7A2934;
        Tue, 13 Aug 2019 22:44:05 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Tue, 13 Aug 2019
 22:43:55 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <perex@perex.cz>, <tiwai@suse.com>,
        <pierre-louis.bossart@linux.intel.com>, <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ALSA: hda/sigmatel - remove unused variable 'stac9200_core_init'
Date:   Tue, 13 Aug 2019 22:43:23 +0800
Message-ID: <20190813144323.50624-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sound/pci/hda/patch_sigmatel.c:981:30: warning:
 stac9200_core_init defined but not used [-Wunused-const-variable=]

It is never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/pci/hda/patch_sigmatel.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 0d9b627..894f3f5 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -975,15 +975,6 @@ static int stac_create_spdif_mux_ctls(struct hda_codec *codec)
 	return 0;
 }
 
-/*
- */
-
-static const struct hda_verb stac9200_core_init[] = {
-	/* set dac0mux for dac converter */
-	{ 0x07, AC_VERB_SET_CONNECT_SEL, 0x00},
-	{}
-};
-
 static const struct hda_verb stac9200_eapd_init[] = {
 	/* set dac0mux for dac converter */
 	{0x07, AC_VERB_SET_CONNECT_SEL, 0x00},
-- 
2.7.4



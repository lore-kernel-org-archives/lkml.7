Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC8EC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C2652083B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731695AbfFTOuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 10:50:24 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53824 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726551AbfFTOuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 10:50:24 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 00E8BD69FDD3116E966A;
        Thu, 20 Jun 2019 22:50:06 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Thu, 20 Jun 2019 22:49:56 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Zhu Yingjiang <yingjiang.zhu@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>
CC:     YueHaibing <yuehaibing@huawei.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] ASoC: SOF: Intel: hda: remove duplicated include from hda.c
Date:   Thu, 20 Jun 2019 14:57:09 +0000
Message-ID: <20190620145709.122498-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicated include.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/sof/intel/hda.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 51c1c1787de7..7f665392618f 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -19,7 +19,6 @@
 #include <sound/hda_register.h>
 
 #include <linux/module.h>
-#include <sound/hdaudio_ext.h>
 #include <sound/sof.h>
 #include <sound/sof/xtensa.h>
 #include "../ops.h"






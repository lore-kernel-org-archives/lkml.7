Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B63C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA1220645
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732366AbfDQPM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 11:12:56 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41650 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729395AbfDQPM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 11:12:56 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DE29AEFA6820A1E09472;
        Wed, 17 Apr 2019 23:12:48 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Wed, 17 Apr 2019
 23:12:39 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <pierre-louis.bossart@linux.intel.com>,
        <liam.r.girdwood@linux.intel.com>, <yang.jie@linux.intel.com>,
        <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>
CC:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: Intel: Haswell: Remove set but not used variable 'stage_type'
Date:   Wed, 17 Apr 2019 23:11:40 +0800
Message-ID: <20190417151140.20320-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Fixes gcc '-Wunused-but-set-variable' warning:

sound/soc/intel/haswell/sst-haswell-ipc.c: In function 'hsw_stream_message':
sound/soc/intel/haswell/sst-haswell-ipc.c:669:29: warning: variable 'stage_type' set but not used [-Wunused-but-set-variable]

It is never used since introduction in
commit ba57f68235cf ("ASoC: Intel: create haswell folder and move haswell platform files in")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/intel/haswell/sst-haswell-ipc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/intel/haswell/sst-haswell-ipc.c b/sound/soc/intel/haswell/sst-haswell-ipc.c
index 31fcdf12..4d3de99 100644
--- a/sound/soc/intel/haswell/sst-haswell-ipc.c
+++ b/sound/soc/intel/haswell/sst-haswell-ipc.c
@@ -672,7 +672,6 @@ static int hsw_stream_message(struct sst_hsw *hsw, u32 header)
 
 	stream_msg = msg_get_stream_type(header);
 	stream_id = msg_get_stream_id(header);
-	stage_type = msg_get_stage_type(header);
 
 	stream = get_stream_by_id(hsw, stream_id);
 	if (stream == NULL)
-- 
2.7.4



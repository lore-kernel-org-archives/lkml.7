Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEFCC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 402EA206CC
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbfKTRvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 12:51:31 -0500
Received: from esa2.mentor.iphmx.com ([68.232.141.98]:37731 "EHLO
        esa2.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbfKTRva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 12:51:30 -0500
IronPort-SDR: eRwJqixMsriCaG9dBzMCOl6w1DfbOcg/qOvDAjdsaF8AmI5ICem+TRxVs2ejtqloG35+9SDPOX
 Ka4f8XDJ6ctPCkpZJuK5Zy5Anp0VeCcUDQ+UNsfbgwvRK4YiGYTDQGPgN8rAl8ti10tQAM6mKr
 WQwfP5kYk0rLFQLpwZC9421EqRLJneoUKJNKN0QwOOph8GGQI0W+fGmXbmVNhy+bLLU6GN2Gqc
 P4kh5Jq94hJ8XKbQOjELBmRgsG+e8DWv+GxGqPzeKc7ZrXegHTavuO3yZ1Fb+KdK3hxH1IyGNM
 4SY=
X-IronPort-AV: E=Sophos;i="5.69,222,1571731200"; 
   d="scan'208";a="43299513"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa2.mentor.iphmx.com with ESMTP; 20 Nov 2019 09:51:30 -0800
IronPort-SDR: CUHHf9ZBNW0bhNaSV3L/eBL5GYoDBqLnsKtvfhZPRRBi6VrC/IunNhYsgFZOqPj5bW3rYiL5Vu
 4ukHEQiAS6acUXrV30D5vwu7Jk6jG97W78eBnlHGwpeD6rW2lxMvWLai/GqWdXSKUExUNbN0wa
 lpWwKtKLpqlQ1bEgh9kPnpOLF+omVW8Zcs6WphYVfhdP58FFDh+GDCOZPdBrhEAQgNu77kHiq5
 76+Skn90gNd/3ci2rULZlNtTrBDO0/iscRWYMHzNDGnDEzeFo7pzYsO1jONcx/fqjJD6Notc2l
 YSc=
From:   Andrew Gabbasov <andrew_gabbasov@mentor.com>
To:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Timo Wischer <twischer@de.adit-jv.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: [PATCH v5 5/7] ALSA: aloop: Move CABLE_VALID_BOTH to the top of file
Date:   Wed, 20 Nov 2019 11:49:53 -0600
Message-ID: <20191120174955.6410-6-andrew_gabbasov@mentor.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191120174955.6410-5-andrew_gabbasov@mentor.com>
References: <20191120174955.6410-1-andrew_gabbasov@mentor.com>
 <20191120174955.6410-2-andrew_gabbasov@mentor.com>
 <20191120174955.6410-3-andrew_gabbasov@mentor.com>
 <20191120174955.6410-4-andrew_gabbasov@mentor.com>
 <20191120174955.6410-5-andrew_gabbasov@mentor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-06.mgc.mentorg.com (139.181.222.6) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Timo Wischer <twischer@de.adit-jv.com>

so all functions can use the same.

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
---
 sound/drivers/aloop.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 2f208aaa54cf..0eacaa9d7862 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -55,6 +55,10 @@ MODULE_PARM_DESC(pcm_notify, "Break capture when PCM format/rate/channels change
 
 #define NO_PITCH 100000
 
+#define CABLE_VALID_PLAYBACK	BIT(SNDRV_PCM_STREAM_PLAYBACK)
+#define CABLE_VALID_CAPTURE	BIT(SNDRV_PCM_STREAM_CAPTURE)
+#define CABLE_VALID_BOTH	(CABLE_VALID_PLAYBACK | CABLE_VALID_CAPTURE)
+
 struct loopback_cable;
 struct loopback_pcm;
 
@@ -224,10 +228,6 @@ static inline int loopback_jiffies_timer_stop_sync(struct loopback_pcm *dpcm)
 	return 0;
 }
 
-#define CABLE_VALID_PLAYBACK	(1 << SNDRV_PCM_STREAM_PLAYBACK)
-#define CABLE_VALID_CAPTURE	(1 << SNDRV_PCM_STREAM_CAPTURE)
-#define CABLE_VALID_BOTH	(CABLE_VALID_PLAYBACK|CABLE_VALID_CAPTURE)
-
 static int loopback_check_format(struct loopback_cable *cable, int stream)
 {
 	struct snd_pcm_runtime *runtime, *cruntime;
-- 
2.21.0


Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9E6C1747C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D53721882
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389757AbfKEOeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 09:34:37 -0500
Received: from esa3.mentor.iphmx.com ([68.232.137.180]:53861 "EHLO
        esa3.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389185AbfKEOef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 09:34:35 -0500
IronPort-SDR: vCClRsXmGmTTNFr4raZiUYd41RSG6pHoNfMwjt4Ba6/tnylpYuzSNbjEK3iIxLcLzlG/XY7JkC
 GRYTAqxNPp75BvETHdBCHmfzomv3v8pXGizmUEly+XN1+QTbDRIfwG0dzrm6EvBoUu1mEq+NPv
 sBIMvbCGdsChZWw2paMGpvqmtsbRpT6wc9eAakXiR50kRRKkCy+H0TT5XUcT7Ecc4pgw4YEY29
 0zpKDuvVmQ7T1qgGPaZ7uPo/aPL2SKT/fmjuGO9follRSksxv0tfda4NYWRh7Ju1XKXSghLeGO
 4yI=
X-IronPort-AV: E=Sophos;i="5.68,271,1569312000"; 
   d="scan'208";a="42878547"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa3.mentor.iphmx.com with ESMTP; 05 Nov 2019 06:34:35 -0800
IronPort-SDR: 8egWQg81+5LreDHcOpMRCtMBtLfLF7C3VhqcTXg8LFfHs+8opw5R3oJoVoKs02F1ltrBDje42a
 WyR1E/Rm0VJvhFkIwvz0iveAfAsz/UQ81ttlwYvhKggKbavm8H5WqAdGYhiW1qm6VL5reNA6Gv
 AVs1dT61nwmqEno5qq9SCXC+qUfSLv2VZzJxTHyWkL9BVE8INzaL6Am5OqOixmTKyj5AZ1OZTK
 KwDFV7De1lmrMJhEfGPeqriYuCMLiVYpest6A3+lZI98d9ZUX0+iSDF/XheVdroIr3KYHr2mS4
 luI=
From:   Andrew Gabbasov <andrew_gabbasov@mentor.com>
To:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Timo Wischer <twischer@de.adit-jv.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: [PATCH v2 6/8] ALSA: aloop: Move CABLE_VALID_BOTH to the top of file
Date:   Tue, 5 Nov 2019 08:32:16 -0600
Message-ID: <20191105143218.5948-7-andrew_gabbasov@mentor.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191105143218.5948-6-andrew_gabbasov@mentor.com>
References: <20191105143218.5948-1-andrew_gabbasov@mentor.com>
 <20191105143218.5948-2-andrew_gabbasov@mentor.com>
 <20191105143218.5948-3-andrew_gabbasov@mentor.com>
 <20191105143218.5948-4-andrew_gabbasov@mentor.com>
 <20191105143218.5948-5-andrew_gabbasov@mentor.com>
 <20191105143218.5948-6-andrew_gabbasov@mentor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-07.mgc.mentorg.com (139.181.222.7) To
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
index 178f7260a650..313d7ffe6c91 100644
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


Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD2EC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 11:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D6E2190F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 11:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfKKLJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 06:09:59 -0500
Received: from esa2.mentor.iphmx.com ([68.232.141.98]:30879 "EHLO
        esa2.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfKKLJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 06:09:59 -0500
IronPort-SDR: +MRlxgY7iiz1rrabU4NCl+YdNNlw82xQGyMeVmnXS4ansbTCeodmwcTUMGUJJ2DybmiXOhzmH6
 iaz0C9kEqqmmpnf43sPiGtiHbh87ZVTScbMQXIbTnjljazgg5dgndw73j+KzxnUSTnhJwbNqje
 41Bo7GjhgXQK0kzRkIrShSW1lTEiddh+l83M4qfmpR93QiuYDQNnZN6tzxOQMk978a6KhmbsT2
 btL36MM4sgzDoHrnbtaxMMF8edYYjTdVhclXbt6v1AeYBmSxwztLg1qwFNRytfbrQBxr/Cm/0j
 50Q=
X-IronPort-AV: E=Sophos;i="5.68,292,1569312000"; 
   d="scan'208";a="42981210"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa2.mentor.iphmx.com with ESMTP; 11 Nov 2019 03:09:58 -0800
IronPort-SDR: 5QwQpd2UBT/k2p5OLkV4ejgc/1AkE/uU0DLu5z1Syzg70AHcDId4OS5HpEaormtYqgyzbWYxxH
 NCvm7gPSm9C/Pdc7gYshOFvrzzdji4AaSSM/rTQCnwbh2hL+GOkpOxplzeEVVz/4S2sXPjnPfy
 lzlu+uNsr5EujyWzTazE0vCsHcDX7vFcmwfhj1jIQrv4Mkc/BvWvSId6GJGQdekrjuWRncPLzZ
 7XsdK/4E3hnWyipHfBGna7D0soX/QnshmeCfqtAWYB6hhrfrBabEUTY4Bi9muwlqDEMvYiYcQz
 2uU=
From:   Andrew Gabbasov <andrew_gabbasov@mentor.com>
To:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Timo Wischer <twischer@de.adit-jv.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: [PATCH v3 5/7] ALSA: aloop: Move CABLE_VALID_BOTH to the top of file
Date:   Mon, 11 Nov 2019 05:08:44 -0600
Message-ID: <20191111110846.18223-6-andrew_gabbasov@mentor.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191111110846.18223-5-andrew_gabbasov@mentor.com>
References: <20191111110846.18223-1-andrew_gabbasov@mentor.com>
 <20191111110846.18223-2-andrew_gabbasov@mentor.com>
 <20191111110846.18223-3-andrew_gabbasov@mentor.com>
 <20191111110846.18223-4-andrew_gabbasov@mentor.com>
 <20191111110846.18223-5-andrew_gabbasov@mentor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-05.mgc.mentorg.com (139.181.222.5) To
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


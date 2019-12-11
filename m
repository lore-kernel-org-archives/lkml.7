Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB63CC00454
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 21:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE4020637
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 21:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfLKVVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 16:21:13 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:40411 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbfLKVUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 16:20:51 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MhCq4-1i2E1j40qQ-00eMD8; Wed, 11 Dec 2019 22:20:34 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
Cc:     Baolin Wang <baolin.wang7@gmail.com>, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v7 9/9] ALSA: bump uapi version numbers
Date:   Wed, 11 Dec 2019 22:20:25 +0100
Message-Id: <20191211212025.1981822-10-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191211212025.1981822-1-arnd@arndb.de>
References: <20191211212025.1981822-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lCktzJYozNs3B0kWxyrFoZnS1JrDshoD0BgAOOtPca5RzXgAQmc
 l2W4MPeCpp+inIq/7xjx/JNBcdZMsOMO+ZGxkgXmmlTdZIz4PmlxmfS9CnXtK5JOYnXIzNl
 7hd+IjJQcFknL4nQjrbDyV6y+M1TgsPkdrQKscsHLB8MBvVeNLTPTo0P/axUvyUXy0JEzPV
 QEBxYIL+LVVq/qBET8lWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Me9XM8idYBw=:PpSHMQCjMCOePdCjSzUNcb
 XIhHkC5twEGrwaTXmoAViaEsJuuZsIwshSMm6rS69sQgmCDyGt347t9xcufhQOdjfPVY5Lz5X
 VvOeVZRHdH9iS7YdcUMpGvcci0+u35WxvX5V6wzI810OhowCUd4oAh7oD2pGuiCTQF6buCV9q
 ZRh64e0TzMHnXVJnR5S5K1/g2IWA8VNYj+72lmzR7Nce+Ne3nE86anPtQeOdse93DqM4VFsAl
 m/IV/o+vOscmgzwqbmLRs1Rcfen/AR8FY6d/vIF+v5VkFhRRJTBcW3s44CEvuJsXZBT4VbH+9
 XZr8p8C2stni19yy6007gcRA8Ttlx68V6bdLnBhu/1jAvn5ESFo/zuM6FlOkrNm6/MkO2Y8wv
 UuLSwXT0eZydx8d9jRuZH/sO5Asdec0mcNmUFI/VXq8MsXNOcQDqg19mG1EEh7NbFKXcM+uaJ
 pqRduztWV0RSwx6a9PrYCy9/5YpbGrYsv3/+uEJaTjyMnXfZ63C6ErvnlwJWleH1OMj9fiqZE
 bJAZE0t/nIFNdJCxk1U4WKdfC7fLxv8Vum1nvTVpgztuyit5L1/VNyQRy31W/cjm4d5/ngM/8
 6usvnt3rvtp/svkTjBTrza+o2wYrCph66B4WcQjZ7Xe3xfbYqyq20+pHlHlh0lmJSyZfPiXzc
 fgoXbV1z4mRKNcEgHaIatcBTzDEKtPY+2/XblOWVSjYGc9m2zO6TErjus1qUC9Fm5o3rRXPwL
 6XwPGoLyRME5cZcqzCO+7NN1Emwk6/vuNHRXJIODICPF50HXVowfoimva+aG87VWGVS4K0YkK
 Hk2qQswi1SjfY5SvMz+DoN9/i/AayNLXUfflLc3jFM4e9W/ceY7JAdvRhJd7AQDrGHxzz8G1I
 Pc5XxChsunG7YtGvMWHA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change SNDRV_PCM_VERSION, SNDRV_RAWMIDI_VERSION and SNDRV_TIMER_VERSION
to indicate the addition of the time64 version of the mmap interface and
these ioctl commands:

SNDRV_PCM_IOCTL_SYNC
SNDRV_RAWMIDI_IOCTL_STATUS
SNDRV_PCM_IOCTL_STATUS
SNDRV_PCM_IOCTL_STATUS_EXT
SNDRV_TIMER_IOCTL_TREAD
SNDRV_TIMER_IOCTL_STATUS

32-bit applications built with 64-bit time_t require both the headers
and the running kernel to support at least the new API version. When
built with earlier kernel headers, some of these may not work
correctly, so applications are encouraged to fail compilation like

 #if SNDRV_PCM_VERSION < SNDRV_PROTOCOL_VERSION(2, 0, 15)
 extern int __fail_build_for_time_64[sizeof(long) - sizeof(time_t)];
 #endif

or provide their own updated copy of the header file.
At runtime, the interface is unchanged for 32-bit time_t, but new
kernels are required to work with user compiled with 64-bit time_t.

A runtime check can be used to detect old kernel versions and
warn about those.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/sound/asound.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index df9983e7ead5..e6a958b8aff1 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -156,7 +156,7 @@ struct snd_hwdep_dsp_image {
  *                                                                           *
  *****************************************************************************/
 
-#define SNDRV_PCM_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 14)
+#define SNDRV_PCM_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 15)
 
 typedef unsigned long snd_pcm_uframes_t;
 typedef signed long snd_pcm_sframes_t;
@@ -710,7 +710,7 @@ enum {
  *  Raw MIDI section - /dev/snd/midi??
  */
 
-#define SNDRV_RAWMIDI_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 0)
+#define SNDRV_RAWMIDI_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 1)
 
 enum {
 	SNDRV_RAWMIDI_STREAM_OUTPUT = 0,
@@ -766,7 +766,7 @@ struct snd_rawmidi_status {
  *  Timer section - /dev/snd/timer
  */
 
-#define SNDRV_TIMER_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 6)
+#define SNDRV_TIMER_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 7)
 
 enum {
 	SNDRV_TIMER_CLASS_NONE = -1,
-- 
2.20.0


Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37154C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC17921902
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbfCKN3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:29:19 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:42131 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727536AbfCKNTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:33 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MORMu-1hPqZh2UjG-00Px5R for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:31 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 030/114] sound: oao: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:17:42 +0100
Message-Id: <1552310346-7629-31-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:dO9sO0Qax0EiREJAz+uYfttpQLJssOvBGpLIaGAWzA2PvyMP+hq
 LmEpDYxWN6xH2qguit2mq+TlrFrVr6LSV7wlpgKOLukKl61I+66ffOtvE/FvJE9o2uXNpBY
 cVACzf0w+snP8rREdIBulHbXrbX9tAI0BFBfo5kBqSg2LvolrctJv3kqNBt2G6z2ds2g+Bx
 JdZO3t5KM9YVeql85sq4Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5bzEUc2894s=:wo+boS0QIWp+bL2c/T4RIg
 CVQpRTkk2PXNlaRSHF1LPa6QJKa+NaAtrwO/Z/rpQFbqpR5oNWd+iSe2HX2qI3d7EwZxF/mwt
 Rq5nNXvuDmspKmn28FC/pmecfP7P+8yczDFpTHeoMhK8e/ECn4o+tvD+JN/ud90Cwv4xTKu9I
 V7n4azE113wWUVp41YORLKbYf788Wl6m8qfUgm47oHI090Ttjkh/NVQg3ttRxhDoPiGKGji08
 liXAOWTC/Qi+1dPJpCWLtjMc5+5NxOXDX2zTo2Qdy5eLXPxtiUWWgIca6hoM4uZQp6p6bjzqz
 y6H8cw97gKF81elgFvV1V5RJYrm32DNLEZm3bd9HFHAnU0rHCwa+lPcLVfk+vd89ZjT8/+yVK
 Q4XFchoZsGZaMSjKgm5VamhzU+WDFPPc+t6YGBJ+bLjhbctVTAx2Re0gzr1w5Nu38lLfFl+YW
 gEIi8Ffp30zsnZk0We0ciuPDPWs0hCHLcL7jiiNPAAsFVa5ylKvG73wXLxNHsQM4FisCoVTg+
 la9UqgoJ8BnYn72UDka+pbEOqSimlvCG+9YKnwxTBLc4wwHJpfd3m5h0FkiB0USnnRvUi9d9r
 075qrKvJH2KDdLdrtqXsSkobwAcvnlvlN325zrTt13C0hreUG0R5aobuqS0KMwni14EClPGw2
 woJ6CNfTCOGDf8UVJq6CnePzcFephIZzL8IX11LoQjVP2ppjyeyNZrf2vRDx+JvLe163n+ZXy
 7jOA4qkrM040rFCzzxaLHFIFnG1/sY8Uymy2yw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 sound/aoa/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/aoa/Kconfig b/sound/aoa/Kconfig
index c081e18..a1e3231 100644
--- a/sound/aoa/Kconfig
+++ b/sound/aoa/Kconfig
@@ -3,8 +3,8 @@ menuconfig SND_AOA
 	depends on PPC_PMAC
 	select SND_PCM
 	---help---
-	This option enables the new driver for the various
-	Apple Onboard Audio components.
+	  This option enables the new driver for the various
+	  Apple Onboard Audio components.
 
 if SND_AOA
 
@@ -14,4 +14,4 @@ source "sound/aoa/codecs/Kconfig"
 
 source "sound/aoa/soundbus/Kconfig"
 
-endif	# SND_AOA
+endif # SND_AOA
-- 
1.9.1


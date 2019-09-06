Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8370C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EDE920842
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405770AbfIFPhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 11:37:09 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:45071 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404930AbfIFPhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:37:09 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MSqbe-1hiV2c2HkM-00UICm; Fri, 06 Sep 2019 17:37:04 +0200
From:   Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Denis Efremov <efremov@linux.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] lz4: make LZ4HC_setExternalDict as non-static
Date:   Fri,  6 Sep 2019 17:36:51 +0200
Message-Id: <20190906153700.2061625-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:EJ5JQ+Xj0P7cX8kieNr9FXzkUNigJ9OgMm2KcPl1kp14ZBgs82I
 tRcGaVG2o/4UOvzMulaiIztZyY0IuZ38B8wNGYTdj9VWbEjQIZLbJlQXuvrLjcVF7f1z5FI
 itnFcXTrrCsWOqKoFtwacZDb6m5Ql7s2ABsnPyBdcS+4Tg8knyjv94c7S2f6Z7WSoESB0G5
 U+r676C0x1uz+ovKop9qg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VQN4GhY3oFE=:CYjie9SUE7YSwX34TXIlWF
 OuCXJLFkZAsOvMYStltjIOLv9sUpMJeKiQ8OleFjiosRtwzLyLhYz8oo88wjC8lQAoHRjbmkr
 WN+ZyDpXE+XkbxDZPieE315e29PuPzCxOuJJ3y6mcJTtE8Ul0GeKy/gFbftvDwhLqLR6/ShLZ
 ebvx+Vxr0TMlB9coJEg48oBLn7OEWYSAuEdku3qTKh9rN2Cc+dv9vk0M0+ypVe95aTtT0VjEx
 KoSWHK76wHKQ6SeCMZtROyUjDrfbe3bNLi7ebLo2e+j6L0SsA9LTlzNaflvnZwmyeJf58+/Lh
 k1metbgVOH5XqBm0QVcHR5OB8fMubvGNUfV5dx8p3SUq3tUdXRgtmopcGf8keJbyLslIwbi1M
 65vR0jZOD0df8XJ94DZP92NPqopdOVssOAhHpGapxCmQRjF4wSxAlV37PyTQU0P+gQyg7kEyx
 CX5YJGOIuexPtfalTuv5/NkynhODs4LGNWEcSK4rkvxJp0lGsLbxFL7Q5LNkeM/szf48uHV1W
 MIJuxNCxmO//1ihL6IaOyaFDbiifVCjX/gNPy9rXWappg3ZhM0IMRgYFrS8EtlpGwTHL+0IwQ
 oKmlnCIgqqZSQVKokdz5Qfj0C51PklBF3v+OjL8KzUjmIztCQ5K5IH9l5JrLcqEATfYyK96EQ
 Zx1Kc2GKNWxxVTAc0HyHHGidkYD+U1SoNCg3vYlswT+nq9CHGL4dBc2xo9I+UCLDazqAX0Uh7
 qp/wn0kppyzL9xem/BEtsoHUaavueZQgj9dKJbEIhv9VHlNr6e9IvxfCrLU06OjEL9whyaHBO
 MiTIRSxsrG93VZasGOYHxHDMCC3P1nCDAgHT4/h6jNMKBew/+8=
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kbuild warns for exported static symbols. This one seems to
be meant as an external API but does not have any in-kernel
users:

WARNING: "LZ4HC_setExternalDict" [vmlinux] is a static EXPORT_SYMBOL

I suppose the function should not just get removed since it would
be nice to stay close to the upstream version of lz4hc, so just
make it global.

The modpost commit is correct, but is listed here as the one
that introduced the warning.

Fixes: 15bfc2348d54 ("modpost: check for static EXPORT_SYMBOL* functions")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/lz4/lz4hc_compress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/lz4/lz4hc_compress.c b/lib/lz4/lz4hc_compress.c
index 176f03b83e56..e1075293c009 100644
--- a/lib/lz4/lz4hc_compress.c
+++ b/lib/lz4/lz4hc_compress.c
@@ -642,7 +642,7 @@ EXPORT_SYMBOL(LZ4_loadDictHC);
 
 /* compression */
 
-static void LZ4HC_setExternalDict(
+void LZ4HC_setExternalDict(
 	LZ4HC_CCtx_internal *ctxPtr,
 	const BYTE *newBlock)
 {
-- 
2.20.0


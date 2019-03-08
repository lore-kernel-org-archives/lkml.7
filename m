Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A89C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593F42171F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbfCHMpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:45:12 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:53981 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfCHMpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:45:09 -0500
Received: from orion.localdomain ([95.117.97.241]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MXXhv-1hZz9T2kzH-00Z0GT; Fri, 08 Mar 2019 13:44:56 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        info@metux.net, apw@canonical.com, joe@perches.com,
        linux-kbuild@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v1 3/5] scripts: mkdebian: fix missing dependencies
Date:   Fri,  8 Mar 2019 13:44:22 +0100
Message-Id: <1552049064-32044-4-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552049064-32044-1-git-send-email-info@metux.net>
References: <1552049064-32044-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:OWyby/vHANVNNMYaidRl2wwWpg1kO3p0r+hXraXU1Tf2ssUBzr9
 dyd6kvrBNBzqHxakCo0LQvcZlH8oNuuanpoTRkLEDqhoKGHLBUWBBUHPewtPmpnDVpBsWGx
 A2Mc/4Oqf8j5Kv6j89BLnNndENBSOGj+64lJZ/tp1K67mk3pWOmA/KUhORhZuMo2ZPDozPn
 i09lGvD/uHC00uMFqPTyg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:C3yabQBAdw4=:kGWe2kRo8q+AWt4ba012Vj
 XCERP/kV+/9ZHCa5QTWgZBdOIs8G+ZhuKlKIl5746z14kYPdEwlW66W9lWryVBugwtVpbCL+n
 L3OhSeKL41CrzOPgNpSaV5xValD2ditTBFtmzHRet2zIRJ7vMaIAenNHFRe+MDMb2DSpRBtMW
 q5oWLvfNUFOSPoV0bDVgJ6Uik88MiQ+rC6rk2/LQBLHT9B4KwvVZo70oiXa19FszxjS1nuuPH
 yuHGk0aH4o3t1+LCErjj9iqAdmISOaoijCmwQmiJePUDUpRFX3UOM6C2UVQAuQbgNvDfQxzZs
 SwjwQJI1vAz7gpAW2yDkRncu3O/+N3ZkOXp5XRTRHIVHdhR3YmplAvpB1AVX7iKUCYfXMs5H8
 mWqdJtYGgWWKtpIdoQnhR+3R9xZRiRsccht5NkUgYbllXoEvyfL8YFVEesdJ2vfqXI3AK4BHA
 ackWEUsIUrFXfceF2mWUhEcvOe02afBJU3H0kK9LsUdUulfQ4EyUh6ErvW4/mBbNRCVxRd0sH
 vsR0/6YsbyeJqKkigvAMHM00uECaclJ7XuG5Bcn1csAZpAe53ajJqJYrc+7QIa1rLHgm7ApmX
 nSO+cFTM5xWQ5JRXjOo4VJLdzzDIEWXgkUrT6TRH7Btvo7z4NC7kCD2pmx7DpqLqHlAr10dTg
 9I177g1/iEv5uH0R7RiLjpU/AyA0/ttCJMqx+T5q6aNVyiBspGvyWPa2c2u2fwnA43jYbA2TE
 9NaeDj4AAEev+hcQgN10C01W2/WfyDqMmkTTCg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We missed some build dependencies in the generated debian/control file.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 scripts/package/mkdebian | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index ff226be..1caaf0b 100755
--- a/scripts/package/mkdebian
+++ b/scripts/package/mkdebian
@@ -173,7 +173,7 @@ Source: $sourcename
 Section: kernel
 Priority: optional
 Maintainer: $maintainer
-Build-Depends: bc, kmod, cpio
+Build-Depends: bc, kmod, cpio, bison, libelf-dev, libssl-dev, flex
 Homepage: http://www.kernel.org/
 
 Package: $packagename
-- 
1.9.1


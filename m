Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86ACC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70FC20868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbfDPU3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 16:29:23 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:44315 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729301AbfDPU2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 16:28:51 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mvs2R-1gxjE516Rj-00sujc; Tue, 16 Apr 2019 22:28:50 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 23/26] compat_ioctl: remove joystick ioctl translation
Date:   Tue, 16 Apr 2019 22:28:08 +0200
Message-Id: <20190416202839.248216-4-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190416202839.248216-1-arnd@arndb.de>
References: <20190416202013.4034148-1-arnd@arndb.de>
 <20190416202839.248216-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:r/Kb0i7Xy4vPnTn9s9xCcx5+ALl9dBVzlDy54xW8f3JVJ3ISv41
 zEfpwzdiyswKT1Wup9cHCIluvMfJqTfayVFRHd7vywa7fSy1rmEA7zPpgUBXOgrI0rA+LpH
 XrKRf6bZDuu0nK9g1QXZt/fzAtZPF7Y7/Xbil3vMeXshDT4geNJ5s5ZC5NvySEmZ7mRkjNR
 HJWlj05mi6cKjtrxnqNVg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yOBQTyQlcKM=:2GNN2dLKkkYRv+oCpIpnZA
 mzYvUTB4lKqbmJWWPSt37Y3/ulzBQETnvS05gQwKATOwpK2ZdhsSDc1KxS8iUXqVLJvGbI5/l
 Cf2KVjcFl7tYsW5vPDCPEh62SrBgnQg93oijlZ5TUiLxdQC8kz/RiMm1Dax5/PtfSCKJBTK6r
 VUluEJZJ6A+ZNeFdFqKAPbbUzjPfKBUPB2dDxkPZppQuhvPC6PrLETwGj/KOm63tKKyhNl+pT
 SuyAMIgiyPHU9Fai07ENDwYY8Dot8SglYE2g7Bx2rErb/FpPAcsGDXthhzSkcLNII/nazwpXM
 PWJxbNtGL4uL3yg02k9vaxNDpg8EXd8vrCsVM7GAlmOkCoyPfr07udF7t7P9JxQ3P3uyKuqR0
 UueNdDeSeuxT8aqXUo4Oxt3HgRkyO7gmxM0+aIoDjwon+eFKkc6SNz0GRuRuAx2OSswOh+zx9
 neGBvqf2QZxul2wFC9F7N8jD/ZhL/520eNtLiIngess+rqdfi6RUrqYG/yoXxwYFKdzYZzA73
 KIviVSExcdWnWB+Rn+FFESurSeCsCWA+xNvuHu822E/H3gXJztWq2gtKNQ3hSto6XA8vPpwap
 5+CgO1B6cAzJxcMZwULvPKSG2j7JQOog4x1DfrMezg/Fnp4M8FSYaMue0c++NCvgwShq3rt5W
 aWMvPJHU0v510sMOojQupmQ9T8L0bAK7P1l18Mbj5mwPMjyOVgFU8GyJZVYrtiWHmC8vwn1pK
 PlCPRFuqlh2B9FHxztNSmjwx79kATiSa87ApCA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The joystick driver already handles these just fine, so
the entries in the table are not needed any more.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/compat_ioctl.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 78144a599f36..c81f5241664e 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -11,8 +11,6 @@
  * ioctls.
  */
 
-#include <linux/joystick.h>
-
 #include <linux/types.h>
 #include <linux/compat.h>
 #include <linux/kernel.h>
@@ -385,11 +383,6 @@ COMPATIBLE_IOCTL(PCIIOC_CONTROLLER)
 COMPATIBLE_IOCTL(PCIIOC_MMAP_IS_IO)
 COMPATIBLE_IOCTL(PCIIOC_MMAP_IS_MEM)
 COMPATIBLE_IOCTL(PCIIOC_WRITE_COMBINE)
-/* joystick */
-COMPATIBLE_IOCTL(JSIOCGVERSION)
-COMPATIBLE_IOCTL(JSIOCGAXES)
-COMPATIBLE_IOCTL(JSIOCGBUTTONS)
-COMPATIBLE_IOCTL(JSIOCGNAME(0))
 };
 
 /*
-- 
2.20.0


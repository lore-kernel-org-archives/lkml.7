Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D731C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 497FB20663
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbfDPU2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 16:28:55 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:41015 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730806AbfDPU2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 16:28:54 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MqbDs-1gUBSm1HMW-00mbc3; Tue, 16 Apr 2019 22:28:52 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 24/26] compat_ioctl: remove PCI ioctl translation
Date:   Tue, 16 Apr 2019 22:28:09 +0200
Message-Id: <20190416202839.248216-5-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190416202839.248216-1-arnd@arndb.de>
References: <20190416202013.4034148-1-arnd@arndb.de>
 <20190416202839.248216-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3ZKT++MKOIaWAeFxH+phaFXpicA/O7Jg3lc+FQWy7v5x3aALBYl
 on9zEz0cKj54B1M7rhKFh1IRYSiYTeFR9V3WBrM/vzpq42+fMf2rXxPyCVxIWCokSpZpHn1
 x9rjhyKneDSQxQd62jBRag6wXhh+yAgjn5at16tByeIptIGlgDkaoBjMB/Vi+6Zacrgohtv
 ETUfeFUEStG/uJ2J/vdlA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:45TbWo2gyQg=:M4QrgOdibQp9Wss+0Ojs+h
 q8WNaqRjebl+99dZRsYoIPhmSn1WPeyB/2YoIPbzbMuiHnrMoXi/zC6YpadBqNqR8cUWhBt2V
 860vywT7OHfWu5WLDQo/fIp1NnI6oKyVZZQW0ZAKqyXM5BhyNV7OnpO+CO2vaQ1mUel5UDrm2
 pcjtBKnITHUmL5RRUw3mhs1QLygNkPiPMb3lxkQMyqU8WC79xC9E8h4S20LUM6fd7qCccBWf1
 vDj9dGlZdB+Nlgij4dM+elWzb2SMU/QE1nQzlLpj0yh+vHOH0HPZa1wKbbECklMYvS1DwQHLw
 Y+Q/w0kQbPqPbQo9lUTQ7RFopUPKWsFFjku78XEPcuSLWVBjHyNPC9JBgDtwUcRM2XljN8dpl
 gwhwlMsWFybA2Af67StQe3esH8cVAsN+AtYG8pTh/+uXFrh2Dx/IqOyP8r7Gz6vVGnXmdc7Fu
 HJUrZ3S7iy/nh3eUYtfzKVJBmjSNwytKejW31w4zxeWcgtlu1BY1kq7f1Knwv2y4iRbb0AdY3
 xii+cE8lQuvD+oT7RXdWF0XHchfB7vclYu+ZJrzQthlh4at+SFef8ACqeWkQWvuYej/1Lm8wk
 f2qa0SSUGF+BYiZr6gRU75CKXHFCKP2rOO3iJ+NJmpTMfWH+rFF3YWov//nlV4lH2uTBfX0qd
 sc383qhnqLmGLMwmBPwpG4WJagonvuJLymOoMekjYzMMjLweAgJcfrmq7ePBoD148EIAKJLF9
 R2anTVQzFLfcwUENhzcaugdCbjdDl/fmg/RVog==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The /proc/pci/ implementation already handles these just fine, so
the entries in the table are not needed any more.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/compat_ioctl.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index c81f5241664e..6ad45550b4b1 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -29,7 +29,6 @@
 #include <linux/vt_kern.h>
 #include <linux/raw.h>
 #include <linux/blkdev.h>
-#include <linux/pci.h>
 #include <linux/serial.h>
 #include <linux/ctype.h>
 #include <linux/syscalls.h>
@@ -378,11 +377,6 @@ COMPATIBLE_IOCTL(WDIOC_SETTIMEOUT)
 COMPATIBLE_IOCTL(WDIOC_GETTIMEOUT)
 COMPATIBLE_IOCTL(WDIOC_SETPRETIMEOUT)
 COMPATIBLE_IOCTL(WDIOC_GETPRETIMEOUT)
-/* Misc. */
-COMPATIBLE_IOCTL(PCIIOC_CONTROLLER)
-COMPATIBLE_IOCTL(PCIIOC_MMAP_IS_IO)
-COMPATIBLE_IOCTL(PCIIOC_MMAP_IS_MEM)
-COMPATIBLE_IOCTL(PCIIOC_WRITE_COMBINE)
 };
 
 /*
-- 
2.20.0


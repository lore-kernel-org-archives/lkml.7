Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4D7C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0631E2087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfD0MzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:55:12 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:55429 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbfD0MxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:53:20 -0400
Received: from orion.localdomain ([77.2.90.210]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MRCFw-1h5zEz3V3s-00N8iN; Sat, 27 Apr 2019 14:52:57 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, andrew@aj.id.au,
        andriy.shevchenko@linux.intel.com, macro@linux-mips.org,
        vz@mleia.com, slemieux.tyco@gmail.com, khilman@baylibre.com,
        liviu.dudau@arm.com, sudeep.holla@arm.com,
        lorenzo.pieralisi@arm.com, davem@davemloft.net, jacmet@sunsite.dk,
        linux@prisktech.co.nz, matthias.bgg@gmail.com,
        linux-mips@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Subject: [PATCH 28/41] drivers: tty: serial: sunzilog: fix includes
Date:   Sat, 27 Apr 2019 14:52:09 +0200
Message-Id: <1556369542-13247-29-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
References: <1556369542-13247-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:Vc4oNRhzaq0GImBAR5CgiZ+whb77bqy0PxtEF5afHcYFvx1oVZb
 siNewF36P93CZkzncVMQnr4mlIS/A8kCZTaukIk2D/GuBtTc3OHRLhlyKjwaq32J2XmrRlB
 f2vNOVy/3BrWxRfFIWguM5CtYi1a+WcUK3nW67RriXOHA4rE+69skktXGN0uJRmUq+H07n0
 K1/tFtsXXjzqS2NXo4RKA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WBmzZwx4lgo=:NspLTi8etU0+1fQAgbr3D+
 7NJFSTzzIk8QcOgiGlxnnfA2ff9WuC2M+mUQl8CvyQPR1cl5KPNVz+Gs6GXBQgE3j+OdFEawT
 DF05YFVSL08zlHfEFGE/TaD2nZByEqUJeW9HwLJGSeckhVexHLC2nadK/PuPkZ8nQB9SDQC3m
 ggNu6zfAJ11Ymokt621Nqj/cAvK8z2g4R951W43UVyRBAPjNJLZnAWzl69dWoVEF6khz0dvoy
 NB6mQKt80tpbAIibungsiH8r/5jjf6cFypWqPbSnSL8aM68Agdeu6XvXr9NvzuK6v7vttxLz1
 XLkGi5Z7QILTWz1PWT2CP+pScInyi2KU5cWyYES+DQae3LncVeZn/UZqqvSmcV5vRuSUbWG1S
 ASupKOd9PdBnOLF7fgH4kGptvX4+k+m8hh+/IHKlLFPs4Z5V07XsPTjGP43ir6PzrBAkofC8R
 6L72iwY6PeL8WMTHw/dSgL2YdMYSLFOpnbyHooEr5hYrThcvmcHJ+TqqxR/35kt8iKd/n6kpY
 SnCPBvP/ssZHx6Ve5P17ibQdCA38lmObFRnsxaRCxeO8ceOqqJJVhD0Rnj9qz0JmfcH23axV0
 Cqo9n5OxSPdnKd10oAo8jAWkFqZFJHT3aNUP47SCVF6v8Hc030w7nv5Wy3TQJrANkYGs2zaDK
 CGdtJifVuhg6VVTvqYCedOdrWh+OZuszAW+DcmULVA8NOVb5UD1WF6EvFALLrnahi67Xh1A+O
 1a1p4u9mxM+I2OORa29atLFeiS8iBIPcjEkwbg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch warning:

    WARNING: Use #include <linux/io.h> instead of <asm/io.h>
    #38: FILE: drivers/tty/serial/sunzilog.c:38:
    +#include <asm/io.h>

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/tty/serial/sunzilog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sunzilog.c b/drivers/tty/serial/sunzilog.c
index 17b0520..85edb0d 100644
--- a/drivers/tty/serial/sunzilog.c
+++ b/drivers/tty/serial/sunzilog.c
@@ -34,8 +34,8 @@
 #endif
 #include <linux/init.h>
 #include <linux/of_device.h>
+#include <linux/io.h>
 
-#include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/prom.h>
 #include <asm/setup.h>
-- 
1.9.1


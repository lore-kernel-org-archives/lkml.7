Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12C2C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 978E52166E
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfD0MxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:53:10 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:57935 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbfD0MxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:53:07 -0400
Received: from orion.localdomain ([77.2.90.210]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MNss4-1h9I592Io4-00OFB5; Sat, 27 Apr 2019 14:52:39 +0200
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
Subject: [PATCH 07/41] drivers: tty: serial: sb1250-duart: include <linux/io.h> instead of <asm/io.h>
Date:   Sat, 27 Apr 2019 14:51:48 +0200
Message-Id: <1556369542-13247-8-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
References: <1556369542-13247-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:rdRXb5foI78ZUKXg0PVAe5Z5nzYlAxuzsWdK2nGI/ZCG+/6jRlM
 hI3kp/kBUUgLKHfqLAS7fc8k7GQ2ADy4ZKXhqdqZiryVc7Z/Z2r9L5PNnJpvCGJ5Wm3QKlp
 qfPO4bQ3xuErAjl1GwNDMV08O2NC44IuFF/UesW2Ttt/YM+Ee5ZbuxprWyPUKJV4WjcRcmA
 KbeNYOb/RogJgZxW+H2Qg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uIkJBFuyWwE=:my0C5wt5HQzdkDWW3sqLjW
 G57X9rEDzrdejwTIohdfyXbnVkKKkUjsq7O2WO6aaWwA/K7asaaqwwpANJiqlYwmtNzUe3m2F
 dIy98aX9m8AzimgrUpqTFcjmsVSy5jVNnA897BjXITdiOKUbqhDiJ8SEfxopoVvXA0ci4pE/u
 sCpkkmo4B6+eALwD3PacR4l75/GBQIcgR/X9YlludU/jwMa2Liob4BAm+iUTx6dTWwQyokWeE
 5ueRRrNwERDVxlERN61XurD0oaRK6EZk3C+alaLfFflaumVLpveKjf8NF9QNOKUCoI5MVXyiX
 HXunQn4iVV9oEPQo+yLEIGF4UfEE0Rsd1GkU6LkB/+Odbn2uQLNNWiC8KWt07Y56oarXOxrDk
 lA4uTn5RNuonkl8BJC6IAyi1AfCnyQmAgAOJlNSl4m+3PYHPhOrGjM7sgGTlh19tXj+5/CybH
 AVSJ2WFmYCNhq6mW/70XSDtRxr/UK1p1rzHbSTsjFAmr4I8RVMaqj3ZxfFotbghjdQK1581Pv
 69TkpSYev0ozeW+8xQuT5XGyqbrpcxKEzP7NDPBjAjIAKmwxFXVsCjrsmCQi802n4t/j7rgtj
 p2/1WTI2ZaKz4ftVg0fU4hcU0pFIksjotyumR0cs9ECKOFII7ztSji+wY2fpiuHhZ8jQiu3Va
 80px75vPXYZJQn8SviB8k53dJGNllXCrNlg32KHH9lod8kduYDxsK8NA4RIZxyaO3IOTafLNX
 tjDPR9hNlZyMzNBlAyzerGiY2oMGtk33LyAGRQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch warning:

    WARNING: Use #include <linux/io.h> instead of <asm/io.h>
    #41: FILE: drivers/tty/serial/sb1250-duart.c:41:
    +#include <asm/io.h>

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/tty/serial/sb1250-duart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sb1250-duart.c b/drivers/tty/serial/sb1250-duart.c
index 655961c..b4342c8 100644
--- a/drivers/tty/serial/sb1250-duart.c
+++ b/drivers/tty/serial/sb1250-duart.c
@@ -38,7 +38,7 @@
 #include <linux/types.h>
 
 #include <linux/refcount.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <asm/war.h>
 
 #include <asm/sibyte/sb1250.h>
-- 
1.9.1


Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D6DC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30465212F5
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfD0Mzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:55:42 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:43639 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfD0MxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:53:13 -0400
Received: from orion.localdomain ([77.2.90.210]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mspy4-1gVqbT38iO-00tCHb; Sat, 27 Apr 2019 14:52:51 +0200
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
Subject: [PATCH 21/41] drivers: tty: serial: cpm_uart: fix includes
Date:   Sat, 27 Apr 2019 14:52:02 +0200
Message-Id: <1556369542-13247-22-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
References: <1556369542-13247-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:xQq23jU9i9rUL2fNQuvkwl6eGPDVSQvpkDbQ/zveful4zboC1HW
 oNd3D0zOYk84zfCJ0Xuzpmh6YQ79oPwoYvw/oeAO14yaLEcslLKcMENViWN+rlXtE9vM1qv
 1jCwWuLOXgdLjw4fxAGT3BB8TcpKk2wNp9jWPWPgaYVVv0WEj/TEQ/U7sklnKXLuZSVuAgG
 ee5Mn3D1VCygJnSepJUyg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xWgBbp/LG7s=:wi8MuLImVy2CGGeEYyoQB2
 KMmBNwIQx4fsztqkOwXtcxcWItI9eedJWvICvmKhOlHgaY8MtQ25FTCVmfHiYt3j9gS36aZaa
 q9Y5EIjEBd+qyl0GLPKh4hpFw2Y9xorJzSRbpppCWg9Lng+zZdTe/MiFG1F7kXNVSzq4lt2hL
 ezKmIOR+0ajJU88S0pj4Kvx7tgnm1+AxaE/XtB3sMY5Kc/X02sDkvp4m476q2eExmeEHf7yl3
 SS9ZDZappKf9esZiUUvzR4FWzO/lGAkyPEM5TbSsWcKPe4Hwz2W19UfQilH2TsF2+lwHqakd/
 0zYcoNC9JBhT5LyMi+bJ4ixLs9s35MALlLW9l9uhuIfzTde5AJ+qVyxmXzjZs7+sgMLLy16T8
 wQ26qYtWIfsOeVfD03mLnlq295RwRXRcppjT2NdxNgQCjA8w3sUfILoNLj9Dn8itEgJAMtfl7
 V8Cx1WCsQKAgggypWMvmWuYLBZW9OCxv/vxSRFHvIZxRwPaRxNeKsu+/Fbb3nzWRANHyooXV/
 DsfRL+yilOXWQavlpzHDrWwcLFWzf4Q6C/lHFEf1NO221QjdJBnEIHiVYjdfQrgI7DXvLr6y0
 OOEW7gT7Kv/C1gTmxJIHJCzbWkK13YeuK27LFOraKAE3hMCkeL/cdQE0Eb+TGViA6xDeL5nsA
 9JTsphma2cCsaVd+QVzhXQsK2WCBYwcJMcIA1O1vu+w/HuFJbyuBL4ArPqi6deE6sKSH4G7JK
 UZVfxUQPRjkUPT6CoClRC35MnUhRE+eqWHNnlA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixing checkpatch warning:

    WARNING: Use #include <linux/io.h> instead of <asm/io.h>
    #25: FILE: drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c:25:
    +#include <asm/io.h>

    WARNING: Use #include <linux/io.h> instead of <asm/io.h>
    +#include <asm/io.h>

    WARNING: Use #include <linux/delay.h> instead of <asm/delay.h>
    +#include <asm/delay.h>

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/tty/serial/cpm_uart/cpm_uart_core.c | 4 ++--
 drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
index 374b8bb..c831d31 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -33,10 +33,10 @@
 #include <linux/gpio.h>
 #include <linux/of_gpio.h>
 #include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/delay.h>
 
-#include <asm/io.h>
 #include <asm/irq.h>
-#include <asm/delay.h>
 #include <asm/fs_pd.h>
 #include <asm/udbg.h>
 
diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c b/drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c
index ef1ae08..40cfcf4 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c
@@ -21,8 +21,8 @@
 #include <linux/device.h>
 #include <linux/memblock.h>
 #include <linux/dma-mapping.h>
+#include <linux/io.h>
 
-#include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/fs_pd.h>
 #include <asm/prom.h>
-- 
1.9.1


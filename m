Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885BFCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 665EA21852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408864AbfJRPmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:42:24 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:55249 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728464AbfJRPmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:42:23 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MMGVE-1iefOy3vpW-00JN2x; Fri, 18 Oct 2019 17:42:15 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 01/46] ARM: pxa: split mach/generic.h
Date:   Fri, 18 Oct 2019 17:41:16 +0200
Message-Id: <20191018154201.1276638-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191018154052.1276506-1-arnd@arndb.de>
References: <20191018154052.1276506-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:iVpqPa86ze0iu6OOhejjP0amJ+TBDw2xGngL1judoPmHRjZqhrN
 Q8EV0/l37SyeJE75D3N0sPgmWDWfWo3kfjx4Em1fWmC+AqabmnYF6cwMs7AEN7c0tR/Z5mh
 8hLOuC4xixrHLW0YeCu/YYym6BIPrIMwr7Df6OMgqkBrdWo/qM7oNnqRHAo4wN3I/zLbZ7L
 GlXM6ZyWBP6LsF4XfIoUQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zZptb6vq8zo=:s2X4MeHnHk9Lnsa8+6HPrv
 5iWkf8Ogxx4F2D5bQeqlIN8hnoKsIoke3kROPXtoWwAsgN/Mvgphi7O/1KVM62gqsVXB4uBUq
 QScfAuVc2CZ8xiei7BMhcnHUazOJG3tNXI+l3CA23fFXlmrtEoGJFSw7F3afJCgl54UtHmx1Y
 /QZwSwoVo+zjXlpLxNICYSt6n12AlFt7HVgkbM+cjj/vAyBXQ/MlU7ZKro7bzSGMnFdRoMZ6X
 S7KUITNX7C/e0OKxkdy1AvOGTsASKLORorjb813zTf7ZirNfGUVdVB8LFP4Oifzxsbdl0wlS2
 tp2deM99n2HYbQGZgO1zR++T4iQF1CEDbEIEXWgOZSAA7lkPX1Tbf26l/N81xs+t7hNSVG4TJ
 piwFW1fo+7M2TZTvATuN0iDJKraGYum+IezXddTa6eU9/peK9Fkz/fJ9K6qUxoqNXwU7/pjBM
 oGtM+XLr4s1dng303bjLH5TV8ajpR7SjpVzxKjsQ6AvXTtShp7HwFRuVKp+dzBFR0PH3APhrl
 Cpcj12H0cm7Vtxd0vSgQ7e/DMMPkvB4+EDK4hbt25MW/1D8kmbtYRfk9GLIYY9Ta9YeRnmRNp
 EuOovsX75bzAy/WY4EoF74EwXpdl2c7uiin15oWo4LEt9InZk6pmuik6LXXy497IMjsqj40mY
 zlsta6/sLUIXNSauSAtsxfxGLDT8OuDI2WCpjkqz+6KfWEFuo5zL+fg98GPi9rZ1f3TXecJSk
 iXuMvRUEQWgcI/3gT54guvIEuitSDyehDWK8KwzHQApnkVzUZ3+7Bk7RiVdIo5+nbAtyviXKg
 tDd30zvyCrWdDSoLe8op6L0RmbI5nySrkijI9JvuFREP81peEn3MoVcf/mfB027BdZBk1QpYk
 nNMQ503PoGBx79gW3/zQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only one declaration from this header is actually used in drivers,
so move that one into the global location and leave everything else
private.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/generic.h              | 6 +-----
 arch/arm/mach-pxa/include/mach/generic.h | 6 +++++-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-pxa/generic.h b/arch/arm/mach-pxa/generic.h
index 3b7873f8e1f8..67925d3ea026 100644
--- a/arch/arm/mach-pxa/generic.h
+++ b/arch/arm/mach-pxa/generic.h
@@ -7,6 +7,7 @@
  */
 
 #include <linux/reboot.h>
+#include <mach/generic.h>
 
 struct irq_data;
 
@@ -71,8 +72,3 @@ extern unsigned pxa25x_get_clk_frequency_khz(int);
 #define pxa27x_get_clk_frequency_khz(x)		(0)
 #endif
 
-#ifdef CONFIG_PXA3xx
-extern unsigned	pxa3xx_get_clk_frequency_khz(int);
-#else
-#define pxa3xx_get_clk_frequency_khz(x)		(0)
-#endif
diff --git a/arch/arm/mach-pxa/include/mach/generic.h b/arch/arm/mach-pxa/include/mach/generic.h
index 665542e0c9e2..613f6a299d0d 100644
--- a/arch/arm/mach-pxa/include/mach/generic.h
+++ b/arch/arm/mach-pxa/include/mach/generic.h
@@ -1 +1,5 @@
-#include "../../generic.h"
+#ifdef CONFIG_PXA3xx
+extern unsigned	pxa3xx_get_clk_frequency_khz(int);
+#else
+#define pxa3xx_get_clk_frequency_khz(x)		(0)
+#endif
-- 
2.20.0


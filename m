Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E21BCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DAC8222C3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439454AbfJRPm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:42:26 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:59491 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405999AbfJRPmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:42:24 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Ma1sQ-1iZjSV3XfQ-00VxxB; Fri, 18 Oct 2019 17:42:15 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 04/46] ARM: pxa: remove mach/dma.h
Date:   Fri, 18 Oct 2019 17:41:19 +0200
Message-Id: <20191018154201.1276638-4-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191018154052.1276506-1-arnd@arndb.de>
References: <20191018154052.1276506-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8TEqedFajmaipFY2tALtoA/H+jJS4WGpQwTgWuusrkdQdWHNuVO
 QHvjOQ4t25vRotVV4diXErGEasck7HPqDt6GpHFVkLvbEkQI+GQfET3S70RAJlJ5K7xsDIi
 /JT/MsSzBXoGhIGkufaKffAh8a17LrK65QrGP4ZpZbKh7bA1Ort3DvBZtCaXSC1MXGnBqt3
 5FBjuSCJqE3t835Fuk3MQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kDHsLqbViLM=:gdEcYHN+QBvHq7vlsT8h6G
 rIGd6V+0LqTPOWZ6S8hgGy6fTAJ9F+Au3XPG297KTnq1+aFW5sQYcApZGnbJ1jZS0+uu3Ob94
 e+9lO7+WV91QDbE98EBrF2cyskafdp61gdsu5juu6ftv8zntJY+yekueOHIxuVv0Yf4Y/JU1I
 RjqKLsjpmwFxd/I5qWCD1dkoWf0VtZ4knKajUzn3q29TRQVzo+wBFdTqMGQqqohV1Cytr0dD3
 JPefTEm6jjbPHLWeEVDypxmcKqVhIO3N/tsyjL8nZ7wAt4v2j+1GBwIjbh0jPWo6OhKbT2a4U
 /1LT2dw6P9NkGtt+y5nAY8EI4h64/6J68WWEXEJTHHHv2SxvfDmvtMI4VxQZpG+8ef8d9p+xB
 AeNwwEL1RbXk2Sddurem0eI9PxLCuUp39I6pfqtM+Ex7cYJRQ3QRIYiIVZCbcEHAh786NnFS1
 SncuqkQw7EGspdXOrtLuWW2F0TCLr5J+7sHEi0ZwnHpSNfD/rePdvKuYUc8X3JfuiwWhCnzat
 2QLdJtVCU8AL7d3Co1C0HT83+6TKe3El3M7XuobMyWR5EzRo5ip2fDa4LCmncPmEWQWcoid34
 4WyuYIvBlxAyUDfs062cMD2fu1lds1u+VojAv8md1lmUaluuIYmlhP59anUkliu5WP0HVcOec
 84RHI7NAlxnngv1AOhBBBJuKSJD+mYu/cfchkesOXCMWwY5dz1ZKibB2cdI8SPgk9muZ6zHtz
 4nknnkZv8hGEV1y0SUNEJt4DxFJX4ldHLvLTAJ7DdHX6Ag9857eIUWV+zHs8nG3vfwtPzRM0R
 zPHrCTRz5QW8bb4mKodalwCmevj3aod5ITWSe4i74R3FauW2T8oMG2DYaD0mFlCAdz6H4FeYz
 TPjqpZPT5EK0y78cUw6w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The file no longer contains anything useful, so remove it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/include/mach/dma.h | 17 -----------------
 arch/arm/mach-pxa/pxa25x.c           |  1 -
 arch/arm/mach-pxa/pxa27x.c           |  1 -
 arch/arm/mach-pxa/pxa3xx.c           |  1 -
 4 files changed, 20 deletions(-)
 delete mode 100644 arch/arm/mach-pxa/include/mach/dma.h

diff --git a/arch/arm/mach-pxa/include/mach/dma.h b/arch/arm/mach-pxa/include/mach/dma.h
deleted file mode 100644
index 79f9842a7e1c..000000000000
--- a/arch/arm/mach-pxa/include/mach/dma.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- *  arch/arm/mach-pxa/include/mach/dma.h
- *
- *  Author:	Nicolas Pitre
- *  Created:	Jun 15, 2001
- *  Copyright:	MontaVista Software, Inc.
- */
-#ifndef __ASM_ARCH_DMA_H
-#define __ASM_ARCH_DMA_H
-
-#include <mach/hardware.h>
-
-/* DMA Controller Registers Definitions */
-#define DMAC_REGS_VIRT	io_p2v(0x40000000)
-
-#endif /* _ASM_ARCH_DMA_H */
diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index 678641ab46e5..0d25cc45f825 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -34,7 +34,6 @@
 #include "pxa25x.h"
 #include <mach/reset.h>
 #include "pm.h"
-#include <mach/dma.h>
 #include <mach/smemc.h>
 
 #include "generic.h"
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index f0ba7ed24cb6..f7e89831e85b 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -33,7 +33,6 @@
 #include <mach/reset.h>
 #include <linux/platform_data/usb-ohci-pxa27x.h>
 #include "pm.h"
-#include <mach/dma.h>
 #include <mach/smemc.h>
 
 #include "generic.h"
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index 560160682df6..6eb1c24d7395 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -32,7 +32,6 @@
 #include <mach/reset.h>
 #include <linux/platform_data/usb-ohci-pxa27x.h>
 #include "pm.h"
-#include <mach/dma.h>
 #include <mach/smemc.h>
 #include <mach/irqs.h>
 
-- 
2.20.0


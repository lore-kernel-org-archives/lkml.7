Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800D1CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DAAC222C9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439667AbfJRPma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:42:30 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:33891 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405757AbfJRPmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:42:24 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N4yyQ-1hw0zj14Bo-010v3h; Fri, 18 Oct 2019 17:42:15 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 02/46] ARM: pxa: make mainstone.h private
Date:   Fri, 18 Oct 2019 17:41:17 +0200
Message-Id: <20191018154201.1276638-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191018154052.1276506-1-arnd@arndb.de>
References: <20191018154052.1276506-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Udhcyk5JTS+ruoRMUBkQ73+mMSZy0d6F8odqYEMh7EWVHlDFzur
 YAEHqgrq+6iEyuzDWfYlOEdN39pwhvaBUi+HBb9kxUqrvfJlTjXn855pEb+7YSKgIprottH
 MbhG5NkvUIaQ0ECtq/JAjNi+AVRlCOLCRx/ZN6koBpNCOTmwQ3P79YeKdno98qrVG5s8Yi6
 Y3HbEZGQiC3QS33gy/aTw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:w/pvqB/8ZjQ=:HM9Y+saKdz/Ra2pTCD68uI
 ez8gWpTbJGikKnT+7vjNu9KlZgCm57FRFctO5LdaDPs/nfVNYJNQpv7I48UW+xU1bdTTiCGSL
 mFjuUrBG0wfWKCNSuywhTdM6U8rNyteawBB0kUjCJCmYTfosBm1iXOEYa4ETxDLT6z557dg+g
 oLO6yuYuJNWtH6sytz0F9v1JvwrhodqorHtNdsqVeH8RHGTkjGP7krcBCsok9WFVttCRsX1mC
 gjaLi2849Qu9qm/F9H7yWcqfP4iW1axKXxS7q1E1zKAxPdfO+pT0H6xKae62ZvnFU6wCIQQb8
 bbEd9cgwOoH8fWDKWFdtAwEt1rwwW0RBGyOCtIhDiUpYvOSNOR/lh5mWAQDc42rndghO/ocLc
 hErANl15R+1R+4kNCIQOcSa4YGZbDXhd6Xb8ocWo53R3S0yINI9lHY6NZ8xId9Xum+2I8NK/C
 DlZj6hiZ9bWV6NP4w9b6XfqYLlNNuYNMGWG3t0U45GN36HGJAa6HoxfMm144/sflj/wYW7r3S
 TrFjNe451sLWiNeY1NzlJxUUf9TQMPcjPIjtjfUnPKDIT0xNxz9TE4snvpy0cDh7Fr863oKqd
 w9YmLnRJhTf2ldm3UMtodbPAcivqYyW2fje4RkW1HT2u8ipb2JzMJQSzdoku4KKysXxlBg46f
 A23w7eririCR+9cZllRIEIMUHtOHYAHIbGC+dVwjPBGLvV5mxeXYNDJXODUL4exuOiSPsTCyp
 8xG2F809Az1b8mmfrswFOqZofNtU0ZKWSMcR0hyWyuR9FWJjpEu+I7AIJnD/iIp8W1J4DUWNr
 dcIObRIUANNlFD5FFVkIzNXzCfFep8CNEMJEahXFxTZ3HOr7Fu0FO+zgCIx9Ho2YG9lyfT9ny
 iTsG2Rj0l1hzZUzZhrEA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No driver includes this any more, so don't expose it globally.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/mainstone.c                    | 2 +-
 arch/arm/mach-pxa/{include/mach => }/mainstone.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)
 rename arch/arm/mach-pxa/{include/mach => }/mainstone.h (99%)

diff --git a/arch/arm/mach-pxa/mainstone.c b/arch/arm/mach-pxa/mainstone.c
index 1b7882920164..ef79417ca001 100644
--- a/arch/arm/mach-pxa/mainstone.c
+++ b/arch/arm/mach-pxa/mainstone.c
@@ -45,7 +45,7 @@
 #include <asm/mach/flash.h>
 
 #include "pxa27x.h"
-#include <mach/mainstone.h>
+#include "mainstone.h"
 #include <mach/audio.h>
 #include <linux/platform_data/video-pxafb.h>
 #include <linux/platform_data/mmc-pxamci.h>
diff --git a/arch/arm/mach-pxa/include/mach/mainstone.h b/arch/arm/mach-pxa/mainstone.h
similarity index 99%
rename from arch/arm/mach-pxa/include/mach/mainstone.h
rename to arch/arm/mach-pxa/mainstone.h
index 1698f2ffd7c7..ba003742e003 100644
--- a/arch/arm/mach-pxa/include/mach/mainstone.h
+++ b/arch/arm/mach-pxa/mainstone.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- *  arch/arm/mach-pxa/include/mach/mainstone.h
- *
  *  Author:	Nicolas Pitre
  *  Created:	Nov 14, 2002
  *  Copyright:	MontaVista Software Inc.
-- 
2.20.0


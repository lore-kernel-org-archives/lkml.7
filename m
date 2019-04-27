Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE95C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B80A208C2
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfD0Mx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:53:29 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:33807 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfD0MxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:53:23 -0400
Received: from orion.localdomain ([77.2.90.210]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N49Yn-1gckUf0Xp3-0101lS; Sat, 27 Apr 2019 14:52:36 +0200
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
Subject: [PATCH 03/41] drivers: tty: serial: dz: fix missing parentheses
Date:   Sat, 27 Apr 2019 14:51:44 +0200
Message-Id: <1556369542-13247-4-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
References: <1556369542-13247-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:DCKi2YoTk5F832OQUdu63uCQyxtOturAok1rJyvr3Cj1aB4PytR
 39oykOLn/6maTSaugkdLtAO+JW6mtXKXNyEKmjf/LfUX+UrtldHzEn6VJRT6Ai5Wmv6fPJu
 zDbdAsnAWjMsVY/Lfxtu7H3H0VD9b6vzG1KkGY93toXvi1amjf/kUGN1jMaJH9MM+TdtJWy
 6Qq+l2SfPMMVa3xrX3Dhg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hCaJcuTMeuA=:EB4ux1IA7Tt2VnO5QHlgjW
 pkbxMpPw2nta4CmIKC1kcgXZ8R3PVqr7ziHZCtHeUGvHHk9Qk9raYRBGZaF5IqaPVm6CNMnxr
 9vty1/D38JGFJJSTwt3NFvurWC70JuBjH/BKAB8yESh6+wLopafjQqQPN8l2KX8SGQjfwv2xO
 TyzFvmsYNx3rtFuVJ/pJ1vV56+pzzVMgAzd7E0EpyYgb7DGVVlUR2LG1dxWjJ2Hof/It2Rmfz
 p9izFHquGUwtbxHeqxGGWvM4ijYINTbcCUZVJjV5oJC9/JYWT730WUlA9JIbF2xjIF7PBRVXX
 kASrSTWn7c2M2sc3c6bB50GRDqBH6dH94gztdOwsPoZ4cj+JQkPM6uX86/TUJ8e4WJY2B5iGU
 HP7+HVB4tQVuFWqAHT2uGAz6varlOIJ5yKrTIJx6feesH62tAViO17zmGulcYNIxOP3eNPMOD
 Hmet1YF6m/ZGilYNo9SR/pjTIMz1EyH8o7eL4CQcuBZ9FwhDFRYTxTY15EVLqHyCvQkPg27Rb
 8uO0aVYpOJ/qo2qK8zbTnZCXXNRXdpe5e3F/ivKBz+b1Oa+zghaMw2mbTc4DrgKSeZzP1LTNm
 teKvpXO2ByNWbSgSgXOBtzriQtZsC2TVemyVqTtaDrQpo+R6tvq8EoDpEQZIo8UeRCmxfnM7Q
 CuTeQ7zz0fUVVIk54pr5H16riYLFpjz7OQg7RqO6kuwjj9BxIwYM6AphowGhGxOWdsrYDcB8I
 YsZWUl7WRUQ4eG9segmrTeI0ta1XPj9nf9dvOw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch warning:

  ERROR: Macros with complex values should be enclosed in parentheses
  #912: FILE: dz.c:912:
  +#define SERIAL_DZ_CONSOLE	&dz_console

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/tty/serial/dz.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/dz.c b/drivers/tty/serial/dz.c
index fd4f0cc..b3e9313 100644
--- a/drivers/tty/serial/dz.c
+++ b/drivers/tty/serial/dz.c
@@ -909,7 +909,7 @@ static int __init dz_serial_console_init(void)
 
 console_initcall(dz_serial_console_init);
 
-#define SERIAL_DZ_CONSOLE	&dz_console
+#define SERIAL_DZ_CONSOLE	(&dz_console)
 #else
 #define SERIAL_DZ_CONSOLE	NULL
 #endif /* CONFIG_SERIAL_DZ_CONSOLE */
-- 
1.9.1


Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C63C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C75FD214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfJJUyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 16:54:17 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:52207 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfJJUyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 16:54:17 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MlbPO-1hrc9U25Ao-00ikbg; Thu, 10 Oct 2019 22:54:06 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 32/36] ARM: s3c: iotiming: make functions static
Date:   Thu, 10 Oct 2019 22:30:16 +0200
Message-Id: <20191010203043.1241612-32-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191010203043.1241612-1-arnd@arndb.de>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:IDS5D8xeFEIPLv2XemOLk8aPKE5MJCSpKyizbsrVtR1rHKSIuNe
 oynjcyJToRV7HM5CiPyhXXx1gd7MYwJwn56K7cVeMHR79p6X6uWBItLeKxev8cYtU71WSpw
 s/ZlpvkJ2LP0kSX5kpDArRN69d2ka/3HhaHoW27h0UwAaY69tdFbYNi9ER9FMUSzt2oiBpD
 ZKOUguObpd5wwtu3PGgqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k/Oy6Jsk1sg=:7GOrKqTzFA7deDNTAELnR/
 6/9HId5aBuVM4PYqRHAYiihb98KdHmGHyJC3v9UNx2WwRo9vm3dUowkB3zmVgHgpg0G52hGIT
 kr6JPlJsZaAhVVgH6P4ugppXKiOaVu34ed+iLLRQGFy8gNrWDulrqyHVEBBMw4oxWubhQOrAV
 RUP32EyglpJqkFFrTgIoDvlR75R2W2RB/3qtCXseHL6ca529w9E8piTNwihaka5Qn+lsk3eAg
 y27IkO9U+YRCG6OSMx5odus0LE6b9BhQi0kMdsZObJ35O/2hA4kJJWa9MFhvXFwbLxCDAgXpH
 iInpkBMP7e4DqP22TOTZPXbqVYPsY1di34or4KmNCaDTKtBnjPHJ3XlFyCv5JIuWgb/f329Ii
 sIfjtK4Y0+2p+/FLXk9c3kb2OU9eCL0kLDzkS0mPp7K6ox5tB21EF4mT2N4mqVt7rtPB2bP3V
 RbnI4hUzk6jO3qZqrcUPq3TNACaVyLeM9lIk63+AxRMBNnFFol3LHJYv881fF+R+6XY8uY/uv
 eZcKJ2M90vyJp0V+s+9hDIqfuT6wxTVMDHZLy/uRcmyF9QumuTIBsutsWCkb6ZkbnLKtSQvsc
 f/NTm29ar52ag5i0D01SRHB6D3alb0oRoqzmO3n0u+G9a03jbA7/qZQrOBiuUWlEw8is71u+h
 kbZmDiBmYRb9zX6mb3zm173iuXLwZykriIrNHWt0XhyZfeToVLBpN7CqGtsTQ4/i7XYWs+KpN
 9RruzEizeSRdMqyD3/rZ92yLN0cH/I0IUlyWOz00pvj0KLUymNuoD123UOvCW2447+pO3jdwL
 vcmRXm5xR0CnDfhFSpnlwP4yupCcSPV6thbk7DG8GZWmb2rU6YOBhW+qFn4sNvdIkZJH2eK9z
 Db4CdlgowBxAJ1/PZXBA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two functions in this file that are never called from
anywhere else, so they should be static to allow the compiler
to optimize it better and not pollute the global namespace.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-s3c24xx/iotiming-s3c2410.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/iotiming-s3c2410.c b/arch/arm/mach-s3c24xx/iotiming-s3c2410.c
index 5b3b16dd0ce8..5d85c259f328 100644
--- a/arch/arm/mach-s3c24xx/iotiming-s3c2410.c
+++ b/arch/arm/mach-s3c24xx/iotiming-s3c2410.c
@@ -129,7 +129,7 @@ static unsigned int calc_0124(unsigned int cyc, unsigned long hclk_tns,
 	return 0;
 }
 
-int calc_tacp(unsigned int cyc, unsigned long hclk, unsigned long *v)
+static int calc_tacp(unsigned int cyc, unsigned long hclk, unsigned long *v)
 {
 	/* Currently no support for Tacp calculations. */
 	return 0;
@@ -288,8 +288,8 @@ static unsigned int get_0124(unsigned long hclk_tns,
  * Given the BANKCON setting in @bt and the current frequency settings
  * in @cfg, update the cycle timing information.
  */
-void s3c2410_iotiming_getbank(struct s3c_cpufreq_config *cfg,
-			      struct s3c2410_iobank_timing *bt)
+static void s3c2410_iotiming_getbank(struct s3c_cpufreq_config *cfg,
+				     struct s3c2410_iobank_timing *bt)
 {
 	unsigned long bankcon = bt->bankcon;
 	unsigned long hclk = cfg->freq.hclk_tns;
-- 
2.20.0


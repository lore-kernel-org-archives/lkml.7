Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10188C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 20:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3570222C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 20:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfLKUp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 15:45:27 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:59995 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfLKUo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 15:44:27 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M8hR1-1iaRs43tkf-004kEW; Wed, 11 Dec 2019 21:44:06 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 01/24] compat: ARM64: always include asm-generic/compat.h
Date:   Wed, 11 Dec 2019 21:42:35 +0100
Message-Id: <20191211204306.1207817-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191211204306.1207817-1-arnd@arndb.de>
References: <20191211204306.1207817-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:mz5wMeP1mI7KLnX+L9TZUVo6MIfdhwfA5AkmOs+OaphdklUbCnv
 X7MrRZI2R9VJWf66NRTLnVoMD6/5RMLHE3sUWVfolxdjEhWoRD3hstmd5OvxofRbJrFFUNM
 U0inFOTcxWdr9e0WR63XsUOuZLnDnhZ1/cLHTwAuxz2imLLI2AkfpqGZDH2tXHJueqlDJrw
 WzwJOQaA0tpR0khCs2klQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5jcoHq9nJuQ=:BcHub+UBDAq7thiTpDno2w
 hSkCw8JTpuGlDJ57SmOUvV7vYHfSYEnIJSeWHWCp+bdDSoMCLrwMoJ7odEpI7WPtvB/ScsCvX
 VeNcQSKHIGcbiNr6/sqYv0LUIPEo7hppvFJSEtqOF37EVMjvgPUKUtF4HBXCpk0Qv2gnFmh91
 Q5AnpgUNMu7WOZYqE9pKT2CGY1GEijsATykSiXwT1JyYR87rhdQZcEhx1tuppOD1KC0MDCJK5
 x1wrBONVLyazD0Q/wnklpJPW2Mms4LzT3Ort5hQVmp/MItiaBcxs85dOHOFiDvuob622PfNOV
 PEDjts6WgUADfTCBpFPWOcw7WwWbSDqRM3PmRgqEGkxmu5bKOMfVqbq6n9+3N4dptgwE6fDOn
 /A4T6BKSblu+oPkGFGBZQjDyC1SMwpWBPHvrOdyPnIPMfIs5ULnIkxOJBty5xLKC0e0meDH9+
 b4tf89eeCRcctW9EV6YKAfobJs2SwCW83Tslrp46TVUCeQz4qUEPW3KwdgALLQ5tSZRT2r2hK
 Tbsc9JsabSWTA+wBNM/jL/actcRW5K9G+qn2EDyqMD4Xkf57Y0GRmBpmX+YUXOr5//J6q5O3P
 i8mzTH1iwJ78Ki3iKyPadTRxzutFG4fEZc9C9WpSjQSU9PGBW9Wdd+YaY565zaJFLYICgy/IG
 sYzvlRm9IEK780kxN1oEFgawAcIXTryC1iAO4mWE1E+146mOi7CPZOufM4oztTZtaRV0Q7HHr
 /LiW6o/Juxdn0noEDDvQ3Br5nYMzuo6xUUfowN5iAd8VF+A3ACDBsRdAgeWsRBDRdCwDTjHr2
 wDcgxTwXMlZAe8sjLiqZVYp2RC5Krc9DwXkwsg1nmKODL7eO+4vgb38hZWP/qBtq1KbRCaAit
 lAicoBqmZ4Snql/Awy/Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to use compat_* type defininitions in device drivers
outside of CONFIG_COMPAT, move the inclusion of asm-generic/compat.h
ahead of the #ifdef.

All other architectures already do this.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/include/asm/compat.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index b0d53a265f1d..7b4172ce497c 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -4,6 +4,9 @@
  */
 #ifndef __ASM_COMPAT_H
 #define __ASM_COMPAT_H
+
+#include <asm-generic/compat.h>
+
 #ifdef CONFIG_COMPAT
 
 /*
@@ -13,8 +16,6 @@
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
 
-#include <asm-generic/compat.h>
-
 #define COMPAT_USER_HZ		100
 #ifdef __AARCH64EB__
 #define COMPAT_UTS_MACHINE	"armv8b\0\0"
-- 
2.20.0


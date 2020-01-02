Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A07C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 14:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5031A20848
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 14:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbgABO4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 09:56:49 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:46391 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728544AbgABO4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 09:56:49 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MD9jV-1iw8he44g5-0095hC; Thu, 02 Jan 2020 15:56:36 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/22] compat: ARM64: always include asm-generic/compat.h
Date:   Thu,  2 Jan 2020 15:55:19 +0100
Message-Id: <20200102145552.1853992-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200102145552.1853992-1-arnd@arndb.de>
References: <20200102145552.1853992-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:pr65T4i4ui5sl6aC4/5W8ioQHxGj1wu7GIvRZlZ8gpRo78AYq44
 cTImIvZTqlh2VCXLOa9jmynpkvETB6vlBls9J0U8coLl8xzrhJlZ+D3JvBCSnnmpAs27CVB
 mE48d68xq4PKsEwnNPlDYFMRBTBLJN7XdP/RMNsrRuWGfk2eEZMjO8Eq6Gzwbr8dWDgt77D
 OvfzOaKUXSLJInQPDBPTA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:p32MzLkRC7s=:Kgp26Bnq7sxJGSCTcjlzhh
 /wMW7eDh3Qu9/ZQ58XNLyUlvH5S9fJOvSyKT/8UvYXhuW92wCj7ggT5BVBzVOHdTq9FjuAXCE
 1HC8lwfXFUNLhDULu7FyVD4bwEQG56ssAwOq8bEPWBIbIXUlPzcfWqjcZHs1KUvitMsMJ4wEh
 SmAvPfxpwKSNnAYorv+884U+R1IHDJgI5z/d/xfUqbb+8e2FvZcv11QhstK4HUt6TJF+7yibf
 d0WtBnyy3uqy8QtX2dU4nHOr27JpPOYmXmF/vqYPqi9pLVbsrUrKNdTIW9PouWw9Ph+C23/xv
 69KiLOByQtmB79mk+d7mjo36fRE8DrguSa9QbO6wvZ+5cMiBYlblh1NFSPTOBWM0xsYcuwn8C
 0nKEf6X6Pg4TuOJu+eejTorzLGNqXXBlgiYc2+fGw4hQUp/BcdDly3F4T33+5iNiPlNeC1Vil
 tNnkRIK5Fxln+mdkNQJU3w4E1mHeaWKq17vUC8qV/b4HgtdIvNAo63eI9UjVUS2VLw54UlEAL
 CpRhfAwEau2vNqXyXesLtyzCKBGXZDhst6T14RDdjq2LPZC3w5d3CTwutGCQklNb1DGZoKrxc
 CAC2UTwBJ7dHBRfJceFTwDUekb+xTnZu1loUs/boghikwqfhKpilW6B88ZH0YjXVuyuqzruAQ
 QXQiFeuDLjoTBfAnL2qJBeqq5xmTGx4LL8HUjkim2DlwYqkV/hm5VZgFvzLRxyz3HQ1iVDNb6
 n3wI5YqhddSrXYm/E0tJmx6gExd7Mvucg9iD7b/3fxZwNemtwpFhurufR5iW4VPWVvdXFkKJJ
 9OIR3cuAtGAlspgdhizLoaeSERk4+1Jh8RPoM8ihV/bMSmJeawuHxZIaqTEEEMGuzqLZ4MGe/
 UBr5wHWCiye5ccxLXdmQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to use compat_* type defininitions in device drivers
outside of CONFIG_COMPAT, move the inclusion of asm-generic/compat.h
ahead of the #ifdef.

All other architectures already do this.

Acked-by: Will Deacon <will@kernel.org>
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


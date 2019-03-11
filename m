Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C91C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C0992087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfCKNUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:20:15 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:47357 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbfCKNTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:41 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M1HmG-1h4zna10w6-002o1h for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:40 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 095/114] arch: ia64: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:47 +0100
Message-Id: <1552310346-7629-96-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:yZbvvG0ZcjMBkJf0Mo+70LJzs6q0iRsSvoe+iTVuqzzwkockhjy
 oLb7m+AUafpPR5AFUCtW42+oXpDwC43CvVYIIdw7hJvHjy0CZaHf0oXGK7uf+eO+KtjTriy
 p9vrq7z5YwLyUevFtUGBj3Z/4A95w5WhAzMdBfNlo0leHKUlQSSRI2E7KpqmBrfacgcAPom
 87rtYGA3jrfnFEyscI6Og==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yYIb6jiPsss=:4bkHFi7BrVX0Vf9kAQurpc
 eswo4NGgE/vOs96BCWgayP3wAynVkOT36Tbwu8YSZQtkRZ4XwC1D1gf8fZWHzX9Qvwt5ak67R
 2dBUDlDxFDgH3sJyrYZAfR7ypaaVk6HNnG4WEPCBsUe2uX17SK6vSpmvhKl30+WPxUyPdJ1VY
 svDeGYwWE9a7FkT9zNWqsUG2Lor8r8qouOCwln8JKmu1nxnXiFWJZOh6qv1zgnlaNoa5S0Zek
 kDtmvFVnRjWMBfaY+yIVhi26XybF3eBERer3TbyRvHGCOHvvHfms+xLTxuXsdTgzYV9U5t9Z8
 0IbfMq2JCO34Vw805vfhYruIkHy2nNonVRwEu4iEW+W1jP0RKqF4w/iKWDp9+S9ohTBf8RYmt
 D+z4GJ9nux2C+tJ/V7owSobxEbFfVQxKxOuN8c8AFYXYlRckyCVN6i6/7Ang2evuLc9iiCuAM
 fwwqlf+0FgBdOhIyzKcVeUY5oi6zeafOO38EZEKYmudf+7kMRuD2sl/re7N5Ot0SJKeuUeRmi
 8hjVj/00KZP4LpshCRqKGMI9qDxGE/DTjQDB3LbzYJGLRTgaz7Wa4Ia1+Zyw+hnIkIBuiHe0B
 7s6IyJ6azrVF6jhFD5dy/bqI4VhGHhxV9lk8XG9PDum3baxDdNjIX9RIC+5Na2rldrVh6Jxv2
 7XGERj9kkyIoWTqgx4Fpd4Y/Wv74fiSELw6pjAwMsCaf/gq9mWFlXnA2aHdTAZvcrnGffkTGI
 tY97uV3qZzPHiWl3njcPSpI5dSlQlH3ogCzQfQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 arch/ia64/Kconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 8d7396b..ab43a52 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -353,7 +353,7 @@ config PERMIT_BSP_REMOVE
 	default n
 	---help---
 	Say Y here if your platform SAL will support removal of BSP with HOTPLUG_CPU
-	support. 
+	support.
 
 config FORCE_CPEI_RETARGET
 	bool "Force assumption that CPEI can be re-targeted"
@@ -470,7 +470,7 @@ config IA64_PALINFO
 config IA64_MC_ERR_INJECT
 	tristate "MC error injection support"
 	help
-	  Adds support for MC error injection. If enabled, the kernel 
+	  Adds support for MC error injection. If enabled, the kernel
 	  will provide a sysfs interface for user applications to
 	  call MC error injection PAL procedures to inject various errors.
 	  This is a useful tool for MCA testing.
@@ -519,10 +519,10 @@ config KEXEC
 	  made.
 
 config CRASH_DUMP
-	  bool "kernel crash dumps"
-	  depends on IA64_MCA_RECOVERY && !IA64_HP_SIM && (!SMP || HOTPLUG_CPU)
-	  help
-	    Generate crash dump after being started by kexec.
+	bool "kernel crash dumps"
+	depends on IA64_MCA_RECOVERY && !IA64_HP_SIM && (!SMP || HOTPLUG_CPU)
+	help
+	  Generate crash dump after being started by kexec.
 
 source "drivers/firmware/Kconfig"
 
-- 
1.9.1


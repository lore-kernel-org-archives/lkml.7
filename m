Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC11C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 383172084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbfCKNXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:23:51 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:54277 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727647AbfCKNTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:41 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MNKuK-1hQwVC0UzS-00Or9l for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:40 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 094/114] arch: nds32: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:46 +0100
Message-Id: <1552310346-7629-95-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:63gDKIIvixtwmcIAp6PAt0Inw+VXPLQnyqe341iL6UkKqlnpWlI
 k5Zlx/fsaSPflNLleiXY9g3LI7wSURBoS2M2WtUMdDX83KvtP8gFVsc4jKJ2ynhE1piN6qZ
 pDzXpi1d1hJztDvseeJznttBI377Vmrnlt2dMCDHeeCGgZ1XC6V9eKEQFxwzupp9K90+q0e
 7lx+kPPmQhO4j50K262Qw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:THHVSl57rvA=:RZ7EmG4nAVJuPLsT4APMcW
 b4O9e4FeV9qibYHZRwJ5cw2QNhUq6qAiaxvkKjIGMGppKth6vWKzIgjm9ZFBZkH5Re9rtRw4y
 UrYqIfNqW0eCkg9xjcmBkMKeNz72MKmWRX9sfTBFHt18R4M41JDg4XNly+FTAkJ4gfTWn2kjC
 emqYrfRHzDBzjO1CPyPCLYSEqO8FGCLzsFqjgVeYhq6gJmbpOwMah/BRQgVixaC66vt7gvfWm
 yr64g61TVV+88W9OG79hPuGFGoUS+x3ZbzGgaRpPn6pKUK2TNnMr3aqeU52DNs5hB7SDQOJ7R
 wz3RdRcDHssliZ7nPuHkw9e5zxLcCg1kyj2WFO2ITRuByVML+edtpWd+c0arwbvRhHY91tS/0
 ir7oUQ6NgYdC1ACFkJ2RMwYXTUeML7zz5DNTLyuDjdYFAUvBatpREAr5v1LG+g4/TYk+5wdT1
 /j/q8TvZOxX2q8me5O8FaWeLBMS384gwLu/6jMnvblPa5xjvYYbjU0lv3uvUaaApDvkbFjsTN
 6qW2xPpKUyZZQFt+IppxVYV+HjWtWV+8zf0I/I3MoqqiCWAu4L2DNgeAiykmAGKJf/a7eDbWT
 MHYu573yxmzhB9ATuH8RVQJtYvFMKiWM/URgTH/uyxRM01ivrG9eXEAV/t8l2OosuXZvpRozP
 R6LfPG+DeWoVx/9FVPt6IFn5fAkmGMhEKUvHQ++P8Nz4AiUuCjmu2fMh59wAqiX7FSumJmlOn
 WDCt9HRMzGmsetq/3fV+IP5D+S8fU5fP+LOynQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 arch/nds32/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
index addb7f5..c0b13bf 100644
--- a/arch/nds32/Kconfig
+++ b/arch/nds32/Kconfig
@@ -4,7 +4,7 @@
 #
 
 config NDS32
-        def_bool y
+	def_bool y
 	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
@@ -51,13 +51,13 @@ config GENERIC_CALIBRATE_DELAY
 	def_bool y
 
 config GENERIC_CSUM
-        def_bool y
+	def_bool y
 
 config GENERIC_HWEIGHT
-        def_bool y
+	def_bool y
 
 config GENERIC_LOCKBREAK
-        def_bool y
+	def_bool y
 	depends on PREEMPT
 
 config RWSEM_GENERIC_SPINLOCK
@@ -67,7 +67,7 @@ config TRACE_IRQFLAGS_SUPPORT
 	def_bool y
 
 config STACKTRACE_SUPPORT
-        def_bool y
+	def_bool y
 
 config FIX_EARLYCON_MEM
 	def_bool y
@@ -82,11 +82,11 @@ config NR_CPUS
 	default 1
 
 config MMU
-        def_bool y
+	def_bool y
 
 config NDS32_BUILTIN_DTB
-        string "Builtin DTB"
-        default ""
+	string "Builtin DTB"
+	default ""
 	help
 	  User can use it to specify the dts of the SoC
 endmenu
-- 
1.9.1


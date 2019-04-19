Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299A2C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E46C42064A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="EKpAOyCO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbfDSTEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:04:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42949 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728909AbfDSTEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:04:08 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3JAaxx8235158
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 19 Apr 2019 03:36:59 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3JAaxx8235158
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555670219;
        bh=ej39wruWdfkhUuefr9kqIW0UVaOCQln4+W6loEQCo1M=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=EKpAOyCOVtmwZ2pFsGW8aGdz/cpZPqffekq7/Q6rh7xCa0m3AKC5gtvt/9Gicy8J2
         j6evgDcu/RrjJN+rKqYRR5pYeK4FOVf/gAd8uVkQ4RWNrp0V/VTjatiYqyYFcR+Jvf
         EcbVhdX2BQrcGFvbQ5zFYPiLGogMs6xCFmnwy0iBTLYJ5QAJ9dIYJGqQnIYafPT9/l
         gKNKKRrYhsKbG830VfHG6K3kYHce4lQOzocJCQ7ZH3zl0yj+phD4N+w+rkC4on/Ax3
         dztSfw6vJ0Njg3Xvqz57dztW4rNKkuJC3T4CxlwFE6FDRytGwMTqUPlbyXO5SJK2Dv
         pvn1zrA5pG+LQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3JAaw5N235155;
        Fri, 19 Apr 2019 03:36:58 -0700
Date:   Fri, 19 Apr 2019 03:36:58 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Ahmed S. Darwish" <tipbot@zytor.com>
Message-ID: <tip-93ddedaa5c9cb828d39a19b5d6e7e1939393085a@git.kernel.org>
Cc:     mingo@kernel.org, darwish.07@gmail.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, peterz@infradead.org,
        tglx@linutronix.de, torvalds@linux-foundation.org, bp@alien8.de
Reply-To: torvalds@linux-foundation.org, bp@alien8.de,
          peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
          darwish.07@gmail.com, linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <20190306004425.GA30537@darwi-home-pc>
References: <20190306004425.GA30537@darwi-home-pc>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/build] x86/defconfig: Remove archaic partition tables
 support
Git-Commit-ID: 93ddedaa5c9cb828d39a19b5d6e7e1939393085a
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  93ddedaa5c9cb828d39a19b5d6e7e1939393085a
Gitweb:     https://git.kernel.org/tip/93ddedaa5c9cb828d39a19b5d6e7e1939393085a
Author:     Ahmed S. Darwish <darwish.07@gmail.com>
AuthorDate: Wed, 6 Mar 2019 01:44:25 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 19 Apr 2019 12:29:48 +0200

x86/defconfig: Remove archaic partition tables support

On x86 systems, only MSDOS and GPT partition tables are typically
encountered. Remove all the rest.

Note, CONFIG_EFI_PARTITION is also removed since it defaults to `y'.

Signed-off-by: Ahmed S. Darwish <darwish.07@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20190306004425.GA30537@darwi-home-pc
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/configs/i386_defconfig   | 12 ------------
 arch/x86/configs/x86_64_defconfig | 12 ------------
 2 files changed, 24 deletions(-)

diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index 9f908112bbb9..2b2481acc661 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -25,18 +25,6 @@ CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_OSF_PARTITION=y
-CONFIG_AMIGA_PARTITION=y
-CONFIG_MAC_PARTITION=y
-CONFIG_BSD_DISKLABEL=y
-CONFIG_MINIX_SUBPARTITION=y
-CONFIG_SOLARIS_X86_PARTITION=y
-CONFIG_UNIXWARE_DISKLABEL=y
-CONFIG_SGI_PARTITION=y
-CONFIG_SUN_PARTITION=y
-CONFIG_KARMA_PARTITION=y
-CONFIG_EFI_PARTITION=y
 CONFIG_SMP=y
 CONFIG_X86_GENERIC=y
 CONFIG_HPET_TIMER=y
diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
index 1d3badfda09e..e8829abf063a 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -24,18 +24,6 @@ CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_OSF_PARTITION=y
-CONFIG_AMIGA_PARTITION=y
-CONFIG_MAC_PARTITION=y
-CONFIG_BSD_DISKLABEL=y
-CONFIG_MINIX_SUBPARTITION=y
-CONFIG_SOLARIS_X86_PARTITION=y
-CONFIG_UNIXWARE_DISKLABEL=y
-CONFIG_SGI_PARTITION=y
-CONFIG_SUN_PARTITION=y
-CONFIG_KARMA_PARTITION=y
-CONFIG_EFI_PARTITION=y
 CONFIG_SMP=y
 CONFIG_CALGARY_IOMMU=y
 CONFIG_NR_CPUS=64

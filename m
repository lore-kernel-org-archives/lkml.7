Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6A3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D214F2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730722AbfCZH3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 03:29:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52649 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfCZH3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 03:29:15 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2Q7ShIX2287211
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 26 Mar 2019 00:28:43 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2Q7Sbcj2287204;
        Tue, 26 Mar 2019 00:28:37 -0700
Date:   Tue, 26 Mar 2019 00:28:37 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tony Luck <tipbot@zytor.com>
Message-ID: <tip-1762058319f1cf34b11fc6b82678828ecc88c8ee@git.kernel.org>
Cc:     nicolas.ferre@microchip.com, tony.luck@intel.com,
        tglx@linutronix.de, davem@davemloft.net, joe@perches.com,
        hpa@linux.intel.com, gregkh@linuxfoundation.org, mingo@kernel.org,
        mchehab+samsung@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, bp@suse.de, hpa@zytor.com
Reply-To: hpa@linux.intel.com, joe@perches.com, tglx@linutronix.de,
          davem@davemloft.net, nicolas.ferre@microchip.com,
          tony.luck@intel.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
          bp@suse.de, gregkh@linuxfoundation.org,
          mchehab+samsung@kernel.org, mingo@kernel.org,
          linux-edac@vger.kernel.org
In-Reply-To: <20190325233416.GB8869@agluck-desk>
References: <20190325233416.GB8869@agluck-desk>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] MAINTAINERS: Fix file pattern for X86 MCE
 INFRASTRUCTURE
Git-Commit-ID: 1762058319f1cf34b11fc6b82678828ecc88c8ee
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

Commit-ID:  1762058319f1cf34b11fc6b82678828ecc88c8ee
Gitweb:     https://git.kernel.org/tip/1762058319f1cf34b11fc6b82678828ecc88c8ee
Author:     Tony Luck <tony.luck@intel.com>
AuthorDate: Mon, 25 Mar 2019 16:34:17 -0700
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Tue, 26 Mar 2019 08:23:53 +0100

MAINTAINERS: Fix file pattern for X86 MCE INFRASTRUCTURE

Code restructuring renamed arch/x86/kernel/cpu/mcheck/ to
be arch/x86/kernel/cpu/mce/

Update the MAINTAINERS file pattern to account for this change.

Fixes: 21afaf181362 ("x86/mce: Streamline MCE subsystem's naming")
Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: "H. Peter Anvin" <hpa@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-edac <linux-edac@vger.kernel.org>
Link: https://lkml.kernel.org/r/20190325233416.GB8869@agluck-desk
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e17ebf70b548..58acbc246adc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16910,7 +16910,7 @@ M:	Tony Luck <tony.luck@intel.com>
 M:	Borislav Petkov <bp@alien8.de>
 L:	linux-edac@vger.kernel.org
 S:	Maintained
-F:	arch/x86/kernel/cpu/mcheck/*
+F:	arch/x86/kernel/cpu/mce/*
 
 X86 MICROCODE UPDATE SUPPORT
 M:	Borislav Petkov <bp@alien8.de>

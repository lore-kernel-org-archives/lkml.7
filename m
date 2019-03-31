Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07403C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 10:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE4D2183F
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 10:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfCaKmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 06:42:21 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57210 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfCaKmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 06:42:21 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hAXut-0005Xt-B0; Sun, 31 Mar 2019 12:42:19 +0200
Date:   Sun, 31 Mar 2019 10:39:43 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] locking updates for 5.1
References: <155402878327.25983.10899882979692424898.tglx@nanos.tec.linutronix.de>
Message-ID: <155402878327.25983.1164070553362328875.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest locking-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-for-linus

up to:  93a64ee71d10 ("MAINTAINERS: Remove deleted file from futex file pattern")

Trivial update to the maintainers file.

Thanks,

	tglx

------------------>
Thomas Gleixner (1):
      MAINTAINERS: Remove deleted file from futex file pattern


 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e5a5d263f29..f015ff786109 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6408,7 +6408,6 @@ L:	linux-kernel@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
 S:	Maintained
 F:	kernel/futex.c
-F:	kernel/futex_compat.c
 F:	include/asm-generic/futex.h
 F:	include/linux/futex.h
 F:	include/uapi/linux/futex.h


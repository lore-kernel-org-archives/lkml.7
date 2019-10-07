Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1260DC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E521821479
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbfJGOur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 10:50:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44498 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbfJGOtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 10:49:42 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iHUKL-0006AQ-1P; Mon, 07 Oct 2019 16:49:33 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id AB2251C0895;
        Mon,  7 Oct 2019 16:49:31 +0200 (CEST)
Date:   Mon, 07 Oct 2019 14:49:31 -0000
From:   "tip-bot2 for Mike Travis" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Decode UVsystab Info
Cc:     Mike Travis <mike.travis@hpe.com>, Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Hedi Berriche <hedi.berriche@hpe.com>,
        Justin Ernst <justin.ernst@hpe.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Russ Anderson <russ.anderson@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20190910145840.135325066@stormcage.eag.rdlabs.hpecorp.net>
References: <20190910145840.135325066@stormcage.eag.rdlabs.hpecorp.net>
MIME-Version: 1.0
Message-ID: <157045977163.9978.17546530141291039371.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     f5a8f0ecb436a15f50215f27ab70a2e8626a6135
Gitweb:        https://git.kernel.org/tip/f5a8f0ecb436a15f50215f27ab70a2e8626a6135
Author:        Mike Travis <mike.travis@hpe.com>
AuthorDate:    Tue, 10 Sep 2019 09:58:45 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 07 Oct 2019 13:42:11 +02:00

x86/platform/uv: Decode UVsystab Info

Decode the hubless UVsystab passed from BIOS to the kernel saving
pertinent info in a similar manner that hubbed UVsystabs are decoded.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Hedi Berriche <hedi.berriche@hpe.com>
Cc: Justin Ernst <justin.ernst@hpe.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Russ Anderson <russ.anderson@hpe.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190910145840.135325066@stormcage.eag.rdlabs.hpecorp.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index b505905..ec940ad 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -1303,7 +1303,8 @@ static int __init decode_uv_systab(void)
 	struct uv_systab *st;
 	int i;
 
-	if (uv_hub_info->hub_revision < UV4_HUB_REVISION_BASE)
+	/* If system is uv3 or lower, there is no extended UVsystab */
+	if (is_uv_hubbed(0xfffffe) < uv(4) && is_uv_hubless(0xfffffe) < uv(4))
 		return 0;	/* No extended UVsystab required */
 
 	st = uv_systab;
@@ -1554,8 +1555,15 @@ static __init int uv_system_init_hubless(void)
 
 	/* Init kernel/BIOS interface */
 	rc = uv_bios_init();
+	if (rc < 0)
+		return rc;
 
-	/* Create user access node if UVsystab available */
+	/* Process UVsystab */
+	rc = decode_uv_systab();
+	if (rc < 0)
+		return rc;
+
+	/* Create user access node */
 	if (rc >= 0)
 		uv_setup_proc_files(1);
 

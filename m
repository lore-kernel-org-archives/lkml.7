Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90FEECE58D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B79C121721
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbfJGOvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 10:51:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44461 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728546AbfJGOtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 10:49:39 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iHUKJ-0006AK-TQ; Mon, 07 Oct 2019 16:49:32 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8D16A1C079B;
        Mon,  7 Oct 2019 16:49:31 +0200 (CEST)
Date:   Mon, 07 Oct 2019 14:49:31 -0000
From:   "tip-bot2 for Mike Travis" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Check EFI Boot to set reboot type
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
In-Reply-To: <20190910145840.215091717@stormcage.eag.rdlabs.hpecorp.net>
References: <20190910145840.215091717@stormcage.eag.rdlabs.hpecorp.net>
MIME-Version: 1.0
Message-ID: <157045977153.9978.11327097635396647421.tip-bot2@tip-bot2>
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

Commit-ID:     df55029f7ea65d8c653a79dd728918dfe25b1356
Gitweb:        https://git.kernel.org/tip/df55029f7ea65d8c653a79dd728918dfe25b1356
Author:        Mike Travis <mike.travis@hpe.com>
AuthorDate:    Tue, 10 Sep 2019 09:58:46 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 07 Oct 2019 13:42:11 +02:00

x86/platform/uv: Check EFI Boot to set reboot type

Change to checking for EFI Boot type from previous check on if this
is a KDUMP kernel.  This allows for KDUMP kernels that can handle
EFI reboots.

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
Link: https://lkml.kernel.org/r/20190910145840.215091717@stormcage.eag.rdlabs.hpecorp.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index ec940ad..d5b51a7 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -15,6 +15,7 @@
 #include <linux/export.h>
 #include <linux/pci.h>
 #include <linux/acpi.h>
+#include <linux/efi.h>
 
 #include <asm/e820/api.h>
 #include <asm/uv/uv_mmrs.h>
@@ -1483,6 +1484,14 @@ static void __init build_socket_tables(void)
 	}
 }
 
+/* Check which reboot to use */
+static void check_efi_reboot(void)
+{
+	/* If EFI reboot not available, use ACPI reboot */
+	if (!efi_enabled(EFI_BOOT))
+		reboot_type = BOOT_ACPI;
+}
+
 /* Setup user proc fs files */
 static int proc_hubbed_show(struct seq_file *file, void *data)
 {
@@ -1567,6 +1576,8 @@ static __init int uv_system_init_hubless(void)
 	if (rc >= 0)
 		uv_setup_proc_files(1);
 
+	check_efi_reboot();
+
 	return rc;
 }
 
@@ -1700,12 +1711,7 @@ static void __init uv_system_init_hub(void)
 	/* Register Legacy VGA I/O redirection handler: */
 	pci_register_set_vga_state(uv_set_vga_state);
 
-	/*
-	 * For a kdump kernel the reset must be BOOT_ACPI, not BOOT_EFI, as
-	 * EFI is not enabled in the kdump kernel:
-	 */
-	if (is_kdump_kernel())
-		reboot_type = BOOT_ACPI;
+	check_efi_reboot();
 }
 
 /*

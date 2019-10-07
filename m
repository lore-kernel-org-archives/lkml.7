Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFF6ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 726B921479
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbfJGOtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 10:49:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44487 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728603AbfJGOtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 10:49:42 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iHUKN-0006AS-5S; Mon, 07 Oct 2019 16:49:35 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C6FD91C08B0;
        Mon,  7 Oct 2019 16:49:31 +0200 (CEST)
Date:   Mon, 07 Oct 2019 14:49:31 -0000
From:   "tip-bot2 for Mike Travis" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Add UV Hubbed/Hubless Proc FS Files
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
In-Reply-To: <20190910145840.055590900@stormcage.eag.rdlabs.hpecorp.net>
References: <20190910145840.055590900@stormcage.eag.rdlabs.hpecorp.net>
MIME-Version: 1.0
Message-ID: <157045977175.9978.7357984896554313600.tip-bot2@tip-bot2>
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

Commit-ID:     8785968bce1cc7368ea95c3e1e5b9210f56f6667
Gitweb:        https://git.kernel.org/tip/8785968bce1cc7368ea95c3e1e5b9210f56f6667
Author:        Mike Travis <mike.travis@hpe.com>
AuthorDate:    Tue, 10 Sep 2019 09:58:44 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 07 Oct 2019 13:42:10 +02:00

x86/platform/uv: Add UV Hubbed/Hubless Proc FS Files

Indicate to UV user utilities that UV hubless support is available on
this system via the existing /proc infterface.  The current interface is
maintained with the addition of new /proc leaves ("hubbed", "hubless",
and "oemid") that contain the specific type of UV arch this one is.

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
Link: https://lkml.kernel.org/r/20190910145840.055590900@stormcage.eag.rdlabs.hpecorp.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/uv/uv.h       |  4 +-
 arch/x86/kernel/apic/x2apic_uv_x.c | 93 ++++++++++++++++++++++++++++-
 2 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/uv/uv.h b/arch/x86/include/asm/uv/uv.h
index 792faab..45ea95c 100644
--- a/arch/x86/include/asm/uv/uv.h
+++ b/arch/x86/include/asm/uv/uv.h
@@ -12,6 +12,8 @@ struct mm_struct;
 #ifdef CONFIG_X86_UV
 #include <linux/efi.h>
 
+#define	UV_PROC_NODE	"sgi_uv"
+
 static inline int uv(int uvtype)
 {
 	/* uv(0) is "any" */
@@ -28,6 +30,7 @@ static inline bool is_early_uv_system(void)
 	return uv_systab_phys && uv_systab_phys != EFI_INVALID_TABLE_ADDR;
 }
 extern int is_uv_system(void);
+extern int is_uv_hubbed(int uvtype);
 extern int is_uv_hubless(int uvtype);
 extern void uv_cpu_init(void);
 extern void uv_nmi_init(void);
@@ -40,6 +43,7 @@ extern const struct cpumask *uv_flush_tlb_others(const struct cpumask *cpumask,
 static inline enum uv_system_type get_uv_system_type(void) { return UV_NONE; }
 static inline bool is_early_uv_system(void)	{ return 0; }
 static inline int is_uv_system(void)	{ return 0; }
+static inline int is_uv_hubbed(int uv)	{ return 0; }
 static inline int is_uv_hubless(int uv) { return 0; }
 static inline void uv_cpu_init(void)	{ }
 static inline void uv_system_init(void)	{ }
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 14554a3..b505905 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -26,6 +26,7 @@
 static DEFINE_PER_CPU(int, x2apic_extra_bits);
 
 static enum uv_system_type	uv_system_type;
+static int			uv_hubbed_system;
 static int			uv_hubless_system;
 static u64			gru_start_paddr, gru_end_paddr;
 static u64			gru_dist_base, gru_first_node_paddr = -1LL, gru_last_node_paddr;
@@ -309,6 +310,24 @@ static int __init uv_acpi_madt_oem_check(char *_oem_id, char *_oem_table_id)
 	if (uv_hub_info->hub_revision == 0)
 		goto badbios;
 
+	switch (uv_hub_info->hub_revision) {
+	case UV4_HUB_REVISION_BASE:
+		uv_hubbed_system = 0x11;
+		break;
+
+	case UV3_HUB_REVISION_BASE:
+		uv_hubbed_system = 0x9;
+		break;
+
+	case UV2_HUB_REVISION_BASE:
+		uv_hubbed_system = 0x5;
+		break;
+
+	case UV1_HUB_REVISION_BASE:
+		uv_hubbed_system = 0x3;
+		break;
+	}
+
 	pnodeid = early_get_pnodeid();
 	early_get_apic_socketid_shift();
 
@@ -359,6 +378,12 @@ int is_uv_system(void)
 }
 EXPORT_SYMBOL_GPL(is_uv_system);
 
+int is_uv_hubbed(int uvtype)
+{
+	return (uv_hubbed_system & uvtype);
+}
+EXPORT_SYMBOL_GPL(is_uv_hubbed);
+
 int is_uv_hubless(int uvtype)
 {
 	return (uv_hubless_system & uvtype);
@@ -1457,6 +1482,68 @@ static void __init build_socket_tables(void)
 	}
 }
 
+/* Setup user proc fs files */
+static int proc_hubbed_show(struct seq_file *file, void *data)
+{
+	seq_printf(file, "0x%x\n", uv_hubbed_system);
+	return 0;
+}
+
+static int proc_hubless_show(struct seq_file *file, void *data)
+{
+	seq_printf(file, "0x%x\n", uv_hubless_system);
+	return 0;
+}
+
+static int proc_oemid_show(struct seq_file *file, void *data)
+{
+	seq_printf(file, "%s/%s\n", oem_id, oem_table_id);
+	return 0;
+}
+
+static int proc_hubbed_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, proc_hubbed_show, (void *)NULL);
+}
+
+static int proc_hubless_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, proc_hubless_show, (void *)NULL);
+}
+
+static int proc_oemid_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, proc_oemid_show, (void *)NULL);
+}
+
+/* (struct is "non-const" as open function is set at runtime) */
+static struct file_operations proc_version_fops = {
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static const struct file_operations proc_oemid_fops = {
+	.open		= proc_oemid_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static __init void uv_setup_proc_files(int hubless)
+{
+	struct proc_dir_entry *pde;
+	char *name = hubless ? "hubless" : "hubbed";
+
+	pde = proc_mkdir(UV_PROC_NODE, NULL);
+	proc_create("oemid", 0, pde, &proc_oemid_fops);
+	proc_create(name, 0, pde, &proc_version_fops);
+	if (hubless)
+		proc_version_fops.open = proc_hubless_open;
+	else
+		proc_version_fops.open = proc_hubbed_open;
+}
+
 /* Initialize UV hubless systems */
 static __init int uv_system_init_hubless(void)
 {
@@ -1468,6 +1555,10 @@ static __init int uv_system_init_hubless(void)
 	/* Init kernel/BIOS interface */
 	rc = uv_bios_init();
 
+	/* Create user access node if UVsystab available */
+	if (rc >= 0)
+		uv_setup_proc_files(1);
+
 	return rc;
 }
 
@@ -1596,7 +1687,7 @@ static void __init uv_system_init_hub(void)
 	uv_nmi_setup();
 	uv_cpu_init();
 	uv_scir_register_cpu_notifier();
-	proc_mkdir("sgi_uv", NULL);
+	uv_setup_proc_files(0);
 
 	/* Register Legacy VGA I/O redirection handler: */
 	pci_register_set_vga_state(uv_set_vga_state);

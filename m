Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEEEC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1384B21655
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbfLLOEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:04:49 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:58067 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729547AbfLLOEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 09:04:48 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MnWx3-1hyxRR0wyr-00jZT4; Thu, 12 Dec 2019 15:04:20 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Mike Travis <mike.travis@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Hedi Berriche <hedi.berriche@hpe.com>,
        Justin Ernst <justin.ernst@hpe.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Russ Anderson <russ.anderson@hpe.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/platform/uv: avoid unused variable warning
Date:   Thu, 12 Dec 2019 15:03:57 +0100
Message-Id: <20191212140419.315264-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xM0uqZr408u8v1eBM37k4OWvemqZEVo56Zeor5mvcWZmUqaGS/N
 rp7miPPJEEw2z2rhDcFr64f+PswFnItkjVLoEcoCy3Sf4YEaK8GSNGN4ft4AzaBCD/2TxKf
 uY6+hnmNRu+COxLEqhNjK3Yjhb29CvHiNcJURn1BynstdGNOqQgepnB2komWcqDaTD202tl
 cQxYRwh+VDrXjvyav5vEw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hjjuQndz3YI=:0OyZ9O/LRsulaDG9L2UeJj
 stMrjmFNMBbwVdmQeExisj9/9tcZyKfCumIPtU58wMWyQqCXLTNsmwnU+tGEGTMdrwFftwdj9
 DDan7ylswG1dr5a+N7cE7GEtYsPRnGDsbq1Px/8iYI4aVkC8dubuRXqebMuKF075Kl6sEe2ns
 s11pOmum7A8KHGzU+n96/pBOh3GrQy3oWAjutb9mg6XLiXnYSEDa6Eul8iKyaPbOC1skEfUE1
 Z6AUxEODiGqAw75xMsUi6Aoj3DGzsVts3WWbPRj1w5/xDIoGfstvBFybZ9uC80Md3R9quwowf
 Spen7aZTNJFBsrx/GeUP4wbQBLwaUT7mkWx8L7RfjV9MmvpOVFy6nIB4pE3gdxwFfapT+3Gbb
 2pUPucKb3E8FxJ9ZSaTpY6VC7JbdvIIo+p2fZ84Co6cNR5EbQqd2XFVzb42gUWWCrAZegjC8l
 4HQiWhXsa4YgUN0q6WIIWt+NoAWLgRIcRRspY5P7f/EbPoyLihChFYbviq4TfKsu2DZeRKYro
 duMC2mk6upVie3gix98IsJArP1dxwVZlmvDoJ/ZHDTQUTCqy2SuXatGNISgY9SsVFuEFHXS6L
 PbqD3e3ydiZ7aZ1upciX6NjUnVctIF7sY86+4P5nNUcrJALR3/8KcWmALFsuBno9Ivs4wncSa
 ui6Y3vTjpLesito4UpchfpX1L7qzrQlrv8t7/Rt/J+TzlWTt7BixApUFmcAol1jcbA4VeORKG
 RmC/FCnoR/Z+4HZjTJ7UGp/7UKoB+/Uji36bGiG30aWfyxL39s4QyuEEGS13UB+/PuA2Rev6/
 id2J8nhqZ1APdGBMlf6oNSUS9TpNO2hGd4+UxaWnfvbu1F4vDhMh6NQyW5ISdzEz3sx+Pl4Hw
 AFD0JvcIDyJYpqG1+eEg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_PROC_FS is disabled, the compiler warns about an
unused variable:

arch/x86/kernel/apic/x2apic_uv_x.c: In function 'uv_setup_proc_files':
arch/x86/kernel/apic/x2apic_uv_x.c:1546:8: error: unused variable 'name' [-Werror=unused-variable]
  char *name = hubless ? "hubless" : "hubbed";

Simplify the code so this variable is no longer needed.

Fixes: 8785968bce1c ("x86/platform/uv: Add UV Hubbed/Hubless Proc FS Files")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 43 +++++-------------------------
 1 file changed, 6 insertions(+), 37 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index d5b51a740524..ad53b2abc859 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -1493,65 +1493,34 @@ static void check_efi_reboot(void)
 }
 
 /* Setup user proc fs files */
-static int proc_hubbed_show(struct seq_file *file, void *data)
+static int __maybe_unused proc_hubbed_show(struct seq_file *file, void *data)
 {
 	seq_printf(file, "0x%x\n", uv_hubbed_system);
 	return 0;
 }
 
-static int proc_hubless_show(struct seq_file *file, void *data)
+static int __maybe_unused proc_hubless_show(struct seq_file *file, void *data)
 {
 	seq_printf(file, "0x%x\n", uv_hubless_system);
 	return 0;
 }
 
-static int proc_oemid_show(struct seq_file *file, void *data)
+static int __maybe_unused proc_oemid_show(struct seq_file *file, void *data)
 {
 	seq_printf(file, "%s/%s\n", oem_id, oem_table_id);
 	return 0;
 }
 
-static int proc_hubbed_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, proc_hubbed_show, (void *)NULL);
-}
-
-static int proc_hubless_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, proc_hubless_show, (void *)NULL);
-}
-
-static int proc_oemid_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, proc_oemid_show, (void *)NULL);
-}
-
-/* (struct is "non-const" as open function is set at runtime) */
-static struct file_operations proc_version_fops = {
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static const struct file_operations proc_oemid_fops = {
-	.open		= proc_oemid_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 static __init void uv_setup_proc_files(int hubless)
 {
 	struct proc_dir_entry *pde;
-	char *name = hubless ? "hubless" : "hubbed";
 
 	pde = proc_mkdir(UV_PROC_NODE, NULL);
-	proc_create("oemid", 0, pde, &proc_oemid_fops);
-	proc_create(name, 0, pde, &proc_version_fops);
+	proc_create_single("oemid", 0, pde, proc_oemid_show);
 	if (hubless)
-		proc_version_fops.open = proc_hubless_open;
+		proc_create_single("hubless", 0, pde, proc_hubless_show);
 	else
-		proc_version_fops.open = proc_hubbed_open;
+		proc_create_single("hubbed", 0, pde, proc_hubbed_show);
 }
 
 /* Initialize UV hubless systems */
-- 
2.20.0


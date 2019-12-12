Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CA7C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 13:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F3F22173E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 13:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbfLLN7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 08:59:09 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:55531 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729490AbfLLN7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 08:59:09 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MALql-1iYZEW3qlH-00BpfK; Thu, 12 Dec 2019 14:58:36 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Mike Travis <mike.travis@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Hedi Berriche <hedi.berriche@hpe.com>,
        Justin Ernst <justin.ernst@hpe.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Russ Anderson <russ.anderson@hpe.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/platform/uv: avoid unused variable warning
Date:   Thu, 12 Dec 2019 14:58:06 +0100
Message-Id: <20191212135815.4176658-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:aaEg7X+SOM/t1v0aZsqNDtlakHBANpTRGizRsksBk3TGrhYriNB
 3wOfkguPAQgypDQwEmBt07TCzY2lzwbWNYOq8fNOo4HATiPuaIvhZYYs6LWpYKbtzruvpHf
 m1JhHbkjFAp2HziQMa8MUTrwlPWeUgaQu7dgJxZz0bvkpSrkXFVyPCLjAHNHNt/qSBma/zk
 37MB7fPZc6+sAqh195YwA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EQpF1no2hr4=:/73Yd8PAeV8mYr0pW+v2IU
 +xvIV8dFjJvg6VjK0D3rBVSWNcG3IvofLytQRYTd4Bl9xYaXmnWoD/dp2kFg+UsgscVrk/+Yo
 rzopIwpEOjhsSNjKtCseP8GLYEDuA78QZhzRGvKIoNm9k3r5IM57grBQRSfIoGUAOT+AODARG
 xmZ2IwBP1oJGzx737IV9GUc3LBJmEb4AuWa/34Y+e75eahq1tXCng9fovEs3vtbDayQJ9dNEo
 cSnQhySuFHdOPZJ71dsVwYwbvw7d+tA9uQR+7hBLMV+v2RLhQHcbNsp+jg9d3qapFQPm1DuiL
 VfjxRr3Mp6hvhHMCecYzR/Dznp9qmDdd8FvRa6Kw5y4992/xKyE86KvafMJ8U/rDTtHzBPVmn
 sXsIMSqZMaGa8rwpUgruJyqGilt1dDwkIxVK++XEMAll76a5IWvkWuOPBwnALafpJJjUoqTWn
 m5RV1iM8bPd9KyCFH5hMZlrtzyM88SUiGm1DoxXzrSWDefrFllbwB6fG8NDCxJyHZ/bqm0S0A
 D7eO509ihHHhplu2HEoca26J4OyYZeXi66p00YScPUO9FW/5G6yNdUVD5uTdwATuE/mBVAfU9
 9V+WMNXAblDaHjpAFzAXt4/Zo0uJMsdfmNlzQzNcj3jWIc2kBM6s0UEBR7Irr9PMZOnZkEZcs
 c/8vR3OrYrmVvAHgPyHUoAqnwOi1nkuj/EJbxjZCyJPjiwjtGLf2vC67q0O2TuTcRQRmOXqdX
 4UmrPMCPOVME9fNwGK7jyVT8C9IUe2iLjZXSJxdiUvG3ZxTxC1Um7yiTeNirukwl0Kd8qDITO
 4t44UysExiJzTIekoobpFM86YKht9CpTA0bJC+DdGLcyaDUqgrlfFBj2F7Y9jM2xY3xqy/2tb
 1PO5a2USzzD3XUcGh/fA==
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
 arch/x86/kernel/apic/x2apic_uv_x.c | 28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index d5b51a740524..1af416da1f87 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -1493,13 +1493,13 @@ static void check_efi_reboot(void)
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
@@ -1511,28 +1511,11 @@ static int proc_oemid_show(struct seq_file *file, void *data)
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
 static int proc_oemid_open(struct inode *inode, struct file *file)
 {
 	return single_open(file, proc_oemid_show, (void *)NULL);
 }
 
-/* (struct is "non-const" as open function is set at runtime) */
-static struct file_operations proc_version_fops = {
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 static const struct file_operations proc_oemid_fops = {
 	.open		= proc_oemid_open,
 	.read		= seq_read,
@@ -1543,15 +1526,12 @@ static const struct file_operations proc_oemid_fops = {
 static __init void uv_setup_proc_files(int hubless)
 {
 	struct proc_dir_entry *pde;
-	char *name = hubless ? "hubless" : "hubbed";
 
 	pde = proc_mkdir(UV_PROC_NODE, NULL);
-	proc_create("oemid", 0, pde, &proc_oemid_fops);
-	proc_create(name, 0, pde, &proc_version_fops);
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


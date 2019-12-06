Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A215C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 08:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA742467B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 08:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfLFIVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 03:21:02 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7195 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726088AbfLFIVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 03:21:01 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 86107F4CE85D0C8DBBF5;
        Fri,  6 Dec 2019 16:20:59 +0800 (CST)
Received: from huawei.com (10.175.105.18) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Fri, 6 Dec 2019
 16:20:24 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     <pbonzini@redhat.com>, <rkrcmar@redhat.com>,
        <sean.j.christopherson@intel.com>, <vkuznets@redhat.com>,
        <wanpengli@tencent.com>, <jmattson@google.com>, <joro@8bytes.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>
CC:     <linmiaohe@huawei.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: [PATCH] KVM: x86: Fix some comment typos
Date:   Fri, 6 Dec 2019 16:20:18 +0800
Message-ID: <1575620418-19011-1-git-send-email-linmiaohe@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.105.18]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaohe Lin <linmiaohe@huawei.com>

Fix some typos in comment.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 arch/x86/kvm/mmu/mmu.c | 2 +-
 arch/x86/kvm/vmx/vmx.c | 2 +-
 arch/x86/kvm/x86.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index a81c605abbba..0684b90070de 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1525,7 +1525,7 @@ struct rmap_iterator {
 /*
  * Iteration must be started by this function.  This should also be used after
  * removing/dropping sptes from the rmap link because in such cases the
- * information in the itererator may not be valid.
+ * information in the iterator may not be valid.
  *
  * Returns sptep if found, NULL otherwise.
  */
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e58a0daf0f86..e82772d9ab48 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1371,7 +1371,7 @@ void vmx_vcpu_load_vmcs(struct kvm_vcpu *vcpu, int cpu)
 		/*
 		 * VM exits change the host TR limit to 0x67 after a VM
 		 * exit.  This is okay, since 0x67 covers everything except
-		 * the IO bitmap and have have code to handle the IO bitmap
+		 * the IO bitmap and we have code to handle the IO bitmap
 		 * being lost after a VM exit.
 		 */
 		BUILD_BUG_ON(IO_BITMAP_OFFSET - 1 != 0x67);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3ed167e039e5..392d473252f8 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9790,7 +9790,7 @@ static void kvm_mmu_slot_apply_flags(struct kvm *kvm,
 	 *
 	 * The reason is, in case of PML, we need to set D-bit for any slots
 	 * with dirty logging disabled in order to eliminate unnecessary GPA
-	 * logging in PML buffer (and potential PML buffer full VMEXT). This
+	 * logging in PML buffer (and potential PML buffer full VMEXIT). This
 	 * guarantees leaving PML enabled during guest's lifetime won't have
 	 * any additional overhead from PML when guest is running with dirty
 	 * logging disabled for memory slots.
-- 
2.19.1


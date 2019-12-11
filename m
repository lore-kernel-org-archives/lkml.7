Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1978C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 06:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE4224655
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 06:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbfLKG0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 01:26:55 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:40718 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727904AbfLKG0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 01:26:53 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 892D2E27760C2FD8C2D2;
        Wed, 11 Dec 2019 14:26:50 +0800 (CST)
Received: from huawei.com (10.175.105.18) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Wed, 11 Dec 2019
 14:26:41 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     <pbonzini@redhat.com>, <rkrcmar@redhat.com>,
        <sean.j.christopherson@intel.com>, <vkuznets@redhat.com>,
        <wanpengli@tencent.com>, <jmattson@google.com>, <joro@8bytes.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>
CC:     <linmiaohe@huawei.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: [PATCH 4/6] KVM: Fix some grammar mistakes
Date:   Wed, 11 Dec 2019 14:26:23 +0800
Message-ID: <1576045585-8536-5-git-send-email-linmiaohe@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576045585-8536-1-git-send-email-linmiaohe@huawei.com>
References: <1576045585-8536-1-git-send-email-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.105.18]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaohe Lin <linmiaohe@huawei.com>

Fix some grammar mistakes in the comments.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 arch/x86/kvm/ioapic.c | 2 +-
 arch/x86/kvm/lapic.c  | 2 +-
 virt/kvm/kvm_main.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
index 77538fd77dc2..7312aab33298 100644
--- a/arch/x86/kvm/ioapic.c
+++ b/arch/x86/kvm/ioapic.c
@@ -189,7 +189,7 @@ static int ioapic_set_irq(struct kvm_ioapic *ioapic, unsigned int irq,
 	/*
 	 * Return 0 for coalesced interrupts; for edge-triggered interrupts,
 	 * this only happens if a previous edge has not been delivered due
-	 * do masking.  For level interrupts, the remote_irr field tells
+	 * to masking.  For level interrupts, the remote_irr field tells
 	 * us if the interrupt is waiting for an EOI.
 	 *
 	 * RTC is special: it is edge-triggered, but userspace likes to know
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index ea402e741bd5..88c3c0c6d1e3 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -964,7 +964,7 @@ bool kvm_irq_delivery_to_apic_fast(struct kvm *kvm, struct kvm_lapic *src,
 }
 
 /*
- * This routine tries to handler interrupts in posted mode, here is how
+ * This routine tries to handle interrupts in posted mode, here is how
  * it deals with different cases:
  * - For single-destination interrupts, handle it in posted mode
  * - Else if vector hashing is enabled and it is a lowest-priority
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 63df3586f062..f0501272268f 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -964,7 +964,7 @@ static struct kvm_memslots *install_new_memslots(struct kvm *kvm,
 
 	/*
 	 * Increment the new memslot generation a second time, dropping the
-	 * update in-progress flag and incrementing then generation based on
+	 * update in-progress flag and incrementing the generation based on
 	 * the number of address spaces.  This provides a unique and easily
 	 * identifiable generation number while the memslots are in flux.
 	 */
-- 
2.19.1


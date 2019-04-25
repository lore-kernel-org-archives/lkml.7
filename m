Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA32C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 038862077C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbfDYSzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:55:22 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60287 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfDYSzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:55:21 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hJjWg-0007w2-Hm; Thu, 25 Apr 2019 20:55:18 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        tglx@linutronix.de,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] kvm_config: Enable HW_RANDOM_VIRTIO
Date:   Thu, 25 Apr 2019 20:55:13 +0200
Message-Id: <20190425185513.16943-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the HW random generator for kvm configs. Speeds up the
initialisation of the random pool which is used by the getrandom()
syscall.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/configs/kvm_guest.config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/configs/kvm_guest.config b/kernel/configs/kvm_guest.config
index 208481d910903..27eef024169f0 100644
--- a/kernel/configs/kvm_guest.config
+++ b/kernel/configs/kvm_guest.config
@@ -32,3 +32,5 @@ CONFIG_SCSI_LOWLEVEL=y
 CONFIG_SCSI_VIRTIO=y
 CONFIG_VIRTIO_INPUT=y
 CONFIG_DRM_VIRTIO_GPU=y
+CONFIG_HW_RANDOM=y
+CONFIG_HW_RANDOM_VIRTIO=y
-- 
2.20.1


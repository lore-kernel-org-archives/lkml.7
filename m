Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C34C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E04D2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfCMT4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:56:07 -0400
Received: from mga04.intel.com ([192.55.52.120]:42395 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbfCMT4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:56:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2019 12:56:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,475,1544515200"; 
   d="scan'208";a="131403364"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.181])
  by fmsmga008.fm.intel.com with ESMTP; 13 Mar 2019 12:56:05 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add KVM selftests to existing KVM entry
Date:   Wed, 13 Mar 2019 12:55:55 -0700
Message-Id: <20190313195555.6198-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's safe to assume Paolo and Radim are maintaining the KVM selftests
given that the vast majority of commits have their SOBs.  Play nice
with get_maintainers and make it official.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8347269aa386..b95f5b69e5be 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8295,6 +8295,7 @@ F:	include/linux/kvm*
 F:	include/kvm/iodev.h
 F:	virt/kvm/*
 F:	tools/kvm/
+F:	tools/testing/selftests/kvm/
 
 KERNEL VIRTUAL MACHINE FOR AMD-V (KVM/amd)
 M:	Joerg Roedel <joro@8bytes.org>
-- 
2.21.0


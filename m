Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F592C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 20:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74C28206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 20:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbfHAUfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 16:35:25 -0400
Received: from mga05.intel.com ([192.55.52.43]:47474 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbfHAUfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 16:35:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2019 13:35:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,335,1559545200"; 
   d="scan'208";a="191701850"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.41])
  by fmsmga001.fm.intel.com with ESMTP; 01 Aug 2019 13:35:24 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] KVM: x86/mmu: minor MMIO SPTE cleanup
Date:   Thu,  1 Aug 2019 13:35:20 -0700
Message-Id: <20190801203523.5536-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few loosely related MMIO SPTE patches to get rid of a bit of cruft that
has been a source of annoyance when mucking around in the MMIO code.

No functional changes intended.

Sean Christopherson (3):
  KVM: x86: Rename access permissions cache member in struct
    kvm_vcpu_arch
  KVM: x86/mmu: Add explicit access mask for MMIO SPTEs
  KVM: x86/mmu: Consolidate "is MMIO SPTE" code

 Documentation/virtual/kvm/mmu.txt |  4 ++--
 arch/x86/include/asm/kvm_host.h   |  2 +-
 arch/x86/kvm/mmu.c                | 31 +++++++++++++++++--------------
 arch/x86/kvm/mmu.h                |  2 +-
 arch/x86/kvm/vmx/vmx.c            |  2 +-
 arch/x86/kvm/x86.c                |  2 +-
 arch/x86/kvm/x86.h                |  2 +-
 7 files changed, 24 insertions(+), 21 deletions(-)

-- 
2.22.0


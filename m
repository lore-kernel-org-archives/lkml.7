Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6D9C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 09:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC562205F4
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 09:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfLFJBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 04:01:38 -0500
Received: from mga09.intel.com ([134.134.136.24]:50484 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbfLFJBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 04:01:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2019 01:01:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,283,1571727600"; 
   d="scan'208";a="219395084"
Received: from lxy-clx-4s.sh.intel.com ([10.239.43.57])
  by fmsmga001.fm.intel.com with ESMTP; 06 Dec 2019 01:01:36 -0800
From:   Xiaoyao Li <xiaoyao.li@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Xiaoyao Li <xiaoyao.li@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 0/3] Reanme the definitions of INTERRUPT_PENDING, NMI_PENDING and TSC_OFFSETING 
Date:   Fri,  6 Dec 2019 16:45:23 +0800
Message-Id: <20191206084526.131861-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reading the codes, I find the definitions of interrupt-window exiting and
nmi-window exiting don't match the names in latest intel SDM.

I have no idea whether it's the historical names, rename them to match the
latest SDM to avoid confusion.

CPU_BASED_USE_TSC_OFFSETING mis-spelling in Patch 3 is found by checkpatch.pl. 

Xiaoyao Li (3):
  KVM: VMX: Rename INTERRUPT_PENDING to INTERRUPT_WINDOW
  KVM: VMX: Rename NMI_PENDING to NMI_WINDOW
  KVM: VMX: Fix the spelling of CPU_BASED_USE_TSC_OFFSETTING

 arch/x86/include/asm/vmx.h                    |  6 ++--
 arch/x86/include/uapi/asm/vmx.h               |  4 +--
 arch/x86/kvm/vmx/nested.c                     | 28 +++++++++----------
 arch/x86/kvm/vmx/vmx.c                        | 20 ++++++-------
 tools/arch/x86/include/uapi/asm/vmx.h         |  4 +--
 .../selftests/kvm/include/x86_64/vmx.h        |  8 +++---
 .../kvm/x86_64/vmx_tsc_adjust_test.c          |  2 +-
 7 files changed, 36 insertions(+), 36 deletions(-)

-- 
2.19.1


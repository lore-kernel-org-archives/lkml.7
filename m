Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A495C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 172172073D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388363AbfLKQBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 11:01:51 -0500
Received: from mga02.intel.com ([134.134.136.20]:18942 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732868AbfLKQBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 11:01:42 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2019 08:01:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,301,1571727600"; 
   d="scan'208";a="296287348"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by orsmga001.jf.intel.com with ESMTP; 11 Dec 2019 08:01:40 -0800
Date:   Wed, 11 Dec 2019 08:01:40 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     pbonzini@redhat.com, rkrcmar@redhat.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 0/6] Fix various comment errors
Message-ID: <20191211160140.GC5044@linux.intel.com>
References: <1576045585-8536-1-git-send-email-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576045585-8536-1-git-send-email-linmiaohe@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 02:26:19PM +0800, linmiaohe wrote:
> From: Miaohe Lin <linmiaohe@huawei.com>
> 
> Fix various comment mistakes, such as typo, grammar mistake, out-dated
> function name, writing error and so on. It is a bit tedious and many
> thanks for review in advance.
> 
> Miaohe Lin (6):
>   KVM: Fix some wrong function names in comment
>   KVM: Fix some out-dated function names in comment
>   KVM: Fix some comment typos and missing parentheses
>   KVM: Fix some grammar mistakes
>   KVM: hyperv: Fix some typos in vcpu unimpl info
>   KVM: Fix some writing mistakes

Regarding the patch organizing, I'd probably group the comment changes
based on what files they touch as opposed to what type of comment issue
they're fixing.

E.g. three patches for the comments

   KVM: VMX: Fix comment blah blah blah
   KVM: x86: Fix comment blah blah blah
   KVM: Fix comment blah blah blah

and one patch for the print typo in hyperv

   KVM: hyperv: Fix some typos in vcpu unimpl info

For KVM, the splits don't matter _that_ much since they more or less all
get routed through the maintainers/reviewers, but it is nice when patches
can be contained to specific subsystems/areas as it allows people to easily
skip over patches that aren't relevant to them.

>  arch/x86/include/asm/kvm_host.h       | 2 +-
>  arch/x86/kvm/hyperv.c                 | 6 +++---
>  arch/x86/kvm/ioapic.c                 | 2 +-
>  arch/x86/kvm/lapic.c                  | 4 ++--
>  arch/x86/kvm/vmx/nested.c             | 2 +-
>  arch/x86/kvm/vmx/vmcs_shadow_fields.h | 4 ++--
>  arch/x86/kvm/vmx/vmx.c                | 8 ++++----
>  virt/kvm/kvm_main.c                   | 6 +++---
>  8 files changed, 17 insertions(+), 17 deletions(-)
> 
> -- 
> 2.19.1
> 

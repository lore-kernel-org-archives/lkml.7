Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB2BC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A29342086A
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437131AbfHIQTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 12:19:39 -0400
Received: from mga01.intel.com ([192.55.52.88]:32349 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436741AbfHIQTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 12:19:38 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 09:19:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,364,1559545200"; 
   d="scan'208";a="175198128"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by fmsmga008.fm.intel.com with ESMTP; 09 Aug 2019 09:19:37 -0700
Date:   Fri, 9 Aug 2019 09:19:37 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] MAINTAINERS: add KVM x86 reviewers
Message-ID: <20190809161937.GB10541@linux.intel.com>
References: <1565336051-31793-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565336051-31793-1-git-send-email-pbonzini@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 09:34:11AM +0200, Paolo Bonzini wrote:
> This is probably overdone---KVM x86 has quite a few contributors that
> usually review each other's patches, which is really helpful to me.
> Formalize this by listing them as reviewers.  I am including people
> with various expertise:
> 
> - Joerg for SVM (with designated reviewers, it makes more sense to have
> him in the main KVM/x86 stanza)
> 
> - Sean for MMU and VMX
> 
> - Jim for VMX
> 
> - Vitaly for Hyper-V and possibly SVM
> 
> - Wanpeng for LAPIC and paravirtualization.
> 
> Please ack if you are okay with this arrangement, otherwise speak up.
> 
> In other news, Radim is going to leave Red Hat soon.  However, he has
> not been very much involved in upstream KVM development for some time,
> and in the immediate future he is still going to help maintain kvm/queue
> while I am on vacation.  Since not much is going to change, I will let
> him decide whether he wants to keep the maintainer role after he leaves.
> 
> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Wanpeng Li <wanpengli@tencent.com>
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Acked-by: Sean Christopherson <sean.j.christopherson@intel.com>

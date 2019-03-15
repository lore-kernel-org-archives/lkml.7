Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C834AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A221B218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfCOSkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 14:40:52 -0400
Received: from mga02.intel.com ([134.134.136.20]:60788 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfCOSkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 14:40:51 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Mar 2019 11:40:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,483,1544515200"; 
   d="scan'208";a="125812886"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by orsmga008.jf.intel.com with ESMTP; 15 Mar 2019 11:40:50 -0700
Date:   Fri, 15 Mar 2019 11:40:50 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add KVM selftests to existing KVM entry
Message-ID: <20190315184050.GE11324@linux.intel.com>
References: <20190313195555.6198-1-sean.j.christopherson@intel.com>
 <20190313201633.GE4409@linux.intel.com>
 <3bbaa29f-e70d-45a7-b93e-24ecc006bcb7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3bbaa29f-e70d-45a7-b93e-24ecc006bcb7@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 07:07:45PM +0100, Paolo Bonzini wrote:
> On 13/03/19 21:16, Sean Christopherson wrote:
> > Gah, this also needs: tools/testing/selftests/kvm/*/
> > 
> 
> No, it doesn't.
> 
> $ scripts/get_maintainer.pl tools/testing/selftests/kvm/x86_64/state_test.c
> Paolo Bonzini <pbonzini@redhat.com> (supporter:KERNEL VIRTUAL MACHINE (KVM),commit_signer:8/9=89%,authored:3/9=33%)
> "Radim Krčmář" <rkrcmar@redhat.com> (supporter:KERNEL VIRTUAL MACHINE (KVM),commit_signer:1/9=11%)

Ah, I always run with --pattern-depth=1 when sending KVM patches to avoid
picking up the x86 maintainers.  I guess now is as good a time as any to
dynamically select the depth.

That means the similiar "F:      arch/x86/kvm/*/" entry I added is also
gratutious.  Want me to send a revert for c2a7fad5fcd3 ("MAINTAINERS:
Add arch/x86/kvm sub-directories to existing KVM/x86 entry"), or just
leave it be?

> Queued, thanks.
> 
> Paolo

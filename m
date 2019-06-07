Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29A6C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 748B3208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730033AbfFGQEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 12:04:24 -0400
Received: from mga06.intel.com ([134.134.136.31]:37185 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729133AbfFGQEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 12:04:24 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2019 09:04:23 -0700
X-ExtLoop1: 1
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.36])
  by orsmga006.jf.intel.com with ESMTP; 07 Jun 2019 09:04:22 -0700
Date:   Fri, 7 Jun 2019 09:04:22 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: nVMX: Rename prepare_vmcs02_*_full to
 prepare_vmcs02_*_extra
Message-ID: <20190607160422.GE9083@linux.intel.com>
References: <1559834652-105872-1-git-send-email-pbonzini@redhat.com>
 <20190606184117.GJ23169@linux.intel.com>
 <8382fd94-aed1-51b4-007e-7579a0f35ece@redhat.com>
 <20190607141847.GA9083@linux.intel.com>
 <5762005d-1504-bb41-9583-ec549e107ce5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5762005d-1504-bb41-9583-ec549e107ce5@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 05:17:09PM +0200, Paolo Bonzini wrote:
> On 07/06/19 16:18, Sean Christopherson wrote:
> > On Fri, Jun 07, 2019 at 02:19:20PM +0200, Paolo Bonzini wrote:
> >> On 06/06/19 20:41, Sean Christopherson wrote:
> >>>> +static void prepare_vmcs02_early_extra(struct vcpu_vmx *vmx,
> >>> Or maybe 'uncommon', 'rare' or 'ext'?  I don't I particularly love any of
> >>> the names, but they're all better than 'full'.
> >>
> >> I thought 'ext' was short for 'extra'? :)
> > 
> > Ha, I (obviously) didn't make that connection.  ext == extended in my mind.
> 
> That's what came to mind first, but then "extended" had the same issue
> as "full" (i.e. encompassing the "basic" set as well) so I decided you
> knew better!

Ah, I was thinking of "basic" and "extended" as separate states, but your
interpretation is correct.

I probably have a slight preference for 'uncommon' over 'extra'?  I feel
like they have equal odds of being misinterpreted, so pick your poison :-)

Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D41CA9ECF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 22:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD3720862
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 22:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbfJaWxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 18:53:36 -0400
Received: from smtprelay0099.hostedemail.com ([216.40.44.99]:43479 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726540AbfJaWxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 18:53:35 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id F01BB837F24D;
        Thu, 31 Oct 2019 22:53:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pipe73_3c057c4d0b128
X-Filterd-Recvd-Size: 2331
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Thu, 31 Oct 2019 22:53:32 +0000 (UTC)
Message-ID: <3078d0a186cca2dfae741908ffff41f1bdb30eae.camel@perches.com>
Subject: Re: [PATCH 3.16 47/47] KVM: x86/vPMU: refine kvm_pmu err msg when
 event creation failed
From:   Joe Perches <joe@perches.com>
To:     Ben Hutchings <ben@decadent.org.uk>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Cc:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        Like Xu <like.xu@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Date:   Thu, 31 Oct 2019 15:53:23 -0700
In-Reply-To: <05be6a70382f1990a2ba6aba9ac75dac0c55f7fb.camel@decadent.org.uk>
References: <lsq.1572026582.631294584@decadent.org.uk>
         <220d8f2c1b299d2e71fdcf50b98286aae5b0c6f2.camel@perches.com>
         <05be6a70382f1990a2ba6aba9ac75dac0c55f7fb.camel@decadent.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-10-31 at 22:14 +0000, Ben Hutchings wrote:
> On Fri, 2019-10-25 at 12:05 -0700, Joe Perches wrote:
> > On Fri, 2019-10-25 at 19:03 +0100, Ben Hutchings wrote:
> > > 3.16.76-rc1 review patch.  If anyone has any objections, please let me know.
> > 
> > This seems more like an enhancement than a bug fix.
> > 
> > Is this really the type of patch that is appropriate
> > for stable?
> 
> Apparently so:
> 
> v4.14.135: eba797dbf352 KVM: x86/vPMU: refine kvm_pmu err msg when event creation failed
> v4.19.61: ba27a25df6df KVM: x86/vPMU: refine kvm_pmu err msg when event creation failed
> v4.4.187: 505c011f9f53 KVM: x86/vPMU: refine kvm_pmu err msg when event creation failed
> v4.9.187: 3984eae04473 KVM: x86/vPMU: refine kvm_pmu err msg when event creation failed
> v5.1.20: edadec197fbf KVM: x86/vPMU: refine kvm_pmu err msg when event creation failed
> v5.2.3: 9f062aef7356 KVM: x86/vPMU: refine kvm_pmu err msg when event creation failed

I think not, but hey, maybe you and Greg do.

Porting enhancements, even trivial ones, imo is
not a great thing for stable branches.

My perspective is that only bug fixes should be
applied to stable branches.

cheers, Joe


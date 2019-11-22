Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3005BC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 16:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134A820714
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 16:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfKVQWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 11:22:13 -0500
Received: from mga06.intel.com ([134.134.136.31]:55331 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfKVQWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 11:22:11 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Nov 2019 08:22:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,230,1571727600"; 
   d="scan'208";a="232707976"
Received: from unknown (HELO localhost) ([10.239.159.128])
  by fmsmga004.fm.intel.com with ESMTP; 22 Nov 2019 08:22:07 -0800
Date:   Sat, 23 Nov 2019 00:24:02 +0800
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Yang Weijiang <weijiang.yang@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmattson@google.com,
        sean.j.christopherson@intel.com, yu.c.zhang@linux.intel.com,
        alazar@bitdefender.com, edwin.zhai@intel.com
Subject: Re: [PATCH v7 2/9] vmx: spp: Add control flags for Sub-Page
 Protection(SPP)
Message-ID: <20191122162402.GA10491@local-michael-cet-test>
References: <20191119084949.15471-1-weijiang.yang@intel.com>
 <20191119084949.15471-3-weijiang.yang@intel.com>
 <d6e71e7b-b708-211c-24b7-8ffe03a52842@redhat.com>
 <20191121153442.GH17169@local-michael-cet-test>
 <58b4b445-bd47-d357-9fdd-118043624215@redhat.com>
 <20191122152331.GA9822@local-michael-cet-test>
 <8e43dab5-e07e-03a3-fa0d-dd9457fb17b9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e43dab5-e07e-03a3-fa0d-dd9457fb17b9@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 04:55:42PM +0100, Paolo Bonzini wrote:
> On 22/11/19 16:23, Yang Weijiang wrote:
> >> QEMU for example ships with a program called vmxcap (though it requires
> >> root).  We also could write a program to analyze the KVM capabilities
> >> and print them, and put it in tools/kvm.
> >>
> > OK, will update vmxcap to add SPP feature bit, thanks!
> 
> It's already there. :)
>
Yeah, I saw it, thanks a lot for the kind review! :-))
> Paolo

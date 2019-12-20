Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564B5C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 21:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E35F20866
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 21:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfLTVn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 16:43:56 -0500
Received: from mga02.intel.com ([134.134.136.20]:44759 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727413AbfLTVnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 16:43:55 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Dec 2019 13:43:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,337,1571727600"; 
   d="scan'208";a="299124408"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by orsmga001.jf.intel.com with ESMTP; 20 Dec 2019 13:43:54 -0800
Date:   Fri, 20 Dec 2019 13:43:54 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: [PATCH v2 00/17] KVM: Dirty ring interface
Message-ID: <20191220214354.GE20453@linux.intel.com>
References: <20191220211634.51231-1-peterx@redhat.com>
 <20191220213803.GA51391@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220213803.GA51391@xz-x1>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 04:38:03PM -0500, Peter Xu wrote:
> If you see three identical half-posted series which only contains
> patches 00-09... I am very sorry for ruining your inbox...  I think my
> mail server is not happy to continue sending the rest of the patches,
> and I'll get this during sending the patch 10:
> 
> 4.3.0 Temporary System Problem.  Try again later (10). d25sm3385231qtq.11 - gsmtp
> 
> So far I don't see what's wrong with patch 10, either.
> 
> I'll try to fix it up before I send 4th time (or anyone knows please
> hint me)... Please ignore the previous three in-complete versions.

Please add RESEND in the subject when resending an idential patch (set),
it gives recipients a heads up that the two (or four :-)) sets are the
same, e.g. previous versions can be ignored if he/she received both the
original and RESEND version(s).

  [PATCH RESEND v2 00/17] KVM: Dirty ring interface

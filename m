Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3017C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B72E2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389692AbfDRRBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:01:01 -0400
Received: from mga09.intel.com ([134.134.136.24]:49684 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388299AbfDRRBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 13:01:00 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Apr 2019 10:00:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,366,1549958400"; 
   d="scan'208";a="165889735"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by fmsmga001.fm.intel.com with ESMTP; 18 Apr 2019 10:00:54 -0700
Date:   Thu, 18 Apr 2019 10:00:52 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: kvm: hyper-v: deal with buggy TLB flush requests
 from WS2012
Message-ID: <20190418170052.GE17218@linux.intel.com>
References: <20190320174320.9459-1-vkuznets@redhat.com>
 <20190418141752.GB17218@linux.intel.com>
 <f858f28f-6d22-b53b-9572-5220b9ecf81c@redhat.com>
 <20190418165611.GD17218@linux.intel.com>
 <ea77b990-2799-cad4-580e-a55b895cb412@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea77b990-2799-cad4-580e-a55b895cb412@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 06:58:01PM +0200, Paolo Bonzini wrote:
> On 18/04/19 18:56, Sean Christopherson wrote:
> >   For simplicity, flush all CPUs if the guest neglected to set processor_mask.
> 
> We don't know if it neglected to set processor_mask or the flag...

Were you a lawyer before becoming a maintainer? :-)

Yeah, go with your version, I'll get out of the way...

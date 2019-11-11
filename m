Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561E1C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 15:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26CC621655
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 15:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfKKPxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 10:53:52 -0500
Received: from mga07.intel.com ([134.134.136.100]:4905 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726857AbfKKPxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 10:53:51 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2019 07:53:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,293,1569308400"; 
   d="scan'208";a="207143341"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by orsmga006.jf.intel.com with ESMTP; 11 Nov 2019 07:53:50 -0800
Date:   Mon, 11 Nov 2019 07:53:50 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Liran Alon <liran.alon@oracle.com>
Cc:     Joao Martins <joao.m.martins@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jag Raman <jag.raman@oracle.com>
Subject: Re: [PATCH v1 2/3] KVM: VMX: Do not change PID.NDST when loading a
 blocked vCPU
Message-ID: <20191111155349.GA11725@linux.intel.com>
References: <20191106175602.4515-1-joao.m.martins@oracle.com>
 <20191106175602.4515-3-joao.m.martins@oracle.com>
 <15c8c821-25ff-eb62-abd3-8d7d69650744@redhat.com>
 <314a4120-036c-e954-bc9f-e57dee3bbb7c@oracle.com>
 <49912d14-1f79-2658-9471-4193807ad667@redhat.com>
 <b61dc2b2-14be-4d4f-f512-5280010d930a@oracle.com>
 <4E05E5FC-0064-47DE-B4B2-B3BDAF23C072@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4E05E5FC-0064-47DE-B4B2-B3BDAF23C072@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 04:59:20PM +0200, Liran Alon wrote:
> 
> 
> > On 11 Nov 2019, at 16:56, Joao Martins <joao.m.martins@oracle.com> wrote:
> > 
> > On 11/11/19 2:50 PM, Paolo Bonzini wrote:
> >> On 11/11/19 15:48, Joao Martins wrote:
> >>>>> 
> >>>>> Fixes: c112b5f50232 ("KVM: x86: Recompute PID.ON when clearing PID.SN")
> >>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> >>>>> Signed-off-by: Liran Alon <liran.alon@oracle.com>
> >>>> Something wrong in the SoB line?
> >>>> 
> >>> I can't spot any mistake; at least it looks chained correctly for me. What's the
> >>> issue you see with the Sob line?
> >> 
> >> Liran's line after yours is confusing.  Did he help with the analysis or
> >> anything like that?
> >> 
> > He was initially reviewing my patches, but then helped improving the problem
> > description in the commit messages so felt correct to give credit.
> > 
> > 	Joao
> 
> I think proper action is to just remove me from the SoB line.

Use Co-developed-by to attribute multiple authors.  Note, the SoB ordering
should show the chronological history of the patch when possible, e.g. the
person sending the patch should always have their SoB last.

Documentation/process/submitting-patches.rst and 
Documentation/process/5.Posting.rst have more details.

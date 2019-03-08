Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2682C10F09
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D3120855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbfCHIGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 03:06:43 -0500
Received: from mga09.intel.com ([134.134.136.24]:43527 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbfCHIGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 03:06:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Mar 2019 00:06:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,455,1544515200"; 
   d="scan'208";a="140196044"
Received: from lxy-dell.sh.intel.com ([10.239.159.147])
  by orsmga002.jf.intel.com with ESMTP; 08 Mar 2019 00:06:40 -0800
Message-ID: <6f6bf5b4cfe309914c6f533518ecf5e497f1bd73.camel@linux.intel.com>
Subject: Re: [PATCH v4 16/17] kvm: x86: Add support IA32_CORE_CAPABILITY MSR
From:   Xiaoyao Li <xiaoyao.li@linux.intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        kvm@vger.kernel.org
Date:   Fri, 08 Mar 2019 16:03:24 +0800
In-Reply-To: <9edabe63-b77f-d9d8-d573-7e46d944b972@redhat.com>
References: <1551494711-213533-1-git-send-email-fenghua.yu@intel.com>
         <1551494711-213533-17-git-send-email-fenghua.yu@intel.com>
         <74630db9-2a83-cd72-73f6-8b9ef9b07313@redhat.com>
         <3ced155309e5c3a01815ec39bb69016ca06316b6.camel@linux.intel.com>
         <9edabe63-b77f-d9d8-d573-7e46d944b972@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-03-08 at 08:54 +0100, Paolo Bonzini wrote:
> On 08/03/19 07:10, Xiaoyao Li wrote:
> > > so that non-virtualizable features are hidden and
> > > 
> > > 	if (boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT))
> > > 		data |= CORE_CAP_SPLIT_LOCK_DETECT;
> > > 
> > > so that userspace gets "for free" the FMS list that will be added
> > > later to the kernel.
> > 
> > I think it's redundant. Because there is no case that
> > rdmsrl_safe(MSR_IA32_CORE_CAPABILITY, &data) shows no split lock detection
> > while
> > boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT).
> 
> There will be when the kernel will add a list of FMS values that have
> split lock detection but lack the core capabilities MSR.  Or at least
> that is what Fenghua said in the cover letter.
> 
> Paolo

Got it.
Thanks for your explanation.


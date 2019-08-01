Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCDCC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 11:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A8A7206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 11:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730509AbfHALED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 07:04:03 -0400
Received: from mga11.intel.com ([192.55.52.93]:1287 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbfHALED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 07:04:03 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2019 04:04:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,333,1559545200"; 
   d="scan'208";a="172880569"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 01 Aug 2019 04:04:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 5246A162; Thu,  1 Aug 2019 14:03:59 +0300 (EEST)
Date:   Thu, 1 Aug 2019 14:03:59 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "Luck, Tony" <tony.luck@intel.com>,
        "Lin, Jing" <jing.lin@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/asm: Add support for MOVDIR64B instruction
Message-ID: <20190801110358.jmfd2cy7s277j6qv@black.fi.intel.com>
References: <20190730230554.8291-1-kirill.shutemov@linux.intel.com>
 <20190801095928.GA32138@nazgul.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190801095928.GA32138@nazgul.tnic>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 10:03:41AM +0000, Borislav Petkov wrote:
> On Wed, Jul 31, 2019 at 02:05:54AM +0300, Kirill A. Shutemov wrote:
> > Add support for a new instruction MOVDIR64B. The instruction moves
> > 64-bytes as direct-store with 64-byte write atomicity from source memory
> > address to destination memory address.
> > 
> > MOVDIR64B requires the destination address to be 64-byte aligned. No
> > alignment restriction is enforced for source operand.
> > 
> > See Intel Software Developer’s Manual for more information on the
> > instruction.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> > 
> > Several upcoming patchsets will make use of the helper.
> 
> ... so why aren't you sending it together with its first user?

We are not yet sure which patchset will hit upstream first. I thought it
would be logistically easier to get the patch upstream on its own.

But if you prefer the patch to be submitted along with the first user, we
can definately do this.

Jing, are you okay with this?

-- 
 Kirill A. Shutemov

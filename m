Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E43C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 22:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 298B6206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 22:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732113AbfJIWVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 18:21:05 -0400
Received: from mga06.intel.com ([134.134.136.31]:36992 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730675AbfJIWVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 18:21:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 15:21:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,277,1566889200"; 
   d="scan'208";a="368878922"
Received: from yyu32-desk1.sc.intel.com ([10.144.153.205])
  by orsmga005.jf.intel.com with ESMTP; 09 Oct 2019 15:21:03 -0700
Message-ID: <d733c8d7c7c7c27ac6e89374bfb78891119e3b02.camel@intel.com>
Subject: Re: [PATCH 6/6] x86/fpu/xstate: Rename validate_xstate_header() to
 validate_xstate_header_from_user()
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Wed, 09 Oct 2019 15:10:54 -0700
In-Reply-To: <20191009173148.GJ10395@zn.tnic>
References: <20190925151022.21688-1-yu-cheng.yu@intel.com>
         <20190925151022.21688-7-yu-cheng.yu@intel.com>
         <20191009173148.GJ10395@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-10-09 at 19:31 +0200, Borislav Petkov wrote:
> On Wed, Sep 25, 2019 at 08:10:22AM -0700, Yu-cheng Yu wrote:
> > From: Fenghua Yu <fenghua.yu@intel.com>
> > 
> > The function validate_xstate_header() validates an xstate header coming
> > from userspace (PTRACE or sigreturn).  To make it clear, rename it to
> > validate_xstate_header_from_user().
> > 
> > Suggested-by: Dave Hansen <dave.hansen@intel.com>
> > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> > Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> This one is correct!
> 
> \o/
> 
> > Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Reviewed-by: Tony Luck <tony.luck@intel.com>
> > ---
> >  arch/x86/include/asm/fpu/xstate.h | 2 +-
> >  arch/x86/kernel/fpu/regset.c      | 2 +-
> >  arch/x86/kernel/fpu/signal.c      | 2 +-
> >  arch/x86/kernel/fpu/xstate.c      | 6 +++---
> >  4 files changed, 6 insertions(+), 6 deletions(-)
> 
> And I like patches like this one! :-)
> 
> Reviewed-by: Borislav Petkov <bp@suse.de>

Thanks for reviewing.  I will send out an updated version.

Yu-cheng

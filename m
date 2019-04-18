Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEC3C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A4920656
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388454AbfDRNBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:01:02 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36055 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfDRNBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 09:01:02 -0400
Received: from pd9ef12d2.dip0.t-ipconnect.de ([217.239.18.210] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hH6ef-0007T9-Q1; Thu, 18 Apr 2019 15:00:41 +0200
Date:   Thu, 18 Apr 2019 15:00:40 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>, aubrey.li@intel.com,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v15 1/3] /proc/pid/status: Add support for architecture
 specific output
In-Reply-To: <CALCETrUjF9PBmkzH1J86vw4ZW785DP7FtcT+gcSrx29=BUnjoQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1904181500100.3174@nanos.tec.linutronix.de>
References: <20190416063250.7514-1-aubrey.li@linux.intel.com> <20190416160143.8292ced993dc803aae7fa0da@linux-foundation.org> <CALCETrUjF9PBmkzH1J86vw4ZW785DP7FtcT+gcSrx29=BUnjoQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2019, Andy Lutomirski wrote:

> On Tue, Apr 16, 2019 at 4:01 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Tue, 16 Apr 2019 14:32:48 +0800 Aubrey Li <aubrey.li@linux.intel.com> wrote:
> >
> > > The architecture specific information of the running processes could
> > > be useful to the userland. Add support to examine process architecture
> > > specific information externally.
> >
> > The implementation looks just fine to me.  Have you had any feedback on
> > the overall desirability of adding this feature?
> 
> I think I've been the most outspoken, and my not-all-that-strong
> opinion is that I don't really like it.  /proc/PID/status is already a
> bit of a mess, and I don't think we really want it to be a mess that
> is different on different architectures.  Hence my suggestion of
> /proc/PID/x86_status instead.  Or we could do /proc/PID/arch_status, I

arch_status looks like the right thing to do.

Thanks,

	tglx

Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8FFC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E30A2175B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731452AbfDEPcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:32:17 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49161 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfDEPcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 11:32:17 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hCQp8-0006lb-C9; Fri, 05 Apr 2019 17:32:10 +0200
Date:   Fri, 5 Apr 2019 17:32:09 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Laura Abbott <labbott@fedoraproject.org>,
        Ingo Molnar <mingo@kernel.org>,
        Simon Schricker <sschricker@suse.de>,
        Borislav Petkov <bp@suse.de>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] PM / arch: x86: Rework the MSR_IA32_ENERGY_PERF_BIAS
 handling
In-Reply-To: <CAJZ5v0hz3KFtmsP+8Qbee7KrV4BBOUzReUmK8BWH52+hwekt=Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1904051731510.1802@nanos.tec.linutronix.de>
References: <2816566.rddYshD6lm@aspire.rjw.lan> <20190321075807.GK6058@hirez.programming.kicks-ass.net> <CAJZ5v0hz3KFtmsP+8Qbee7KrV4BBOUzReUmK8BWH52+hwekt=Q@mail.gmail.com>
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

On Thu, 21 Mar 2019, Rafael J. Wysocki wrote:

> On Thu, Mar 21, 2019 at 8:58 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Mar 21, 2019 at 01:00:52AM +0100, Rafael J. Wysocki wrote:
> > > + * The Performance and Energy Bias Hint (EPB) allows software to specify its
> > > + * preference with respect to the power-performance tradeoffs present in the
> > > + * processor.  Generally, the EPB is expected to be set by user space through
> > > + * the generic MSR interface (with the help of the x86_energy_perf_policy tool),
> > > + * but there are two reasons for the kernel to touch it.
> >
> > So I hate /dev/msr with a passion. It is absolute atrocious crap.
> >
> > Please, just make a real interface for this if it is important.
> 
> That's the plan going forward, this is just documenting the current situation.
> 
> Do you have any particular concerns regarding this patch?

No.

Acked-by: Thomas Gleixner <tglx@linutronix.de>


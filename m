Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F74C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 18:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E443F21738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 18:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731755AbfDESdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 14:33:52 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49470 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731362AbfDESdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 14:33:52 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hCTes-0002Bw-Ns; Fri, 05 Apr 2019 20:33:46 +0200
Date:   Fri, 5 Apr 2019 20:33:46 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Morten Rasmussen <morten.rasmussen@arm.com>
cc:     Peter Zijlstra <peterz@infradead.org>, Len Brown <lenb@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/14] v2 multi-die/package topology support
In-Reply-To: <20190307145925.GD19434@e105550-lin.cambridge.arm.com>
Message-ID: <alpine.DEB.2.21.1904052033220.1802@nanos.tec.linutronix.de>
References: <20190226062012.23746-1-lenb@kernel.org> <20190226185358.GQ2861@worktop.programming.kicks-ass.net> <20190307145925.GD19434@e105550-lin.cambridge.arm.com>
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

On Thu, 7 Mar 2019, Morten Rasmussen wrote:
> On Tue, Feb 26, 2019 at 07:53:58PM +0100, Peter Zijlstra wrote:
> > On Tue, Feb 26, 2019 at 01:19:58AM -0500, Len Brown wrote:
> > > Added sysfs core_threads, core_threads_list
> > > 
> > > 	Added this attribute to show which threads siblings in a core.
> > > 	Exactly same as "thread_siblings", a name now deprecated.
> > > 	This attribute name and definition is immune to future
> > > 	topology changes.
> > > 
> > > 	Suggested by Brice.
> > 
> > I think I prefer 's/threads/cpus/g' on that. Threads makes me think SMT,
> > and I don't think there's any guarantee the part in question will have
> > SMT on.
> 
> I think 'threads' is a bit confusing as well. We seem to be using 'cpu'
> everywhere for something we can schedule tasks on, including the sysfs
> /sys/devices/system/cpu/ subdirs for each SMT thread on SMT systems.
> 
> Another thing that I find confusing is that with this series we a new
> die id/mask which is totally unrelated to the DIE level in the
> sched_domain hierarchy. We should rename DIE level to something that
> reflects what it really is. If we can agree on that ;-)
> 
> NODE level?

Any conclusions here?


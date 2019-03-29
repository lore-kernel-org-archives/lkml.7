Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703ACC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 334F22064A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbfC2KTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:19:04 -0400
Received: from verein.lst.de ([213.95.11.211]:51485 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728398AbfC2KTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:19:03 -0400
Received: by newverein.lst.de (Postfix, from userid 2005)
        id E301068CEC; Fri, 29 Mar 2019 11:18:53 +0100 (CET)
Date:   Fri, 29 Mar 2019 11:18:53 +0100
From:   Torsten Duwe <duwe@lst.de>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Julien Thierry <julien.thierry@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        live-patching@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 0/5] arm64: ftrace with regs
Message-ID: <20190329101853.GA18386@lst.de>
References: <20190208150826.44EBC68DD2@newverein.lst.de> <0f8d2e77-7e51-fba8-b179-102318d9ff84@arm.com> <20190311114945.GA5625@lst.de> <20190311121804.GB23361@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311121804.GB23361@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 12:18:05PM +0000, Mark Rutland wrote:
> Hi Torsten,
> 
> On Mon, Mar 11, 2019 at 12:49:46PM +0100, Torsten Duwe wrote:
> > On Wed, Feb 13, 2019 at 11:11:04AM +0000, Julien Thierry wrote:
> > > Hi Torsten,
> > > 
> > > On 08/02/2019 15:08, Torsten Duwe wrote:
> > > > Patch series v8, as discussed.
> > > > The whole series applies cleanly on 5.0-rc5
> > 
> > So what's the status now? Besides debatable minor style
> > issues there were no more objections to v8. Would this
> > go through the ARM repo or via the ftrace repo?
> 
> Sorry, I have some half-written review comments that I will clean up and
> send shortly.

Ping?

> As commented on prior versions, I'd very much like to see the
> MCOUNT_ADDR hack go, by teaching the core ftrace code to not assume that
> an mcount symbol exists.

> We should be able to do that by separating the notion of NOPing a patch
> site from the notion of initializing it for the first time.

This is generally a good idea, and would affect other architectures as well,
see arch/s390/kernel/ftrace.c ftrace_make_nop(...)

I propose to do this in a second round.

	Torsten

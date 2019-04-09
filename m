Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB41C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19DD62077C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfDIRwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:52:45 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42346 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbfDIRwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:52:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA74D15BE;
        Tue,  9 Apr 2019 10:52:42 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 800383F59C;
        Tue,  9 Apr 2019 10:52:40 -0700 (PDT)
Date:   Tue, 9 Apr 2019 18:52:38 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Torsten Duwe <duwe@lst.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <julien.thierry@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: Re: [PATCH v8 0/5] arm64: ftrace with regs
Message-ID: <20190409175238.GE9255@fuggles.cambridge.arm.com>
References: <20190208150826.44EBC68DD2@newverein.lst.de>
 <0f8d2e77-7e51-fba8-b179-102318d9ff84@arm.com>
 <20190311114945.GA5625@lst.de>
 <20190408153628.GL6139@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408153628.GL6139@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 04:36:28PM +0100, Mark Rutland wrote:
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
> Sorry agains for the delay on this. I'm now back in the office and in
> front of a computer daily, so I can spend a bit more time on this.
> 
> Regardless of anything else, I think that we should queue the first
> three patches now. I've poked the relevant maintainers for their acks so
> that those can be taken via the arm64 tree.
> 
> I'm happy to do the trivial cleanups on the last couple of patches (e.g.
> s/lr/x30), and I'm actively looking at the API rework I requested.

Ok, I've picked up patches 1-3 and I'll wait for you to spin updates to the
last two.

Will

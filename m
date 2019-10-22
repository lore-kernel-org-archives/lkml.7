Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5C8CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 15:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D3BE2084B
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 15:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732420AbfJVPeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 11:34:01 -0400
Received: from [217.140.110.172] ([217.140.110.172]:55512 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1730405AbfJVPeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 11:34:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17DEB176C;
        Tue, 22 Oct 2019 08:33:40 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEA4D3F71A;
        Tue, 22 Oct 2019 08:33:37 -0700 (PDT)
Date:   Tue, 22 Oct 2019 16:33:35 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     jthierry@redhat.com, will@kernel.org, ard.biesheuvel@linaro.org,
        peterz@infradead.org, catalin.marinas@arm.com, deller@gmx.de,
        jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        takahiro.akashi@linaro.org, mingo@redhat.com, james.morse@arm.com,
        jeyu@kernel.org, amit.kachhap@arm.com, svens@stackframe.org,
        duwe@suse.de, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/8] ftrace: add ftrace_init_nop()
Message-ID: <20191022153335.GC52920@lakrids.cambridge.arm.com>
References: <20191021163426.9408-1-mark.rutland@arm.com>
 <20191021163426.9408-2-mark.rutland@arm.com>
 <20191021140756.613a1bac@gandalf.local.home>
 <20191022112811.GA11583@lakrids.cambridge.arm.com>
 <20191022085428.75cfaad6@gandalf.local.home>
 <20191022153035.GB52920@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022153035.GB52920@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 04:30:35PM +0100, Mark Rutland wrote:
> On Tue, Oct 22, 2019 at 08:54:28AM -0400, Steven Rostedt wrote:
> > On Tue, 22 Oct 2019 12:28:11 +0100
> > Mark Rutland <mark.rutland@arm.com> wrote:
> > > | /**
> > > |  * ftrace_init_nop - initialize a nop call site
> > > |  * @mod: module structure if called by module load initialization
> > > |  * @rec: the mcount call site record
> > 
> > Perhaps say "mcount/fentry"
> 
> This is the exact wording that ftrace_make_nop and ftrace_modify_call
> have. For consistency, I think those should all match.

Now that I read this again, I see what you meant.

If it's ok, I'll change those to:

| @rec: the call site record (e.g. mcount/fentry)

Thanks,
Mark.

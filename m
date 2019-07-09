Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0978C73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 15:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 965B321670
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 15:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfGIPks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 11:40:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:36970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbfGIPks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 11:40:48 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE6ED214AF;
        Tue,  9 Jul 2019 15:40:46 +0000 (UTC)
Date:   Tue, 9 Jul 2019 11:40:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Masami Hiramatsu <masami.hiramatsu@gmail.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        James Morse <james.morse@arm.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kprobes sanity test fails on next-20190708
Message-ID: <20190709114045.091c94f3@gandalf.local.home>
In-Reply-To: <20190709153755.GB10123@lakrids.cambridge.arm.com>
References: <20190708141136.GA3239@localhost.localdomain>
        <a19faa89-d318-fe21-9952-b0f842240ba5@arm.com>
        <CADYN=9LBQ4NYFe8BPguJmxJFMiAJ405AZNU7W6gHXLSrZOSgTA@mail.gmail.com>
        <20190709213657.1447f508bd6b72495ec225d9@gmail.com>
        <20190709112548.25edc9a7@gandalf.local.home>
        <20190709153755.GB10123@lakrids.cambridge.arm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jul 2019 16:37:55 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> > I agree. I pushed to my repo in the for-next branch. Care to test that?
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git  
> 
> I've just given that a spin with KPROBES and KPROBES_SANITY_TEST
> selected, and it boots cleanly for me. FWIW:
> 
> Tested-by: Mark Rutland <mark.rutland@arm.com>

Thanks, then I'm guessing no more changes need to be made.

I usually don't rebase my for-next branch for tags, but since I just
pushed it, I guess I can add this one ;-)

-- Steve

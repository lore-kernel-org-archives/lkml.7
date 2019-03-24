Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7E5C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 14:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C432222DA
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 14:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="q1dHrhQm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfCXOAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 10:00:20 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47786 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726743AbfCXOAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 10:00:19 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4ECEB1EC00FF;
        Sun, 24 Mar 2019 15:00:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553436018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+YKEiIEblIDNxy9339r/xS5GOdKIDdOG8rjz1FH1jmg=;
        b=q1dHrhQma8+KHSvEc0L4n3FSY6DuMLNER1MFHrD6q4eM5JSNnTaFfBJ9zA1eqTOqmJT41o
        YNcNV4dDY9qnfAqH87efHIl3FKz4aZzfSAnjEBgJTst4nT7tybMc6arzHNt9/HDwNrexMm
        WB9lwn/mDSpZS3ontb6n6VPKQ6nCX+0=
Date:   Sun, 24 Mar 2019 15:00:21 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+370a6b0f11867bf13515@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: WARNING in arch_install_hw_breakpoint
Message-ID: <20190324140021.GE23289@zn.tnic>
References: <000000000000639f6a0584d11b82@google.com>
 <20190324090719.GA23289@zn.tnic>
 <CACT4Y+bRopxWvo1ssYD7V++KG1tmVXyab0iKkcSXZFMuK63rvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+bRopxWvo1ssYD7V++KG1tmVXyab0iKkcSXZFMuK63rvA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 02:07:14PM +0100, Dmitry Vyukov wrote:
> On Sun, Mar 24, 2019 at 10:07 AM Borislav Petkov <bp@alien8.de> wrote:
> >
> > syzbot folks,
> >
> > please fix your bot - I got 164(!) copies of this mail. No, wait, 165.
> >
> > This is really annoying.
> 
> Oops. Sorry. This should be fixed by
> https://github.com/google/syzkaller/commit/8e1b6f644671a0401ceadcaf0b611ab248b88355
> now.

I hope. I'm still getting emails which look like they've been queued
already and now it'll take a while for those queues to get empty again.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

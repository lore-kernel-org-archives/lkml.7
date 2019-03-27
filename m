Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52686C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EBFD20651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbfC0O3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:29:50 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50849 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbfC0O3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:29:50 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h99YK-0003y8-Lc; Wed, 27 Mar 2019 15:29:16 +0100
Date:   Wed, 27 Mar 2019 15:29:16 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
cc:     Oleg Nesterov <oleg@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v2] x86/syscalls: Mark expected switch fall-throughs
In-Reply-To: <20190327012606.GA16532@altlinux.org>
Message-ID: <alpine.DEB.2.21.1903271527110.1789@nanos.tec.linutronix.de>
References: <20190228192746.GA13021@embeddedor> <alpine.DEB.2.21.1903231457590.1798@nanos.tec.linutronix.de> <20190326151244.GC16837@redhat.com> <20190327012606.GA16532@altlinux.org>
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

On Wed, 27 Mar 2019, Dmitry V. Levin wrote:

> On Tue, Mar 26, 2019 at 04:12:45PM +0100, Oleg Nesterov wrote:
> > On 03/23, Thomas Gleixner wrote:
> [...]
> > >  2) syscall_set_arguments() has been introduced in 2008 and we still have
> > >     no caller. Instead of polishing it, can it be removed completely or are
> > >     there plans to actually use it?
> > 
> > I think it can die.
> 
> When PTRACE_GET_SYSCALL_INFO is finally squeezed into the kernel,
> we could discuss adding PTRACE_SET_SYSCALL_INFO as well, and it
> will need syscall_set_arguments().

So if that ever happens, then adding the code back isn't rocket
science. But if not, then there is no point in carrying the dead horse
around another 11 years.

Thanks,

	tglx

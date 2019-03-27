Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DA9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 523C02173C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbfC0XDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:03:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:50534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbfC0XDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:03:44 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEA322075E;
        Wed, 27 Mar 2019 23:03:42 +0000 (UTC)
Date:   Wed, 27 Mar 2019 19:03:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Dmitry V. Levin" <ldv@altlinux.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v2] x86/syscalls: Mark expected switch fall-throughs
Message-ID: <20190327190341.4a83bacf@gandalf.local.home>
In-Reply-To: <alpine.DEB.2.21.1903272351110.1789@nanos.tec.linutronix.de>
References: <20190228192746.GA13021@embeddedor>
        <alpine.DEB.2.21.1903231457590.1798@nanos.tec.linutronix.de>
        <20190326151244.GC16837@redhat.com>
        <20190327012606.GA16532@altlinux.org>
        <alpine.DEB.2.21.1903271527110.1789@nanos.tec.linutronix.de>
        <20190327222014.GA32540@altlinux.org>
        <alpine.DEB.2.21.1903272351110.1789@nanos.tec.linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2019 23:52:19 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:


> > Could we delay the removal of syscall_set_arguments() until
> > PTRACE_GET_SYSCALL_INFO is merged into the kernel?
> > I hope it won't take another 11 years.  
> 
> Hope dies last :)
> 
> Seriously. If we keep it can we at least remove all the unused arguments
> which we have on both functions to simplify the whole mess?

I've finished forward porting my old patches, and was about to just
remove that function. But instead, I'll make it identical to the
set_get_arguments().

I have a bit more testing to do before I post the result.

-- Steve


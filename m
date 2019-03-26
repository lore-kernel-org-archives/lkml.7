Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF946C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9893E20863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbfCZQQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:16:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:48642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730441AbfCZQQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 12:16:42 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D2E520811;
        Tue, 26 Mar 2019 16:16:41 +0000 (UTC)
Date:   Tue, 26 Mar 2019 12:16:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v2] x86/syscalls: Mark expected switch fall-throughs
Message-ID: <20190326121639.2f3586ff@gandalf.local.home>
In-Reply-To: <alpine.DEB.2.21.1903261706230.1789@nanos.tec.linutronix.de>
References: <20190228192746.GA13021@embeddedor>
        <alpine.DEB.2.21.1903231457590.1798@nanos.tec.linutronix.de>
        <20190326151244.GC16837@redhat.com>
        <alpine.DEB.2.21.1903261706230.1789@nanos.tec.linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2019 17:09:44 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:

> > >  1) The third argument of get/set(), i.e. the argument offset, is 0 on all
> > >     call sites. Do we need it at all?  
> > 
> > Probably "maxargs" can be removed too, Steven sent the patches a long ago, see
> > https://lore.kernel.org/lkml/20161107212634.529267342@goodmis.org/  
> 
> Indeed. We should resurrect them.
> 
> > >  2) syscall_set_arguments() has been introduced in 2008 and we still have
> > >     no caller. Instead of polishing it, can it be removed completely or are
> > >     there plans to actually use it?  
> > 
> > I think it can die.  
> 
> Good. Removed code is the least buggy code :)
> 
> Gustavo, it would be really appreciated if you could take care of that,
> unless Steven wants to polish his old set up himself. If you have no
> cycles, please let us know.

I still have those patches in my quilt queue. I can polish them up and
resend.

-- Steve

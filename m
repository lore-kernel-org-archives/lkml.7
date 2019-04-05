Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F3DC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E8CA218AE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730870AbfDEOHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:07:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:52918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728811AbfDEOHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 10:07:53 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCF3921872;
        Fri,  5 Apr 2019 14:07:50 +0000 (UTC)
Date:   Fri, 5 Apr 2019 10:07:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Roland McGrath <roland@hack.frob.com>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Palmer Dabbelt <palmer@sifive.com>
Subject: Re: [PATCH 0/6 v3] sycalls: Remove args i and n from
 syscall_get_arguments()
Message-ID: <20190405100749.56bf86a2@gandalf.local.home>
In-Reply-To: <CAHk-=wh1wv_g2cW07OG1n5oHFXxZUc2192ZQ+6p5Cj+46FDQVQ@mail.gmail.com>
References: <20190401134104.676620247@goodmis.org>
 <20190404092803.1bffd135@gandalf.local.home>
 <CAHk-=wh1wv_g2cW07OG1n5oHFXxZUc2192ZQ+6p5Cj+46FDQVQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Apr 2019 15:24:16 -1000
Linus Torvalds <torvalds@linux-foundation.org> wrote:


> I assume you've actually used this and can trace system calls with
> arguments properly, so that it's all tested at least on x86-64?
>

Yep, and even tested it against strace. Looks fine. I also ran it
through my entire ftrace test suite (takes around 10 hours or more),
and it all passed.

I'll collect the last bit of acks and then send you a pull request.

-- Steve

Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB82C17498
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BCA4217F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731048AbfKEOxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 09:53:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41600 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbfKEOxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 09:53:47 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iS0DH-00062U-Nf; Tue, 05 Nov 2019 15:53:43 +0100
Date:   Tue, 5 Nov 2019 15:53:43 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Florian Weimer <fweimer@redhat.com>
cc:     Carlos O'Donell <carlos@redhat.com>, Shawn Landden <shawn@git.icu>,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Keith Packard <keithp@keithp.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC v2 PATCH] futex: extend set_robust_list to allow 2 locking
 ABIs at the same time.
In-Reply-To: <87o8xqqty3.fsf@oldenburg2.str.redhat.com>
Message-ID: <alpine.DEB.2.21.1911051550350.17054@nanos.tec.linutronix.de>
References: <20191104002909.25783-1-shawn@git.icu> <87woceslfs.fsf@oldenburg2.str.redhat.com> <alpine.DEB.2.21.1911051053470.17054@nanos.tec.linutronix.de> <87sgn2skm6.fsf@oldenburg2.str.redhat.com> <alpine.DEB.2.21.1911051253430.17054@nanos.tec.linutronix.de>
 <f11d82f1-1e81-e344-3ad2-76e4cb488a3d@redhat.com> <87o8xqqty3.fsf@oldenburg2.str.redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Nov 2019, Florian Weimer wrote:
> * Carlos O'Donell:
> > "Robust mutexes do not take ROBUST_LIST_LIMIT into account"
> > https://sourceware.org/bugzilla/show_bug.cgi?id=19089
> 
> That's just a missing check in our implementation and something that few
> applications will encounter, if any.  There is this one here:
> 
>   <https://sourceware.org/bugzilla/show_bug.cgi?id=19004>
> 
> It contains a kernel patch.
> 
> I thought that there were more issues in the current implementation, but
> I can't a record of them. 8-(

There is a nasty one in my inbox with a kernel patch fixing it, which I
still need to review with all futex brain cells activated:

  https://lore.kernel.org/r/1572573789-16557-1-git-send-email-wang.yi59@zte.com.cn

Thanks,

	tglx

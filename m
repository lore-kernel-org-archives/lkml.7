Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79116C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 03:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CAE82073F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 03:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfFXDB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 23:01:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34569 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbfFXDBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 23:01:50 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hfApz-0007IB-Sg; Mon, 24 Jun 2019 00:19:52 +0200
Date:   Mon, 24 Jun 2019 00:19:51 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@amacapital.net>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] x86/vdso: Give the [ph]vclock_page declarations real
 types
In-Reply-To: <49C4F6B3-D419-4035-B49D-1586912C670C@amacapital.net>
Message-ID: <alpine.DEB.2.21.1906240019130.32342@nanos.tec.linutronix.de>
References: <6920c5188f8658001af1fc56fd35b815706d300c.1561241273.git.luto@kernel.org> <alpine.DEB.2.21.1906231441500.32342@nanos.tec.linutronix.de> <CAHk-=whywzng7FLV9X67RPmHNnygK+7VJV+zh4njT6BA+h9tCw@mail.gmail.com> <alpine.DEB.2.21.1906231509440.32342@nanos.tec.linutronix.de>
 <49C4F6B3-D419-4035-B49D-1586912C670C@amacapital.net>
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

On Sun, 23 Jun 2019, Andy Lutomirski wrote:

> 
> > On Jun 23, 2019, at 6:10 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > 
> >> On Sun, 23 Jun 2019, Linus Torvalds wrote:
> >> 
> >> Andy added comments and changed the patch in other ways too, so I think
> >> it's fine to have him as author, and my sign-off is just for the original
> >> smaller patch.
> > 
> > Well, that will earn me a nastigram from the next checkers as it's not
> > compliant to our SOB rules ....
> > 
> 
> Feel free to add:
> 
> Originally-by: Linus ...
> 
> I had assumed the textual description was enough.

Ha, completely forgot about Co-developed-by. That does the trick nicely.


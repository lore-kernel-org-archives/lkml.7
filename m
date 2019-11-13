Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC1AC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59CE1206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfKMVoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:44:11 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39143 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfKMVoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:44:11 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iV0Qp-0006uS-D7; Wed, 13 Nov 2019 22:44:07 +0100
Date:   Wed, 13 Nov 2019 22:44:06 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch V3 12/20] x86/ioperm: Move TSS bitmap update to exit to
 user work
In-Reply-To: <CAADWXX8Rf5jGNw3=A44GtzZd875bL9s2DV4R3nUorU9FJECMcw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1911132242510.2507@nanos.tec.linutronix.de>
References: <20191113204240.767922595@linutronix.de> <20191113210104.882617091@linutronix.de> <CAHk-=wh9BdH5DLjfv72LOWSb6P1jMwO0TYraS1gnYZDdTCi+rQ@mail.gmail.com> <CAADWXX8Rf5jGNw3=A44GtzZd875bL9s2DV4R3nUorU9FJECMcw@mail.gmail.com>
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

On Wed, 13 Nov 2019, Linus Torvalds wrote:

> On Wed, Nov 13, 2019 at 1:19 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I wonder if it might make sense to delay it even more: [..]
> 
> Btw, don't take that as a suggestion to make further changes. It was
> more of an idle observation, and it probably doesn't matter one whit.

Hehe. I wont, but yes the idea is sneaky enough to be really tempting :)

Thanks,

	tglx

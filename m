Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AACC47E49
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 23:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F6D2208C0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 23:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbfJ0Xo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 19:44:59 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:35704 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbfJ0Xo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 19:44:58 -0400
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23991783AbfJ0Xo4LVPWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 00:44:56 +0100
Date:   Sun, 27 Oct 2019 23:44:56 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Andy Lutomirski <luto@kernel.org>
cc:     Willy Tarreau <w@1wt.eu>, dev@dpdk.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Please stop using iopl() in DPDK
In-Reply-To: <CALCETrXtKBtMx3gf2BysCeYEzDFN_wjiKCGh_onCdA=7TbBxZw@mail.gmail.com>
Message-ID: <alpine.LFD.2.21.1910272343280.15860@eddie.linux-mips.org>
References: <CALCETrVepdYd4uN8jrG8i6iaixWp+N3MdGv5WhjOdCr9sLRK1w@mail.gmail.com> <20191025064225.GA22917@1wt.eu> <CALCETrXtKBtMx3gf2BysCeYEzDFN_wjiKCGh_onCdA=7TbBxZw@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Oct 2019, Andy Lutomirski wrote:

> > I'd see an API more or less like this :
> >
> >   int ioport(int op, u16 port, long val, long *ret);
> 
> Hmm.  I have some memory of a /dev/ioport or similar, but now I can't
> find it.  It does seem quite reasonable.

crw-r----- 1 root kmem 1, 4 Sep  9 13:58 /dev/port

  Maciej

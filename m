Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED69C73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 573AD20665
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfGIS1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:27:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46049 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfGIS1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:27:18 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hkupf-0003fC-5y; Tue, 09 Jul 2019 20:27:15 +0200
Date:   Tue, 9 Jul 2019 20:27:09 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [PATCH v2 1/7] rslib: Add tests for the encoder and decoder
In-Reply-To: <CAMuHMdV96dj7=b9NTLua=-_kr18yQxjZhuiOFAEA8m22rSobNw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1907092025530.1758@nanos.tec.linutronix.de>
References: <20190620141039.9874-1-ferdinand.blomqvist@gmail.com> <20190620141039.9874-2-ferdinand.blomqvist@gmail.com> <CAMuHMdV96dj7=b9NTLua=-_kr18yQxjZhuiOFAEA8m22rSobNw@mail.gmail.com>
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

On Tue, 9 Jul 2019, Geert Uytterhoeven wrote:

> Hi Ferdinand,
> 
> On Thu, Jun 20, 2019 at 4:13 PM Ferdinand Blomqvist
> <ferdinand.blomqvist@gmail.com> wrote:
> > A Reed-Solomon code with minimum distance d can correct any error and
> > erasure pattern that satisfies 2 * #error + #erasures < d. If the
> > error correction capacity is exceeded, then correct decoding cannot be
> > guaranteed. The decoder must, however, return a valid codeword or report
> > failure.
> 
> > Note that the tests take a couple of minutes to complete.
> 
> On which hardware? ;-)
> 
> JFTR, the test succeeded on m68k, after 6 hours and 12 minutes of runtime
> on an emulated Atari Falcon (ARAnyM hosted by an i7-4770).
> So far I have no plans to run it on bare metal.

It took about 4 minutes on a 10 year old lame desktop and was way faster on
one of the big irons.

Thanks,

	tglx

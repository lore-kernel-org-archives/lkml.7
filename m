Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DBFC3A5A5
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AEFC21848
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394680AbfHWM0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 08:26:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35290 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfHWM0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 08:26:15 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i18do-0001xv-4e; Fri, 23 Aug 2019 14:26:04 +0200
Date:   Fri, 23 Aug 2019 14:25:58 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
cc:     Will Deacon <will@kernel.org>,
        Chris Clayton <chris2553@googlemail.com>,
        linux-arch@vger.kernel.org, vincenzo.frascino@arm.com,
        linux-mips@vger.kernel.org, linux-kselftest@vger.kernel.org,
        arnd@arndb.de, huw@codeweavers.com, andre.przywara@arm.com,
        daniel.lezcano@linaro.org, will.deacon@arm.com,
        LKML <linux-kernel@vger.kernel.org>, ralf@linux-mips.org,
        salyzyn@android.com, paul.burton@mips.com,
        linux@rasmusvillemoes.dk, 0x7f454c46@gmail.com,
        catalin.marinas@arm.com, pcc@google.com, sthotton@marvell.com,
        shuah@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: Regression in 5.3-rc1 and later
In-Reply-To: <20190823111712.GB13294@shell.armlinux.org.uk>
Message-ID: <alpine.DEB.2.21.1908231424230.1896@nanos.tec.linutronix.de>
References: <faaa3843-09a6-1a21-3448-072eeed1ea00@googlemail.com> <20190823103654.GX13294@shell.armlinux.org.uk> <20190823104050.o6golaa4fmdd7np5@willie-the-truck> <20190823111712.GB13294@shell.armlinux.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Aug 2019, Russell King - ARM Linux admin wrote:

> On Fri, Aug 23, 2019 at 11:40:50AM +0100, Will Deacon wrote:
> > On Fri, Aug 23, 2019 at 11:36:54AM +0100, Russell King - ARM Linux admin wrote:
> > > To everyone on the long Cc list...
> > > 
> > > What's happening with this?  I was about to merge the patches for 32-bit
> > > ARM, which I don't want to do if doing so will cause this regression on
> > > 32-bit ARM as well.
> > 
> > tglx fixed it:
> > 
> > https://lkml.kernel.org/r/alpine.DEB.2.21.1908221257580.1983@nanos.tec.linutronix.de
> > 
> > which I assume is getting routed as a fix via -tip.
> 
> Right, so Chris reported the issue to everyone involved.  Tglx's
> reply severely trimmed the Cc list so folk like me had no idea what
> was going on, removing even the mailing lists.  On the face of it,
> it looks like an intentional attempt to cut people out of the loop
> who really should've been kept in the loop.  Yea, that's just great.

Sorry that was no intentional attempt to cut anyone out of the
loop. Trimmed it too agressively without applying much brain.

Thanks,

	tglx

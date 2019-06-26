Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C9BC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8164221738
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfFZQim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 12:38:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49543 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfFZQil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 12:38:41 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hgAw8-0007Ue-U0; Wed, 26 Jun 2019 18:38:21 +0200
Date:   Wed, 26 Jun 2019 18:38:19 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrey Vagin <avagin@openvz.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dmitry Safonov <dima@arista.com>,
        Peter Collingbourne <pcc@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Shuah Khan <shuah@kernel.org>,
        Shijith Thotton <sthotton@marvell.com>,
        Sasha Levin <sashal@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Huw Davies <huw@codeweavers.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:timers/vdso] MAINTAINERS: Add entry for the generic VDSO
 library
In-Reply-To: <CALCETrWaUEnnTiyh-xDoywji1GdfoeoSmy635MYcXMe9CgYkCA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1906261837170.32342@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1906240142000.32342@nanos.tec.linutronix.de> <tip-e70980312a946a56173843cbc0104b3b0e57a0c7@git.kernel.org> <CALCETrWaUEnnTiyh-xDoywji1GdfoeoSmy635MYcXMe9CgYkCA@mail.gmail.com>
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

On Wed, 26 Jun 2019, Andy Lutomirski wrote:
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index d0ed735994a5..13ece5479167 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -6664,6 +6664,18 @@ L:       kvm@vger.kernel.org
> >  S:     Supported
> >  F:     drivers/uio/uio_pci_generic.c
> >
> > +GENERIC VDSO LIBRARY:
> > +M:     Andy Lutomirksi <luto@kernel.org>
> 
> s/ksi/ski :)
> 
> Yes, it's a mouthful.

/me blushes some more

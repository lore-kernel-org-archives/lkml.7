Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC08C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 19:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C398A2084E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 19:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfFUTdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 15:33:41 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:56907 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfFUTdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 15:33:41 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hePI1-0005dP-D7; Fri, 21 Jun 2019 21:33:37 +0200
Date:   Fri, 21 Jun 2019 21:33:36 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Chris Wilson <chris@chris-wilson.co.uk>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: NMI hardlock stacktrace deadlock [was Re: Linux 5.2-rc5]
In-Reply-To: <156114224132.2401.13297188928702045223@skylake-alporthouse-com>
Message-ID: <alpine.DEB.2.21.1906212130230.5503@nanos.tec.linutronix.de>
References: <CAHk-=whEQPvLpDbx+WR4Q4jf2FxXjf_zTX3uLy_6ZzHtgTV4LA@mail.gmail.com> <156094799629.21217.4574572565333265288@skylake-alporthouse-com> <CAHk-=wjhJNKVfHgwd0QX_bq769sxfP4jvfy0dd-WtFMfdivMwg@mail.gmail.com> <156097197830.664.13418742301997062555@skylake-alporthouse-com>
 <CAHk-=wjoeZ9_aiu+642ur=iGhGjfBQhRPURxX9Py+-B6coctXw@mail.gmail.com> <alpine.DEB.2.21.1906211725200.5503@nanos.tec.linutronix.de> <156114224132.2401.13297188928702045223@skylake-alporthouse-com>
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

On Fri, 21 Jun 2019, Chris Wilson wrote:

> Quoting Thomas Gleixner (2019-06-21 16:30:52)
> > Chris, do you have the actual NMI lockup detector splats somewhere?
> 
> Sorry, I'm having a hard time reproducing this at will now. The test
> case depends on the right timing of the wrong event to cause the GPU to
> hang.
> 
> From memory, I got the
> 	"Watchdog detected hard LOCKUP on cpu foo"
> followed by the register dump and then nothing. At which point I had to
> power cycle the machine.

Hmm. Do you have a serial log of that incident?

Thanks,

	tglx

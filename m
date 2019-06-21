Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74DDC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 19:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E3D205ED
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 19:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfFUT5W convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 15:57:22 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:63966 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725992AbfFUT5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 15:57:21 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 16983672-1500050 
        for multiple; Fri, 21 Jun 2019 20:56:15 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Thomas Gleixner <tglx@linutronix.de>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <alpine.DEB.2.21.1906212130230.5503@nanos.tec.linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Joerg Roedel <joro@8bytes.org>
References: <CAHk-=whEQPvLpDbx+WR4Q4jf2FxXjf_zTX3uLy_6ZzHtgTV4LA@mail.gmail.com>
 <156094799629.21217.4574572565333265288@skylake-alporthouse-com>
 <CAHk-=wjhJNKVfHgwd0QX_bq769sxfP4jvfy0dd-WtFMfdivMwg@mail.gmail.com>
 <156097197830.664.13418742301997062555@skylake-alporthouse-com>
 <CAHk-=wjoeZ9_aiu+642ur=iGhGjfBQhRPURxX9Py+-B6coctXw@mail.gmail.com>
 <alpine.DEB.2.21.1906211725200.5503@nanos.tec.linutronix.de>
 <156114224132.2401.13297188928702045223@skylake-alporthouse-com>
 <alpine.DEB.2.21.1906212130230.5503@nanos.tec.linutronix.de>
Message-ID: <156114697311.2401.13492363493607545412@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: NMI hardlock stacktrace deadlock [was Re: Linux 5.2-rc5]
Date:   Fri, 21 Jun 2019 20:56:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Thomas Gleixner (2019-06-21 20:33:36)
> On Fri, 21 Jun 2019, Chris Wilson wrote:
> 
> > Quoting Thomas Gleixner (2019-06-21 16:30:52)
> > > Chris, do you have the actual NMI lockup detector splats somewhere?
> > 
> > Sorry, I'm having a hard time reproducing this at will now. The test
> > case depends on the right timing of the wrong event to cause the GPU to
> > hang.
> > 
> > From memory, I got the
> >       "Watchdog detected hard LOCKUP on cpu foo"
> > followed by the register dump and then nothing. At which point I had to
> > power cycle the machine.
> 
> Hmm. Do you have a serial log of that incident?

I use netconsole. I think Tomi has a serial console for most things
available, but not permanently hooked up. And I didn't have it in a tee
as it was late, with the lockup an annoyance to the bug I was trying
to solve. I'll keep trying to recreate that bug as once I do have that
recipe, it should be possible to bisect. I can check with Tomi on Monday
if he can pull a machine out of the farm and see how it locked up.
-Chris

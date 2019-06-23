Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691B8C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 10:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F91320679
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 10:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfFWKcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 06:32:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33163 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbfFWKcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 06:32:20 -0400
X-Greylist: delayed 825 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Jun 2019 06:32:19 EDT
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1heznB-0007bM-ND; Sun, 23 Jun 2019 12:32:13 +0200
Date:   Sun, 23 Jun 2019 12:32:13 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] time: hrtimer: use a bullet for the returns bullet
 list
In-Reply-To: <20190620171617.3368f30b@coco.lan>
Message-ID: <alpine.DEB.2.21.1906231228080.32342@nanos.tec.linutronix.de>
References: <a83ea390bc28784518fce772b4c961ea1c976f14.1560883872.git.mchehab+samsung@kernel.org> <a4cab6020e0475e7a4afc65dc5854756dd1bfbe9.1560883872.git.mchehab+samsung@kernel.org> <20190620140233.3d7202ee@lwn.net> <20190620171617.3368f30b@coco.lan>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1631302952-1561285808=:32342"
Content-ID: <alpine.DEB.2.21.1906231230220.32342@nanos.tec.linutronix.de>
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1631302952-1561285808=:32342
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.21.1906231230221.32342@nanos.tec.linutronix.de>

On Thu, 20 Jun 2019, Mauro Carvalho Chehab wrote:
> Em Thu, 20 Jun 2019 14:02:33 -0600
> Jonathan Corbet <corbet@lwn.net> escreveu:
> > On Tue, 18 Jun 2019 15:51:20 -0300
> > Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> > >   * Returns:
> > > - *  0 when the timer was not active
> > > - *  1 when the timer was active
> > > - * -1 when the timer is currently executing the callback function and
> > > + *
> > > + *  •  0 when the timer was not active
> > > + *  •  1 when the timer was active
> > > + *  • -1 when the timer is currently executing the callback function and
> > >   *    cannot be stopped  
> > 
> > So I have taken some grief for letting non-ASCII stuff into the docs
> > before; I can only imagine that those who object would be even more
> > unhappy to see it in a C source file.  I'm all for fixing the warning, but
> > I think we shouldn't start introducing exotic characters at this point...
> 
> According to:
> 	http://docutils.sourceforge.net/docs/ref/rst/restructuredtext.html#bullet-lists
> 
> The ASCII options are: "-", "+" or "*".
> 
> Both signs ('-' and '+') aren't too nice here, due to "-1".
> 
> So, what's left is '*'.
> 
> I remember someone once complained about having something like:
> 
> 	* * -1 when the ...

I'm fine with that.
 
> But if you think we shouldn't use UTF-8 chars, be it.

I don't even know how to write them in the first place.
 
> Feel free to replace it at the patch, or if you prefer, I'll send a new
> version tomorrow.

Yes, please.

And while at it please fix the subject line. The usual prefix for hrtimer
is surprisingly 'hrtimer:' and not 'time: hrtimer:'. Also please start the
short sentence after the prefix with an uppercase character.

Thanks,

	tglx
--8323329-1631302952-1561285808=:32342--

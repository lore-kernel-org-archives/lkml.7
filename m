Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148C2C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3FCF21881
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404171AbfHHQs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 12:48:27 -0400
Received: from smtprelay0053.hostedemail.com ([216.40.44.53]:54300 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728289AbfHHQs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 12:48:27 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id CE7B9100E86C3;
        Thu,  8 Aug 2019 16:48:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: apple91_8397350969e63
X-Filterd-Recvd-Size: 2983
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Thu,  8 Aug 2019 16:48:24 +0000 (UTC)
Message-ID: <89848a6b90c81be5bac50cdb49847462def5653c.camel@perches.com>
Subject: Re: [PATCH] isdn: hysdn: Fix error spaces around '*'
From:   Joe Perches <joe@perches.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Karsten Keil <isdn@linux-pingi.de>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        Jose Carlos Cazarin Filho <joseespiriki@gmail.com>,
        isdn@linux-pingi.de, devel@driverdev.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 08 Aug 2019 09:48:22 -0700
In-Reply-To: <20190808164020.GA9453@kroah.com>
References: <20190802195602.28414-1-joseespiriki@gmail.com>
         <20190802145506.168b576b@hermes.lan>
         <2ecfbf8dda354fe47912446bf5c3fe30ca905aa0.camel@perches.com>
         <20190808163905.GA9224@kroah.com> <20190808164020.GA9453@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-08 at 18:40 +0200, Greg KH wrote:
> On Thu, Aug 08, 2019 at 06:39:05PM +0200, Greg KH wrote:
> > On Fri, Aug 02, 2019 at 03:05:05PM -0700, Joe Perches wrote:
> > > On Fri, 2019-08-02 at 14:55 -0700, Stephen Hemminger wrote:
> > > > On Fri,  2 Aug 2019 19:56:02 +0000
> > > > Jose Carlos Cazarin Filho <joseespiriki@gmail.com> wrote:
> > > > 
> > > > > Fix checkpath error:
> > > > > CHECK: spaces preferred around that '*' (ctx:WxV)
> > > > > +extern hysdn_card *card_root;        /* pointer to first card */
> > > > > 
> > > > > Signed-off-by: Jose Carlos Cazarin Filho <joseespiriki@gmail.com>
> > > > 
> > > > Read the TODO, these drivers are scheduled for removal, so changes
> > > > are not helpful at this time.
> > > 
> > > Maybe better to mark the MAINTAINERS entry obsolete so
> > > checkpatch bleats a message about unnecessary changes.
> > > ---
> > >  MAINTAINERS | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 30bf852e6d6b..b5df91032574 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -8628,7 +8628,7 @@ M:	Karsten Keil <isdn@linux-pingi.de>
> > >  L:	isdn4linux@listserv.isdn4linux.de (subscribers-only)
> > >  L:	netdev@vger.kernel.org
> > >  W:	http://www.isdn4linux.de
> > > -S:	Odd Fixes
> > > +S:	Obsolete
> > >  F:	Documentation/isdn/
> > >  F:	drivers/isdn/capi/
> > >  F:	drivers/staging/isdn/
> > > 
> > 
> > Good idea, will take this patch now, thanks.
> 
> Can you resend this with a s-o-b so I can apply it?
> 
> thanks,

Hey Greg.  It was just an idea and an example.
I'm sure you can figure out if you want it.
No need for my SOB really.

btw: Karsten hasn't acked a patch or been active
in 3+ years.  Maybe he should go into CREDITS.




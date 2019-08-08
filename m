Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326A6C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F356D2184E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565282425;
	bh=IHtsDi+gxFqVOzzgE355F6Bz9tWdXk5RvOnxv8yWTSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LNYN0gtDrn11efyE6yq1wKDxXbP+1h7UNflt+L6k8hgDmEcjibn/TLNF8x8qE/suI
	 6J6gKmOv+R6UsUzVsJScEuJC0B98hhG0busM6KDPm7AxHsID0WN4p7SugCPSTKQwiV
	 5cwoJiUDgNhMTYF43nvCVNpRIDDw1fZTQfdZ2Etk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390184AbfHHQkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 12:40:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:50822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727096AbfHHQkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 12:40:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7930217F4;
        Thu,  8 Aug 2019 16:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565282422;
        bh=IHtsDi+gxFqVOzzgE355F6Bz9tWdXk5RvOnxv8yWTSk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ip5jOajFODXTFPX2Kfq71umTtXjA3AeD3LMdvALW23Wjjr+tleVlSk3OFqBgryeA4
         ujxfgjDFgTMyoBXzvg4ZZweNDvAe4orZN3vLo4kInvIc+cSoNbPmf1/ZJ77k+6zT7j
         6YXIRE/a3jJpoKI/vMWfGkNTdzdjxtZdwMAokCCo=
Date:   Thu, 8 Aug 2019 18:40:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        Jose Carlos Cazarin Filho <joseespiriki@gmail.com>,
        isdn@linux-pingi.de, devel@driverdev.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isdn: hysdn: Fix error spaces around '*'
Message-ID: <20190808164020.GA9453@kroah.com>
References: <20190802195602.28414-1-joseespiriki@gmail.com>
 <20190802145506.168b576b@hermes.lan>
 <2ecfbf8dda354fe47912446bf5c3fe30ca905aa0.camel@perches.com>
 <20190808163905.GA9224@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808163905.GA9224@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 06:39:05PM +0200, Greg KH wrote:
> On Fri, Aug 02, 2019 at 03:05:05PM -0700, Joe Perches wrote:
> > On Fri, 2019-08-02 at 14:55 -0700, Stephen Hemminger wrote:
> > > On Fri,  2 Aug 2019 19:56:02 +0000
> > > Jose Carlos Cazarin Filho <joseespiriki@gmail.com> wrote:
> > > 
> > > > Fix checkpath error:
> > > > CHECK: spaces preferred around that '*' (ctx:WxV)
> > > > +extern hysdn_card *card_root;        /* pointer to first card */
> > > > 
> > > > Signed-off-by: Jose Carlos Cazarin Filho <joseespiriki@gmail.com>
> > > 
> > > Read the TODO, these drivers are scheduled for removal, so changes
> > > are not helpful at this time.
> > 
> > Maybe better to mark the MAINTAINERS entry obsolete so
> > checkpatch bleats a message about unnecessary changes.
> > ---
> >  MAINTAINERS | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 30bf852e6d6b..b5df91032574 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -8628,7 +8628,7 @@ M:	Karsten Keil <isdn@linux-pingi.de>
> >  L:	isdn4linux@listserv.isdn4linux.de (subscribers-only)
> >  L:	netdev@vger.kernel.org
> >  W:	http://www.isdn4linux.de
> > -S:	Odd Fixes
> > +S:	Obsolete
> >  F:	Documentation/isdn/
> >  F:	drivers/isdn/capi/
> >  F:	drivers/staging/isdn/
> > 
> 
> Good idea, will take this patch now, thanks.

Can you resend this with a s-o-b so I can apply it?

thanks,

greg k-h

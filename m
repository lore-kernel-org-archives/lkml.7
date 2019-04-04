Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7E9C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E96206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731212AbfDDUsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 16:48:20 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:33544 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbfDDUsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 16:48:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id D7B648120;
        Thu,  4 Apr 2019 22:48:17 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QWd4y6r4-Af5; Thu,  4 Apr 2019 22:48:17 +0200 (CEST)
Received: from function (105.251.129.77.rev.sfr.net [77.129.251.105])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 47E7D8108;
        Thu,  4 Apr 2019 22:48:17 +0200 (CEST)
Received: from samy by function with local (Exim 4.92)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1hC9HT-0003oh-91; Thu, 04 Apr 2019 22:48:15 +0200
Date:   Thu, 4 Apr 2019 22:48:15 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Okash Khawaja <okash.khawaja@gmail.com>,
        Gregory Nowak <greg@gregn.net>, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, Kirk Reiser <kirk@reisers.ca>,
        Peter Hurley <peter@hurleysoftware.com>,
        Jiri Slaby <jslaby@suse.com>, speakup@linux-speakup.org,
        John Covici <covici@ccs.covici.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Chris Brannon <chris@the-brannons.com>
Subject: Re: [PATCH 1/2] vt: selection: allow functions to be called from
 inside kernel
Message-ID: <20190404204815.y6gcxsuvrftqxeyi@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Okash Khawaja <okash.khawaja@gmail.com>,
        Gregory Nowak <greg@gregn.net>, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, Kirk Reiser <kirk@reisers.ca>,
        Peter Hurley <peter@hurleysoftware.com>,
        Jiri Slaby <jslaby@suse.com>, speakup@linux-speakup.org,
        John Covici <covici@ccs.covici.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Chris Brannon <chris@the-brannons.com>
References: <20190404194530.1170-1-okash.khawaja@gmail.com>
 <20190404194530.1170-2-okash.khawaja@gmail.com>
 <20190404203549.GA9319@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404203549.GA9319@kroah.com>
Organization: I am not organized
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH, le jeu. 04 avril 2019 22:35:49 +0200, a ecrit:
> On Thu, Apr 04, 2019 at 08:45:29PM +0100, Okash Khawaja wrote:
> > diff --git a/include/linux/selection.h b/include/linux/selection.h
> > index a8f5b97b216f..171d77dfc825 100644
> > --- a/include/linux/selection.h
> > +++ b/include/linux/selection.h
> > @@ -11,13 +11,12 @@
> >  #include <linux/tiocl.h>
> >  #include <linux/vt_buffer.h>
> >  
> > -struct tty_struct;
> > -
> 
> Nit, why remove these lines?

The same line shows up already just a couple of lines below, so it's
just a clean-up along the way.

Samuel

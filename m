Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0CAC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0DA21904
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CFjBP9KV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbfDXM6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:58:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53424 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbfDXM6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:58:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YQUnRZxjEBCnKH8zfJAZRfS63f1s0iUs9w+T9MeY1gk=; b=CFjBP9KV1A49YynjXl4/1LA0V
        lJpGvP/g7dgOC7LPAcndP0aGjqT4sPeJasASUF87IJ5vCIWF/UxH63xdjI7TUAG9ShHcTng3v2Efy
        KmcbFUxRZ+Po7jl1pSXGlikOUAM/tjsbuP6S9o/gVT2+fKEQ3w009J+7v1iJaqk9rccIM8AhlUbHK
        4Cj/7klRS9ovGZOT7ioE8kew22vAcl+DeD58qokmpMvyWUhqGogeaFdgjuagtPh+oVWPL4X09mZpD
        SDJUb1pnEY6c1rrrTF/4yEecGStkL7n2cPXoSw9YLmelO7StEr48Zrj3Oexje2NV2xfV6d30Xv2XE
        X8DyLD31g==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJHTM-0002cO-Pv; Wed, 24 Apr 2019 12:58:01 +0000
Date:   Wed, 24 Apr 2019 09:57:56 -0300
From:   Mauro Carvalho Chehab <mchehab@infradead.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 56/79] docs: Documentation/*.txt: rename all ReST
 files to *.rst
Message-ID: <20190424095756.73b8981f@coco.lan>
In-Reply-To: <20190424115126.GC6278@rapoport-lnx>
References: <20190423132100.GB7132@redhat.com>
        <cover.1555938375.git.mchehab+samsung@kernel.org>
        <cda57849a6462ccc72dcd360b30068ab6a1021c4.1555938376.git.mchehab+samsung@kernel.org>
        <20190423083135.GA11158@hirez.programming.kicks-ass.net>
        <20190423125519.GA7104@redhat.com>
        <20190423130132.GT4038@hirez.programming.kicks-ass.net>
        <20704.1556031146@warthog.procyon.org.uk>
        <20190423105415.3a69a0cb@lwn.net>
        <20190423172641.612012c8@coco.lan>
        <20190424115126.GC6278@rapoport-lnx>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 24 Apr 2019 14:51:26 +0300
Mike Rapoport <rppt@linux.ibm.com> escreveu:

> On Tue, Apr 23, 2019 at 05:26:41PM -0300, Mauro Carvalho Chehab wrote:
> > Em Tue, 23 Apr 2019 10:54:15 -0600
> > Jonathan Corbet <corbet@lwn.net> escreveu:
> > 
> > > On Tue, 23 Apr 2019 15:52:26 +0100
> > > David Howells <dhowells@redhat.com> wrote:
> > > 
> > > Suggestions / patches on how to improve things for *all* users of the
> > > docs are certainly welcome!
> > > 
> > > I am, incidentally, toying with the idea of trying to put together a
> > > documentation microconf at the Linux Plumbers Conference this year.  If
> > > anybody out there thinks that's a good idea and would like to
> > > participate, please let me know.
> > 
> > If you add a microconf to LPC, I'm in. 
> 
> +1
>  
> > IMO, we made big advances with documentation, but there's a lot more
> > to be done. Having a microconf to discuss those things may help us
> > to bring new ideas about how to keep improving it.
> 
> The most difficult part, IMHO, is to convince people to document things ;-)

As David mentioned, maintainers could enforce merging new APIs
only with documentation, with the risk of being unpopular. 

Well, maintainers are not among the most loved ones anyway ;-)
<sarcasm/>

My experience enforcing it at media subsystem is that it is not
that hard to have developers writing documentation, once it
becomes a rule, and the maintainers give the example.

The big problem is how to deal with legacy stuff. I had to do that
myself for the DVB subsystem, where the documentation were frozen back 
on 2002 days, while lots of new stuff got added (and, worse than that,
with some very obscure ioctls that is used only by a single driver and
some that were used only by OOT drivers). 

It take a few years to put it in sync with the code, but, once the 
ReST conversion was done, it became easier to do the work.

Thanks,
Mauro

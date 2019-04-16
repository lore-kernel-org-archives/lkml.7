Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07916C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8BA22077C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555414549;
	bh=MH0dFSVXzCVDjHjCHT7s/sHMCcAkAdJfHZOq3AairTM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=iwg8aAF+JpHMgOV0H0AwMn6tZQwUi1ac5YY/NVrL7GOWYVnZcv8E8jf/HdhxLrOAL
	 u6Kbdux+LEEF8ocgZP5vC5ETFlQQ86grdfZ+gB+jHzPH3aDwGYdo/uGa0Nt81IdquU
	 G2lEWzGM1c+0f/QIWgOsY+aB76zhWPPLt9sdWY7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbfDPLft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:35:49 -0400
Received: from casper.infradead.org ([85.118.1.10]:57466 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbfDPLfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zcGftKM5cHuD9u74AreR2J9u/eutxvpid7fH5uK59eo=; b=YQd9NQSWFk5DNYVHOgmKMh6FAA
        EPnZsj+7OFaYCx7jaGuOIvgjYAq3EUEok/QeYWJN0jEswfKG6nLfeCYAK7rZKt9Uij01WJO9nlqIu
        kHQN85p2t0xXrHas1jLLfpZFc3+VdarZZrYKhwRfbXMDyCX34VozibHHrioAfCNmKXwaoY/prG1Vr
        Cn/dgPWAankIMrgBn1wRL6iEkcalv+nlaFtzegW2COO/Vti9dkntgbHkbSpeIQuhtb+CvZ5f55Wfp
        YIdjP+AkonItqTFqwTIxQeRxOMOOD7RLzIz6kE2J5pI/yeWKhjILaE28ryelAOq4ybIVmpvee+6dC
        SEPPwBNw==;
Received: from 177.205.118.176.dynamic.adsl.gvt.net.br ([177.205.118.176] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGMNN-0007mG-EC; Tue, 16 Apr 2019 11:35:45 +0000
Date:   Tue, 16 Apr 2019 08:35:41 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 46/57] docs: cma/debugfs.txt: convert to ReST and move
 to admin-guide/mm
Message-ID: <20190416083541.7d126935@coco.lan>
In-Reply-To: <20190416052159.GB27735@rapoport-lnx>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
        <fad74a378f3e988c9519a784bed2a5b4aa471482.1555382110.git.mchehab+samsung@kernel.org>
        <20190416052159.GB27735@rapoport-lnx>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 16 Apr 2019 08:21:59 +0300
Mike Rapoport <rppt@linux.ibm.com> escreveu:

> Hi Mauro,
> 
> On Mon, Apr 15, 2019 at 11:56:11PM -0300, Mauro Carvalho Chehab wrote:
> > The debugfs interface for CMA should be there together with other
> > mm-related documents.
> > 
> > Convert this small file to ReST and move it to its rightful place.
> > 
> > The conversion is actually quite simple: just add a title for the
> > document. In order to make it to look better for the audience,
> > also mark the "echo" command as a literal block.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > ---
> >  Documentation/cma/debugfs.txt | 6 +++++-  
>  
> It wasn't really moved ;-)

Heh, yeah! The original patch was moving it:

	https://git.linuxtv.org/mchehab/experimental.git/commit/?h=all_with_indexes&id=e02d3ba65eba1676b01c82988b8054b88e6e5cdc

It seems I forgot to fix the comment here.

I opted to do just the conversion and place the move patch on a separate
series (yet to be submitted), in order to avoid merge conflicts.

> 
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/cma/debugfs.txt b/Documentation/cma/debugfs.txt
> > index 6cef20a8cedc..4e06ffabd78a 100644
> > --- a/Documentation/cma/debugfs.txt
> > +++ b/Documentation/cma/debugfs.txt
> > @@ -1,3 +1,7 @@
> > +=====================
> > +CMA Debugfs Interface
> > +=====================
> > +
> >  The CMA debugfs interface is useful to retrieve basic information out of the
> >  different CMA areas and to test allocation/release in each of the areas.
> > 
> > @@ -12,7 +16,7 @@ The structure of the files created under that directory is as follows:
> >   - [RO] count: Amount of memory in the CMA area.
> >   - [RO] order_per_bit: Order of pages represented by one bit.
> >   - [RO] bitmap: The bitmap of page states in the zone.
> > - - [WO] alloc: Allocate N pages from that CMA area. For example:
> > + - [WO] alloc: Allocate N pages from that CMA area. For example::
> > 
> >  	echo 5 > <debugfs>/cma/cma-2/alloc
> > 
> > -- 
> > 2.20.1
> >   
> 



Thanks,
Mauro

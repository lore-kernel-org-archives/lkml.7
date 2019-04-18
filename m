Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3234CC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 23:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB062087F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 23:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555629237;
	bh=Ku39EChWNh6dm6jAN6WRhJ7jJVngc2TkR+TnIUJLCt4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=pO5hXSkuQeqDy6f73SbwTeyZ0FWM8QQjY5b9fGReEryaFPmLK2yZ/s/66I4zLrHsR
	 jXXuUyHlQXS3xx/miFwmTVzRbUwLysdzix2Nxmw6n3D9B67Y2/Elwrc2EXMsmBNcIU
	 4v+Fy+R27xQW6KHWsLxko7PPVMaZiHUfv/BSSDZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfDRXN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 19:13:56 -0400
Received: from casper.infradead.org ([85.118.1.10]:44080 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfDRXNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 19:13:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oIV8JCP5QbONJPn1jmgevBSwiHtpslE8bP9Xf28NwSM=; b=PnL0yMHqKMsBTJC/yJLMLnYNwX
        OfLtJ1BbZEXwCv2eQcFig3cnkzEjw8HzEIhkl+hgOb6lAOeNXHo7L4aLLCsJBfxq/at845y+0q7kJ
        PGMnx09RdA4kHCWi8wxKtfbdg2KgdqszjYmp+wdZ8m/bljWNpT0Ktjnq1jsVuHrTedmUcdDR/Oo1E
        3x5H1Yy8cNfMZXJjqJEi+AIHBef+vZ7jXbY9V1ooXwXqMYJqpDUQ9FGp0nGWN6X6GUS4Q1/S2t5yT
        wIYvgHnQAhNG0slcJf9p8JzwGqP9gMDwiA14Aa1KebB1GA6mg2zxujjGbADz+cqPnmrjb5IAmoASF
        BpOmuYqg==;
Received: from 177.132.233.55.dynamic.adsl.gvt.net.br ([177.132.233.55] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hHFsu-00062h-FU; Thu, 18 Apr 2019 22:52:01 +0000
Date:   Thu, 18 Apr 2019 19:51:53 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Subject: Re: [PATCH] docs: core-api: fix broken references for div64.c and
 gcd.c
Message-ID: <20190418195153.4708cbc7@coco.lan>
In-Reply-To: <f1ccd7d6-c5c7-f558-18a9-1c2602a2ef84@infradead.org>
References: <734f49bae5d4052b3c25691dfefad59bea2e5843.1555580999.git.mchehab+samsung@kernel.org>
        <f1ccd7d6-c5c7-f558-18a9-1c2602a2ef84@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 18 Apr 2019 14:59:41 -0700
Randy Dunlap <rdunlap@infradead.org> escreveu:

> On 4/18/19 2:50 AM, Mauro Carvalho Chehab wrote:
> > Those files were moved to lib/math.
> > 
> > Fixes: 9635bad21596 ("lib: Move mathematic helpers to separate folder")  
> 
> Is that commid ID in mainline?  I get:
> fatal: ambiguous argument '9635bad21596': unknown revision or path not in the working tree.

No, it is on Linux-next.

> 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>  
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Thanks.
> 
> > ---
> >  Documentation/core-api/kernel-api.rst | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/core-api/kernel-api.rst b/Documentation/core-api/kernel-api.rst
> > index 71f5d2fe39b7..a29c99d13331 100644
> > --- a/Documentation/core-api/kernel-api.rst
> > +++ b/Documentation/core-api/kernel-api.rst
> > @@ -147,10 +147,10 @@ Division Functions
> >  .. kernel-doc:: include/linux/math64.h
> >     :internal:
> >  
> > -.. kernel-doc:: lib/div64.c
> > +.. kernel-doc:: lib/math/div64.c
> >     :functions: div_s64_rem div64_u64_rem div64_u64 div64_s64
> >  
> > -.. kernel-doc:: lib/gcd.c
> > +.. kernel-doc:: lib/math/gcd.c
> >     :export:
> >  
> >  UUID/GUID
> >   
> 
> 



Thanks,
Mauro

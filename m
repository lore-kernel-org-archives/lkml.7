Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3FCC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 10:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0769221773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 10:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555497090;
	bh=nPMoLBZCraD90y7DaZFFaNBL8sGdPoDVWQQUYJkll00=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=m5JtMqHQ7HfpROPs8RYn44O3FdzKnhZG5H/nueNIPUwjPR5+U5oNY9d8sBRfzPTuU
	 on9ML7uM8bXqAAFeckVRgdjugtqqlGHRiRohnGbMlTgl3Yu7b2cA3Ymp/eHSx8pkdX
	 y5kC0OYHuYgZ2xceDGE9hcAxNhz8aTDjtrAr9eEU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731756AbfDQKb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 06:31:28 -0400
Received: from casper.infradead.org ([85.118.1.10]:34152 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728575AbfDQKb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 06:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hRc5GT91Tnnpy8NVtnlbZePFNQeVKHOM/AItPJn934U=; b=pBWDvG/eWFaH2M7tinqaQO1MzX
        W8myUlxTYowA++qiQ8lsN2BdWIqk7QE2rBHtwvjqQWZZUjF5NwYbmlTQM4yOZ6x//mNqozLkSKp2K
        S9v8pmCi6CGONozYFFQNHunCk1XKrNaJX8EGTOOTdLpk+X59BzDevF48an2ZpnVutxkZExlBOsjzR
        ua9mlWnueES6rC6q/nyEHfP3olaDtjOFgdJ8+7eEmafyoNpZlJj1k5oUwLrz4ES8Is9G9dCaIFHOG
        AeDixRJ1nelLB/fcUVI8jxod+KDIn/Kt1dS7P6An8X1o69IDbin1D/z56d1ua+5i9Oq7htYFq95B8
        kF+o/raA==;
Received: from 177.132.233.55.dynamic.adsl.gvt.net.br ([177.132.233.55] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGhqc-0001Hh-H3; Wed, 17 Apr 2019 10:31:23 +0000
Date:   Wed, 17 Apr 2019 07:31:17 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Liviu Dudau <liviu.dudau@arm.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 02/21] docs: hwmon: vexpress: convert to ReST format
Message-ID: <20190417073117.27436037@coco.lan>
In-Reply-To: <20190417102415.GU15144@e110455-lin.cambridge.arm.com>
References: <cover.1555494108.git.mchehab+samsung@kernel.org>
        <7f3e72d30c341b48d344110925a4f5fb3c92fe3c.1555494108.git.mchehab+samsung@kernel.org>
        <20190417102415.GU15144@e110455-lin.cambridge.arm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 17 Apr 2019 11:24:15 +0100
Liviu Dudau <liviu.dudau@arm.com> escreveu:

> On Wed, Apr 17, 2019 at 06:46:10AM -0300, Mauro Carvalho Chehab wrote:
> > Convert vexpress to ReST format, in order to allow it to
> > be parsed by Sphinx.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > ---
> >  Documentation/hwmon/vexpress | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/hwmon/vexpress b/Documentation/hwmon/vexpress
> > index 557d6d5ad90d..8c861c8151ac 100644
> > --- a/Documentation/hwmon/vexpress
> > +++ b/Documentation/hwmon/vexpress
> > @@ -2,14 +2,21 @@ Kernel driver vexpress
> >  ======================
> >  
> >  Supported systems:
> > +
> >    * ARM Ltd. Versatile Express platform
> > +
> >      Prefix: 'vexpress'
> > +
> >      Datasheets:
> > +
> >        * "Hardware Description" sections of the Technical Reference Manuals
> > -        for the Versatile Express boards:
> > -        http://infocenter.arm.com/help/topic/com.arm.doc.subset.boards.express/index.html
> > +	for the Versatile Express boards:
> > +
> > +	- http://infocenter.arm.com/help/topic/com.arm.doc.subset.boards.express/index.html
> > +
> >        * Section "4.4.14. System Configuration registers" of the V2M-P1 TRM:
> > -        http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0447-/index.html
> > +
> > +	- http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0447-/index.html
> >  
> >  Author: Pawel Moll  
> 
> I've acked this at v2 and I can't see any differences. 

Sorry, I forgot to include the acks.

It shouldn't have any difference here (except for context
lines, if any). The main goal of this was to rebase, per
Guenter request, in order to apply over the top of linux-next.

The only non-context changes were on patches 11, 16 and 20.

The past version was based on docs-next.

> Do you now want
> my Acks and prefer to get Pawel's?

Yeah, please send your acks. 

> 
> Best regards,
> Liviu
> 
> >  
> > -- 
> > 2.20.1
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel  
> 



Thanks,
Mauro

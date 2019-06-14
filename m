Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87816C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D00421841
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560529539;
	bh=D5nS/YCyDNPrbX79R8aCWuZLKbjMoSH4y/QJx/I8FLQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=k0CajHBCIWukkFJ63zxGXcMOpgPKGtJV5gR/6PoU7IbsQGN55UVyBb92r3gtSyicj
	 ZEwSMrOwQfrjBjQvzDKhYrP/PUrsR2SQRS4JOsEpSXcWP6a/TgzOrrdhQTAHN6vIJq
	 /MHgTYRtCuLVAJRj4KSUlC4226vzZvyxH96Tf8+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbfFNQZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 12:25:37 -0400
Received: from casper.infradead.org ([85.118.1.10]:51562 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfFNQZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 12:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IcB8Qtn20XD6wa+i2Z9SDUlZtL7QkC604Nkf72H6uDU=; b=ctsVO+sierkxgO6mEY+Zu89VZL
        fbNLcgtVP7hVjxhraq4u5XHoEd/3a7Gg+TGKFrIZgiCl5RvX2g8pXk3Vw7ZJvDDNStpwZY2xL4A3H
        u+fQ9fSQZgbIlaPKWLZ01GgvCkRo4AeoOJf3+NCMdnAhAAzoSwNO7KkodhvWjHLm34KD6GZI2EGR0
        YpKBfXA3yVaw/TRklXHZFKY1NOqCQkamZbVPq3RCO6DaxEyRU9tJBbTVlgZ5I9DVhBLFJEdK6WwUI
        Z3g8/0ZsazIQ/UWN6kyG8lWAIWsf3wkzbXYBshKNfIVPnVlXjd/THG03Y1NSjDphSfV8vOasd3tGT
        AUo77vCA==;
Received: from 177.133.85.52.dynamic.adsl.gvt.net.br ([177.133.85.52] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbp1B-0003It-Te; Fri, 14 Jun 2019 16:25:34 +0000
Date:   Fri, 14 Jun 2019 13:25:30 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 14/14] docs: sphinx/kernel_abi.py: fix UTF-8 support
Message-ID: <20190614132530.7a013757@coco.lan>
In-Reply-To: <20190614161837.GA25206@kroah.com>
References: <cover.1560477540.git.mchehab+samsung@kernel.org>
        <62c8ffe86df40c90299e80619a1cb5d50971c2c6.1560477540.git.mchehab+samsung@kernel.org>
        <20190614161837.GA25206@kroah.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 14 Jun 2019 18:18:37 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:

> On Thu, Jun 13, 2019 at 11:04:20PM -0300, Mauro Carvalho Chehab wrote:
> > The parser breaks with UTF-8 characters with Sphinx 1.4.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > ---
> >  Documentation/sphinx/kernel_abi.py | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/sphinx/kernel_abi.py b/Documentation/sphinx/kernel_abi.py
> > index 7fa7806532dc..460cee48a245 100644
> > --- a/Documentation/sphinx/kernel_abi.py
> > +++ b/Documentation/sphinx/kernel_abi.py
> > @@ -1,4 +1,5 @@
> > -# -*- coding: utf-8; mode: python -*-
> > +# coding=utf-8
> > +#  
> 
> Is this an emacs vs. vim fight?

No. This is a python-specific thing:

	https://www.python.org/dev/peps/pep-0263/

> 
> Why change this?

Just to keep the "header" part of the script closer to kerneldoc.py. 

You may keep the previous syntax if you want, as both ways are
equally recognized, as python actually checks for anything that
matches this regex at the first or second line:

	^[ \t\f]*#.*?coding[:=][ \t]*([-_.a-zA-Z0-9]+)

Thanks,
Mauro

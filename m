Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2EFC072A4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 18:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4BE204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 18:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558378154;
	bh=WeLTTrHVKpCPVBwSMwE6UUicljkVbYcpB0VgU8AxSwk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ggasnjcjOuDdsWA7GXbTIDS0ide4jen3e2g+Sj+vHbMs1tNA1wp3kbbp7hyhrrpZa
	 XIheeqgqjRmWdqjUzCVrw2hnOc1DIOsZyOxIn36Ehmfzet5CGT/enD0LZJ3BM9vpQQ
	 /G7QUrCUAPVIuQ+zEd0MhCDYm/16zmSgTFANjANo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfETStK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 14:49:10 -0400
Received: from casper.infradead.org ([85.118.1.10]:45804 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfETStJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 14:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Wb+fGsrgFIO4zy7sbGCFYlIGC0R6uH3Db0pCCn/9dt4=; b=Zojqde4tw+V4l+BBfsSUN3yweL
        Chr1yFIu45bzFs5tkDp64cmzL0iufOPFd3do2BO9EZmOiYzMaicaNDhkTtqnACfcuTi1ooudTQl6c
        96K2oy9qZIWzjxrYXJAFIfc0l8SkM9NaizpnZc6XhV/9SKynE1CJuN8kiFJ+E478nu8kWA3KE5fvM
        Qt47HecgWugA6Dzgwd0EXLlq3GfOWE+jo+yiGwImf0EO+bZcgBaZyehdwez0fRAB4R6i3q48kHvLv
        71X8GLruich8FP6hrNNSsKJRn0Ax440FEE1AVyUmRW2MUPL9LsbIDywEBwgjvlo2hNv7wFwT8Kq/6
        duRMfX6w==;
Received: from 179.176.119.151.dynamic.adsl.gvt.net.br ([179.176.119.151] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hSnLM-0006ki-3Q; Mon, 20 May 2019 18:49:04 +0000
Date:   Mon, 20 May 2019 15:48:40 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lee Jones <lee.jones@linaro.org>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH 07/10] mfd: madera: point to the right pinctrl binding
 file
Message-ID: <20190520154840.64f91ad2@coco.lan>
In-Reply-To: <20190520154244.GA99937@ediswmail.ad.cirrus.com>
References: <cover.1558362030.git.mchehab+samsung@kernel.org>
        <fb47879d405e624374d7d4e099988296ed2af668.1558362030.git.mchehab+samsung@kernel.org>
        <20190520154244.GA99937@ediswmail.ad.cirrus.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 20 May 2019 16:42:45 +0100
Charles Keepax <ckeepax@opensource.cirrus.com> escreveu:

> On Mon, May 20, 2019 at 11:47:36AM -0300, Mauro Carvalho Chehab wrote:
> > The reference to Documentation/pinctrl.txt doesn't exist, but
> > there is an specific binding for the madera driver.
> > 
> > So, point to it.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > ---
> >  include/linux/mfd/madera/pdata.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/mfd/madera/pdata.h b/include/linux/mfd/madera/pdata.h
> > index 8dc852402dbb..c7e0658eb74b 100644
> > --- a/include/linux/mfd/madera/pdata.h
> > +++ b/include/linux/mfd/madera/pdata.h
> > @@ -34,7 +34,8 @@ struct madera_codec_pdata;
> >   * @micvdd:	    Substruct of pdata for the MICVDD regulator
> >   * @irq_flags:	    Mode for primary IRQ (defaults to active low)
> >   * @gpio_base:	    Base GPIO number
> > - * @gpio_configs:   Array of GPIO configurations (See Documentation/pinctrl.txt)
> > + * @gpio_configs:   Array of GPIO configurations
> > + *		    (See Documentation/devicetree/bindings/pinctrl/cirrus,madera-pinctrl.txt)  
> 
> I believe this is trying to point at the generic pinctrl docs
> which now live here:
> 
> Documentation/driver-api/pinctl.rst
> 
> There is a patch to do this already:
> https://lkml.org/lkml/2019/1/9/853
> With the latest resend here:
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2001752.html

Ah, makes sense to me. 

Please ignore this one.

Thanks,
Mauro

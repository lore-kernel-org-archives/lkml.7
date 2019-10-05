Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E173C4740A
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 18:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DC99222C8
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 18:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="hRYFS/Mh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387818AbfJEST1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 14:19:27 -0400
Received: from mail.andi.de1.cc ([85.214.55.253]:38204 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387486AbfJEST1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 14:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AyGFVjqrVQ7j5HVpExPglip8iVXDUbXdQbJqiWaitIQ=; b=hRYFS/MhMvVuxKp8UiIP/EdQ8k
        d0YuXD/CiUvHMrO0SZjGn00Zzuen4z7A2YKQ8IVbYS+QQpV0wKQI07sV3MTrbijfmsCI/OPQH2Raq
        SWy77I3EyDMxM4QDRIFeX4i/PwS6KUCF76k4gGcydNjcwdXRSj98r6Glu5YW6G960fC4=;
Received: from p5dc589a1.dip0.t-ipconnect.de ([93.197.137.161] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iGoeG-0002PT-Lg; Sat, 05 Oct 2019 20:19:20 +0200
Date:   Sat, 5 Oct 2019 20:19:19 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     lee.jones@linaro.org, jingoohan1@gmail.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        hns@goldelico.com
Subject: Re: [PATCH] backlight: lm3630a: fix module aliases
Message-ID: <20191005201919.013524da@aktux>
In-Reply-To: <20190911105148.4prmcr2f2r36sgrf@holly.lan>
References: <20190910152359.7448-1-andreas@kemnade.info>
        <20190911105148.4prmcr2f2r36sgrf@holly.lan>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

hmm, this bugfix has not arrived in -next or any -fixes branch I am
aware of yet. I hope it is not forgotten...
so a friendly ping.

Regards,
Andreas

On Wed, 11 Sep 2019 11:51:48 +0100
Daniel Thompson <daniel.thompson@linaro.org> wrote:

> On Tue, Sep 10, 2019 at 05:23:59PM +0200, Andreas Kemnade wrote:
> > Devicetree aliases are missing, so that module autoloading
> > does not work properly.
> > 
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>  
> 
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> 
> 
> > ---
> >  drivers/video/backlight/lm3630a_bl.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
> > index 3b45a1733198..9d67c07db2f2 100644
> > --- a/drivers/video/backlight/lm3630a_bl.c
> > +++ b/drivers/video/backlight/lm3630a_bl.c
> > @@ -617,12 +617,14 @@ static const struct i2c_device_id lm3630a_id[] = {
> >  	{}
> >  };
> >  
> > +MODULE_DEVICE_TABLE(i2c, lm3630a_id);
> > +
> >  static const struct of_device_id lm3630a_match_table[] = {
> >  	{ .compatible = "ti,lm3630a", },
> >  	{ },
> >  };
> >  
> > -MODULE_DEVICE_TABLE(i2c, lm3630a_id);
> > +MODULE_DEVICE_TABLE(of, lm3630a_match_table);
> >  
> >  static struct i2c_driver lm3630a_i2c_driver = {
> >  	.driver = {
> > -- 
> > 2.11.0
> >   
> 


Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96298C2D0CB
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 15:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6739E2253D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 15:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576424857;
	bh=XjShi8XS/8PUhktC4F3eX8csDaRH2Iuv8xA3ftPm/vU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=jqypgvNrfC/QC+YcM60+4+YZr9vxBKRuQ8s3GqWlEIVcGuwBK9PCM7eMVwVON+Eo5
	 xulkzO3HGiOhGmVOtrF+FBdlU4uwwitSTDnYClfPmgHaE1RRMsnTKGiP3wiG4PLPm8
	 CG4IBR3za4s+MCJp4mnUZxG1+i86Bz1zCKSiOOc0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfLOPrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 10:47:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:34330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbfLOPrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 10:47:36 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C59B0206E0;
        Sun, 15 Dec 2019 15:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576424855;
        bh=XjShi8XS/8PUhktC4F3eX8csDaRH2Iuv8xA3ftPm/vU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zV0ChaUK+XQo9dXAnA0Hlcqa07i+PRdoGvlRoULApU34AsdyvFljT27uxgDJCF0ce
         YHDjCYLraUoYhVBYEFfrMqPubq36HnBzznG0WynoPeI+rad7sAT0iKugRkTp6+ondq
         +rMh555ThSve3d5ynE/Y/BzW3g57A+hDjcApSIr8=
Date:   Sun, 15 Dec 2019 15:47:30 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "lkcamp@lists.libreplanetbr.org" <lkcamp@lists.libreplanetbr.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "djunho@gmail.com" <djunho@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH v2 1/4] iio: adc: ad7923: Remove the unused defines
Message-ID: <20191215154730.490b7f00@archlinux>
In-Reply-To: <17193a42835f41b4352855b1cbd1cb5cf74a6d66.camel@analog.com>
References: <20191210150811.3429-1-djunho@gmail.com>
        <20191210150811.3429-2-djunho@gmail.com>
        <17193a42835f41b4352855b1cbd1cb5cf74a6d66.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Dec 2019 07:26:07 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Tue, 2019-12-10 at 12:08 -0300, Daniel Junho wrote:
> > [External]
> > 
> > Removes the unused define AD7923_CHANNEL_x from the code.
> > 
> > Signed-off-by: Daniel Junho <djunho@gmail.com>
> > ---
> >  drivers/iio/adc/ad7923.c | 4 ----
> >  1 file changed, 4 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
> > index 3212eb4c0f25..969c06b7d2b7 100644
> > --- a/drivers/iio/adc/ad7923.c
> > +++ b/drivers/iio/adc/ad7923.c
> > @@ -29,10 +29,6 @@
> >  #define AD7923_PM_MODE_AS	(1)		/* auto shutdown */
> >  #define AD7923_PM_MODE_FS	(2)		/* full shutdown */
> >  #define AD7923_PM_MODE_OPS	(3)		/* normal operation */
> > -#define AD7923_CHANNEL_0	(0)		/* analog input 0 */
> > -#define AD7923_CHANNEL_1	(1)		/* analog input 1 */
> > -#define AD7923_CHANNEL_2	(2)		/* analog input 2 */
> > -#define AD7923_CHANNEL_3	(3)		/* analog input 3 */  
> 
> The fact that is not used, is not a problem really.
> This can serve as a "shortcut" for the datasheet.

In some cases I would agree, but here adding a definition to go from
a channel number in text to an actual number doesn't add anything.

If there mapping was more complex then it would be reasonable to have
defines, but here I can't see the point.

So let's keep the patch to drop them.  I'll pick it up whilst the
comments on patch 4 have been addressed.

Thanks,

Jonathan


> 
> We can leave this as-is [1], or remove it as you do [2], or an alternative
> would be [3]:
> #define AD7923_CHANNEL(x)      (x)       /* analog channel input */
> 
> I don't mind either of these 3 versions ([1], [2] or [3]).
> 
> I'll leave it to Jonathan's preference.
> 
> >  #define AD7923_SEQUENCE_OFF	(0)		/* no sequence fonction
> > */
> >  #define AD7923_SEQUENCE_PROTECT	(2)		/* no interrupt
> > write cycle */
> >  #define AD7923_SEQUENCE_ON	(3)		/* continuous sequence */  


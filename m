Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE92CC10F03
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 15:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADB5B21903
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 15:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552751984;
	bh=mVJarcQv/YHOjAk4T/YkGdhG6fG8rue5kalYxIcEXts=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=hhjXcoD0Djglj+P8mYgVkov/UxV4xBxERRSyfrhO3ETwF5ZUBlKoyhmtjqkArVCW2
	 KGjkmfdVH3Zby7ROQ5nRHDTfLJMF+GZytHgAI1owfmjA0ZuRIFTIgVn8+zjm4IJ9XV
	 c7iNJSiOV+gYcnyj3SxYx0h2WS0iyINfinwFoskI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfCPP7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 11:59:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:60572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbfCPP7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 11:59:43 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE6BB21900;
        Sat, 16 Mar 2019 15:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552751982;
        bh=mVJarcQv/YHOjAk4T/YkGdhG6fG8rue5kalYxIcEXts=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YvcMRp+AkT2n5gSDTBYyVRbUx5XjXl/s3sTJ0Nui54zb+fzMxHybCFmwdxwUkXsnP
         DQY0wDTZjQaaC8rnCF6/8K+4wtDjKyeo1QBZ/iKOCmq45yBDj90lKSl4cyOy3EMaOa
         yXIV+F11rjRCThM7JCY1PUtnRHYcgW8jp7OcMmwM=
Date:   Sat, 16 Mar 2019 15:59:36 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Karen Palacio <karen.palacio.1994@gmail.com>,
        devel@driverdev.osuosl.org, lars@metafoo.de,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, knaack.h@gmx.de,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: Re: [PATCH] staging: iio: adc: ad7192: Add spaces around minus
 operator
Message-ID: <20190316155936.4af7ad9d@archlinux>
In-Reply-To: <20190311083159.GE2434@kadam>
References: <1552252931-10592-1-git-send-email-karen.palacio.1994@gmail.com>
        <CA+U=Dso8UzRFcHj-2Ss08DmykuXaTzbYmtj3F40tzchgvb7zBw@mail.gmail.com>
        <20190311083159.GE2434@kadam>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2019 11:31:59 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> On Mon, Mar 11, 2019 at 10:12:48AM +0200, Alexandru Ardelean wrote:
> > On Sun, Mar 10, 2019 at 11:23 PM Karen Palacio
> > <karen.palacio.1994@gmail.com> wrote:  
> > >
> > > Add spaces around minus operator to fix readibility.
> > >
> > > Signed-off-by: Karen Palacio <karen.palacio.1994@gmail.com>
> > > ---
> > >  drivers/staging/iio/adc/ad7192.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> > > index acdbc07..7c632cf 100644
> > > --- a/drivers/staging/iio/adc/ad7192.c
> > > +++ b/drivers/staging/iio/adc/ad7192.c
> > > @@ -355,7 +355,7 @@ ad7192_show_scale_available(struct device *dev,
> > >  }
> > >
> > >  static IIO_DEVICE_ATTR_NAMED(in_v_m_v_scale_available,
> > > -                            in_voltage-voltage_scale_available,
> > > +                            in_voltage - voltage_scale_available,  
> > 
> > This isn't broken, but I do agree it should be addressed.
> > I think it's the second time I see a similar patch trying to fix this.
> > So, obviously the code is a bit misleading.
> >   
> 
> It's got to be more than that.  I did a simple grep of my inbox and it
> says that this is the 13th time someone has tried to do this.  It's
> possible that my grep is wrong, 13 seems high but not totaly impossible.

That sounds about right.

Best bet is to move this over to the read_avail callback and do it using
the core handling for available attributes which will build the name
in code so checkpatch won't find it.

Anyone want to spin up a patch to do that and save anyone else wasting
time on this?  Or we could just put a comment right next to it and hope
people read it..  

Thanks,

Jonathan

> 
> regards,
> dan carpenter
> 


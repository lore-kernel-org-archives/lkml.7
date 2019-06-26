Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54583C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 20:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B74E2085A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 20:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfFZUYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 16:24:38 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:36568 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfFZUYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 16:24:38 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 1DF5B9E751C;
        Wed, 26 Jun 2019 21:24:35 +0100 (BST)
Date:   Wed, 26 Jun 2019 21:24:34 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: ABI: Add missing newline at end of file
Message-ID: <20190626212434.1b78b49e@archlinux>
In-Reply-To: <20190622115257.7198f8d4@archlinux>
References: <20190617143057.4096-1-geert+renesas@glider.be>
        <20190622115257.7198f8d4@archlinux>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jun 2019 11:52:57 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 17 Jun 2019 16:30:57 +0200
> Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> 
> > "git diff" says:
> > 
> >     \ No newline at end of file
> > 
> > after modifying the files.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>  
> Applied to the togreg branch of iio.git and pushed out as testing.
Hmm. I only just noticed that this 'fixes' the sysfs-power file as
well which isn't one of mind.

I'm going to drop the patch to avoid any possible clashes.
Please respin as separate patches.

Thanks,

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  Documentation/ABI/testing/sysfs-bus-iio-dfsdm-adc-stm32 | 2 +-
> >  Documentation/ABI/testing/sysfs-power                   | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-dfsdm-adc-stm32 b/Documentation/ABI/testing/sysfs-bus-iio-dfsdm-adc-stm32
> > index da9822309f0757bd..0e66ae9b0071e80b 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio-dfsdm-adc-stm32
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio-dfsdm-adc-stm32
> > @@ -13,4 +13,4 @@ Description:
> >  			error on writing
> >  		If DFSDM input is SPI Slave:
> >  			Reading returns value previously set.
> > -			Writing value before starting conversions.
> > \ No newline at end of file
> > +			Writing value before starting conversions.
> > diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
> > index 18b7dc929234f625..3c51303550118474 100644
> > --- a/Documentation/ABI/testing/sysfs-power
> > +++ b/Documentation/ABI/testing/sysfs-power
> > @@ -300,4 +300,4 @@ Description:
> >  		attempt.
> >  
> >  		Using this sysfs file will override any values that were
> > -		set using the kernel command line for disk offset.
> > \ No newline at end of file
> > +		set using the kernel command line for disk offset.  
> 


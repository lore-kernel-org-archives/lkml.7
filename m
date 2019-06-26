Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94992C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 19:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6478B216FD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 19:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561578140;
	bh=19ZOw2Xp9qIWrNUFXDeeJMCttdZ0PLDeQqORFoKhACs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=GBDPg32vsgeOUBm4d3BEQB8Q80KzsfJ1NvnbUnypcYeNt5+WPo513EinE5HyESw4E
	 RNCLHI14/y+jTVmiQMAEpBQtMt6D0+iM02Sq6BgGKf9qGFojyAcgrn2nd+vSCQ6oZd
	 YgmCRdKZwKSo58wLvQ1VALqKweBLYIrXRFoCmtEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfFZTmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 15:42:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:58954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbfFZTmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 15:42:18 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C87782085A;
        Wed, 26 Jun 2019 19:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561578137;
        bh=19ZOw2Xp9qIWrNUFXDeeJMCttdZ0PLDeQqORFoKhACs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W8iONN8TvqZWcmxR006vXEmg6bq20FjBxQvOTwNLGO47N/Bu2FBqREJgKO00xKo/Y
         oWB4qqP4vswuCsV/3pANd1dYC3yQF/wb4ZKEUg1O6MzPqJXaBrmgxWDGduMXTzCjW2
         ZaCploUq2HsSZn0F97H1C89hmVydhHZczjMUA7tE=
Date:   Wed, 26 Jun 2019 20:42:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Stefan Popa <stefan.popa@analog.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, Michael.Hennerich@analog.com,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: iio: frequency: Use dt-schema for
 clock-names
Message-ID: <20190626204211.4d05ab38@archlinux>
In-Reply-To: <20190625083036.jrr7kz7f6ks6nqps@flea>
References: <1561389097-26075-1-git-send-email-stefan.popa@analog.com>
        <20190625083036.jrr7kz7f6ks6nqps@flea>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jun 2019 10:30:36 +0200
Maxime Ripard <maxime.ripard@bootlin.com> wrote:

> Hi,
> 
> On Mon, Jun 24, 2019 at 06:11:37PM +0300, Stefan Popa wrote:
> > Dt-schema can be used for clock-names property.
> >
> > Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> > ---
> >  Documentation/devicetree/bindings/iio/frequency/adf4371.yaml | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> > index d7adf074..8a2a8f6 100644
> > --- a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> > +++ b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> > @@ -27,9 +27,8 @@ properties:
> >      maxItems: 1
> >
> >    clock-names:
> > -    description:
> > -      Must be "clkin"
> > -    maxItems: 1
> > +    items:
> > +      - clkin  
> 
> You can even just have const: clkin here
> 
Given this is fairly independent from the rest of the series, I'll plough
on with the others and expect a v2 of this one to address Maxime's
suggestion.

Thanks,

Jonathan

> Maxime
> 
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com


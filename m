Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CF4C4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 10:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B806E2146F
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 10:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554028456;
	bh=KZX3B3kqeXK6KbRjww4PZdoyu8VKsKIUpdaksSUN2uQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=sTZ6SrYEuzsznQs1N4p/aBK463JEnIi6lb5RLRleprebIICctMA6NAxpdho9NtqwM
	 nnvMkykiM9OU5X4zdPu5Ibd2rjBL5XmNnAVrFz0BHx0c9Qlll2R3mqu5nsLpy+XKuJ
	 W1J67C5hf6AqvMQZP4XZ8PEVV+GFrYvVmmk1QbvM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731138AbfCaKeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 06:34:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726989AbfCaKeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 06:34:15 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56B7020872;
        Sun, 31 Mar 2019 10:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554028454;
        bh=KZX3B3kqeXK6KbRjww4PZdoyu8VKsKIUpdaksSUN2uQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vv+wv09SBFJh9fcnlPikRTgm/oRK9ROG4APtAS4notSU5BfvlocretPiDSu2wFBIR
         X/mhyDhAaKYdqRa1PdFWbtxComJ18LknqTJ4S0FJI1liqXOLQbJRv+YYthZ9Zc7hYF
         Gdfuq+jT4x59iDrUVn9afe07m5c5400jVdWSdD5M=
Date:   Sun, 31 Mar 2019 11:34:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, mark.rutland@arm.com, afaerber@suse.de,
        arnd@arndb.de, davem@davemloft.net, gregkh@linuxfoundation.org,
        johan@kernel.org, khilman@baylibre.com, knaack.h@gmx.de,
        lars@metafoo.de, linux-kernel@vger.kernel.org,
        martin.blumenstingl@googlemail.com, mchehab+samsung@kernel.org,
        m.othacehe@gmail.com, nicolas.ferre@microchip.com,
        pmeerw@pmeerw.net, songqiang1304521@gmail.com, treding@nvidia.com,
        techsupport@maxbotix.com
Subject: Re: [PATCH v3 2/4] dt-bindings: maxbotix,mb1232: Add MaxBotix i2c
 ultrasonic rangers
Message-ID: <20190331113407.5df5f41d@archlinux>
In-Reply-To: <20190328175134.GA15033@bogus>
References: <20190317203526.4pcwo4gdrrng44v7@arbad>
        <20190328175134.GA15033@bogus>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Mar 2019 12:51:35 -0500
Rob Herring <robh@kernel.org> wrote:

> On Sun, Mar 17, 2019 at 09:35:27PM +0100, Andreas Klinger wrote:
> > Add doc for dt binding maxbotix,mb1232. This binding is for MaxBotix
> > I2CXL-MaxSonar ultrasonic rangers which share a common i2c interface.
> > 
> > Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> > ---
> >  .../bindings/iio/proximity/maxbotix,mb1232.txt     | 31 ++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.txt b/Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.txt
> > new file mode 100644
> > index 000000000000..0e9df87eca1d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.txt
> > @@ -0,0 +1,31 @@
> > +* MaxBotix I2CXL-MaxSonar ultrasonic distance sensor of type  mb1202,
> > +  mb1212, mb1222, mb1232, mb1242, mb7040 or mb7137 using the i2c interface
> > +  for ranging
> > +
> > +Required properties:
> > + - compatible:		"maxbotix,mb1202",
> > +			"maxbotix,mb1212",
> > +			"maxbotix,mb1222",
> > +			"maxbotix,mb1232",
> > +			"maxbotix,mb1242",
> > +			"maxbotix,mb7040" or
> > +			"maxbotix,mb7137"
> > +
> > + - reg:			i2c address of the device, see also i2c/i2c.txt
> > +
> > +Optional properties:
> > + - interrupt-parent:	Interrupt controller to use  
> 
> Don't need this as it is implied and could be in the parent.
> 
> Otherwise,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
I tidied that up.

Thanks,

Jonathan

> 
> > +
> > + - interrupts:		Interrupt used to announce the preceding reading
> > +			request has finished and that data is available.
> > +			If no interrupt is specified the device driver
> > +			falls back to wait a fixed amount of time until
> > +			data can be retrieved.
> > +
> > +Example:
> > +proximity@70 {
> > +	compatible = "maxbotix,mb1232";
> > +	reg = <0x70>;
> > +	interrupt-parent = <&gpio2>;
> > +	interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
> > +};
> > -- 
> > 2.11.0  


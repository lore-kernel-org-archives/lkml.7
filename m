Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4BCC10F00
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 15:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9EF1218A6
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 15:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553961528;
	bh=Yfpmj6mOxBj7rAxu/6KZDx0CFw9R6H4ZuCklXiEDthQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=kkykyj+uitdHFsSAyZ8vPZgoelMwPNzFFldwHO5trroFlj5ch+tuxpb8yQalveP8F
	 fUeR+Hzbku4Ofg5N/ye6XpJGlOycTdBcq4h58HUDhWbvWVooNUzJxvqhc3pFlzxdgI
	 t9eReigxD/tbNkv3MJFRywB+cQNsGSN15Vp/lVWI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730927AbfC3P6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 11:58:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730558AbfC3P6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 11:58:46 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9759218A3;
        Sat, 30 Mar 2019 15:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553961524;
        bh=Yfpmj6mOxBj7rAxu/6KZDx0CFw9R6H4ZuCklXiEDthQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iyF2arXmyEPqaGWJcT0ml7Af7TfNxXleFHz8c/uyGE5tzIm+ZZSMF2KJtl4WNsBv4
         e6gPBm/Z4qgCv+k2wTV+ub5tiyDdbN+mLVlRCMg23NHVYSeyWrOQ1nmzWE5Su80+IP
         5Yrs7EQGRf/ao8xzVGPzEhMAYnlXa1K/izUZxfLY=
Date:   Sat, 30 Mar 2019 15:58:39 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Ibtsam Ul-Haq <ibtsam.haq.0x01@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Popa <stefan.popa@analog.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: iio: Add bindings for TI TLA202x
 ADCs
Message-ID: <20190330155839.5c438850@archlinux>
In-Reply-To: <20190328183842.GA9079@bogus>
References: <1553608583-29006-1-git-send-email-ibtsam.haq.0x01@gmail.com>
        <1553608583-29006-2-git-send-email-ibtsam.haq.0x01@gmail.com>
        <20190328183842.GA9079@bogus>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC Stefan for a possible issue in ad7124

On Thu, 28 Mar 2019 13:38:42 -0500
Rob Herring <robh@kernel.org> wrote:

> On Tue, Mar 26, 2019 at 02:56:20PM +0100, Ibtsam Ul-Haq wrote:
> > This adds devicetree bindings for TI TLA202x ADCs.
> > 
> > Signed-off-by: Ibtsam Ul-Haq <ibtsam.haq.0x01@gmail.com>
> > ---
> >  .../devicetree/bindings/iio/adc/ti-tla2024.txt     | 45 ++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-tla2024.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/ti-tla2024.txt b/Documentation/devicetree/bindings/iio/adc/ti-tla2024.txt
> > new file mode 100644
> > index 0000000..a4934df
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/ti-tla2024.txt
> > @@ -0,0 +1,45 @@
> > +Texas Instruments' TLA2021/TLA2022/TLA2024 12-bit ADC driver
> > +
> > +Required properties:
> > +
> > +- compatible: should be one of:
> > +  "ti,tla2024"
> > +  "ti,tla2022"
> > +  "ti,tla2021"
> > +
> > +- reg: should contain the I2C Address of the device
> > +
> > +Required subnodes:
> > +
> > +The ADC channels are configured as subnodes of the ADC.
> > +The channels can be single-ended or differential, the input pins are
> > +also set in the subnode.
> > +
> > +Possible channels in TLA2024:
> > +  single: <0>, <1>, <2>, <3>
> > +  differential: <0 1>, <0 3>, <1 3>, <2 3>
> > +
> > +In TLA2021/TLA2022 only the differential channel <0 1> is allowed.
> > +
> > +Example:
> > +
> > +tla2024_0: adc0@49 {  
> 
> adc@49
> 
> > +	compatible = "ti,tla2024";
> > +	reg = <0x49>;
> > +
> > +	v0@0 {  
> 
> Unit-address without 'reg' is not valid.
> 
> > +		single-channel = <0>;  
> 
> Look at the common adc binding or adi,ad7124.txt for how to do 
> multi-channel with differential channels.
Hi Rob.

Only difference from the standard doc 
Documentation/devicetree/bindings/adc/adc.txt
which should be fixed is that channels are
channel@0, channel@1 etc

Non differential channels aren't in that doc yet but what we have
here works for me (other than the naming).

Note however, we didn't require reg in that binding so probably
have something to fix there.  The adi driver you reference does
have reg in the bindings, though so we should probably just add
that to the generic doc.

One side note though for Stefan,  What happens if someone provides
a non contiguous set of reg values or one greater than 3 for the ad7124?  
e should probably harden the driver against that (or am I missing something).

Jonathan
> 
> > +	};
> > +
> > +	v1@1 {
> > +		single-channel = <1>;
> > +	};
> > +
> > +	v23@2 {
> > +		diff-channels = <2 3>;
> > +	};
> > +
> > +	v01@3 {
> > +		diff-channels = <0 1>;
> > +	};
> > +};
> > -- 
> > 2.7.4
> >   


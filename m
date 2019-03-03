Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1F4C10F00
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 13:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA5820866
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 13:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551618133;
	bh=NYyHkRZF/s+pJMJdKg1Dq53jeu+U8eHbxhO15h3qMdI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=oxKMR0X1X/Hhx4uUSBbsyi9lKLLWrHOWuxE4PGSMDUJ0+Wxv7GMg8Mv3zLv0wk7ou
	 kABXrc+jTdeX9BbMx2AUGDiEROqfN2gD/id63sIHcjsGgz5S2EwXn/DP+2ryez0Q+8
	 22qjFzqFZV8oYfelnNFgVZDESfZFm8Sg8UxQdb/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbfCCNCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 08:02:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:34278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbfCCNCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 08:02:10 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF6B120836;
        Sun,  3 Mar 2019 13:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551618129;
        bh=NYyHkRZF/s+pJMJdKg1Dq53jeu+U8eHbxhO15h3qMdI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ovBMtVAqC/J9BBGPrXeGhP+7dOo7SbPWGur6yHpYOJcLvcnbYK/DXWkyi3L5Twb7y
         vbFjdAUMMfUE9x5xEJLK/Pgj7Muxi12qoIWpib2dJzDpTmvQIkLoHDxx8sFD5OB4zw
         xJiFT8zilZuXxzWvJikG2qsNgtxPZbxbxQHzqbYs=
Date:   Sun, 3 Mar 2019 13:02:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Patrick Havelange <patrick.havelange@essensium.com>
Cc:     Rob Herring <robh@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>,
        Matt Weber <matthew.weber@rockwellcollins.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/2] iio:temperature:max31856:Add device tree bind
 info
Message-ID: <20190303130203.256a5905@archlinux>
In-Reply-To: <CAKKE0ZFNm1BNS5xbgo4D1Kp0U+TbL35A9Uk-r245CPVkAuE=XQ@mail.gmail.com>
References: <20190226150214.19467-1-patrick.havelange@essensium.com>
        <20190227235947.GA27130@bogus>
        <CAKKE0ZFNm1BNS5xbgo4D1Kp0U+TbL35A9Uk-r245CPVkAuE=XQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2019 16:15:55 +0100
Patrick Havelange <patrick.havelange@essensium.com> wrote:

> On Thu, Feb 28, 2019 at 12:59 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Tue, Feb 26, 2019 at 04:02:13PM +0100, Patrick Havelange wrote:  
> > > From: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
> > >
> > > This patch added device tree binding info for MAX31856 driver.
> > >
> > > Signed-off-by: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
> > > Signed-off-by: Matt Weber <matthew.weber@rockwellcollins.com>
> > > Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
> > > ---
> > > Changes
> > > v1 -> v2
> > > [Matt
> > >  - Removed comment block and added possibilities of
> > >    thermocouple type in device tree binding doc.
> > >
> > > v2 -> v3
> > >  - Rebased
> > >
> > > v3 -> v4
> > >  - Removed one-shot property related information.
> > >  - Used standard name 'temp-sensor'
> > >
> > > v4 -> v5
> > > [Patrick
> > >  - Rename thermocouple type to maxim,thermocouple-type for DT entry
> > > ---
> > >  .../bindings/iio/temperature/max31856.txt     | 29 +++++++++++++++++++
> > >  1 file changed, 29 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/iio/temperature/max31856.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/iio/temperature/max31856.txt b/Documentation/devicetree/bindings/iio/temperature/max31856.txt
> > > new file mode 100644
> > > index 000000000000..b4396069b8fa
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/temperature/max31856.txt
> > > @@ -0,0 +1,29 @@
> > > +Maxim MAX31856 thermocouple support
> > > +
> > > +https://datasheets.maximintegrated.com/en/ds/MAX31856.pdf
> > > +
> > > +Required properties:
> > > +     - compatible: must be "maxim,max31856"
> > > +     - reg: SPI chip select number for the device
> > > +     - spi-max-frequency: As per datasheet max. supported freq is 5000000
> > > +     - spi-cpha: must be defined for max31856 to enable SPI mode 1
> > > +     - maxim,thermocouple-type: Type of thermocouple (By default is K-Type)
> > > +             0x00 : TYPE_B
> > > +             0x01 : TYPE_E
> > > +             0x02 : TYPE_J
> > > +             0x03 : TYPE_K (default)
> > > +             0x04 : TYPE_N
> > > +             0x05 : TYPE_R
> > > +             0x06 : TYPE_S
> > > +             0x07 : TYPE_T  
> >
> > These appear to be standard types. Perhaps this should be a common
> > property instead?  
> 
> A remark on the v4 of the patch recommended to add a vendor prefix. It
> also mentioned that it could be done as a generic type with a
> translation layer for each driver.
> Maybe this generic type could be introduced in a separate patch, or
> when another driver also uses that kind of thermocouple-type, as there
> is no other use of it for the moment it seems.

Hmm. If Rob is keen, it might be good to define this standard now.

The big advantage for you is that you can define the numbers to involve
no transition layer for your device.

A quick look at wikipedia suggests there are additional types:
TYPE_M
TYPE_C
TYPE_G
TYPE_P
+ some weird types without a letter.

We have missed the coming merge window for this one so have
a bit of time.  Perhaps you could propose such a generic binding?
For now that binding could just include the values you care about
and new ones can be added when needed.

We would want a dt header to give them defined names to help
with readability.

Apologies for making you go around again on this.

Jonathan


> 
> 
> >  
> > > +
> > > +     Refer to spi/spi-bus.txt for generic SPI slave bindings.
> > > +
> > > + Example:
> > > +     temp-sensor@0 {
> > > +             compatible = "maxim,max31856";
> > > +             reg = <0>;
> > > +             spi-max-frequency = <5000000>;
> > > +             spi-cpha;
> > > +             maxim,thermocouple-type = <0x03>;
> > > +     };
> > > --
> > > 2.19.1
> > >  


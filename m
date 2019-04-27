Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B7CC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 19:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7C32087E
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 19:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="oEf5axQH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfD0TBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 15:01:31 -0400
Received: from vps.xff.cz ([195.181.215.36]:53066 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbfD0TBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 15:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1556391687; bh=1k0KSGJbvVlz3bAl3os5LWwpFDV2ca8mHPbTDpXh5AI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oEf5axQHLSAKGWixMf6339L/blKLRClp75iCuuRnhZeZGG5PXXXOpKhxCr8hb0mtn
         E8h6myV5BEH46kzLXQEt9S8mUWOoJGCzdW94kyP5svV9TxeQ26KykrpejyWLcimAVi
         lwQUlEvtRs9vSEZqkJpG1JXzyQbGNMdUP2BnPesA=
Date:   Sat, 27 Apr 2019 21:01:23 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-sunxi <linux-sunxi@googlegroups.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v4 6/9] dt-bindings: display: hdmi-connector: Add DDC
 power supply
Message-ID: <20190427190123.6aik7by3fgkyjmq7@core.my.home>
Mail-Followup-To: Rob Herring <robh@kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
References: <20190413165418.27880-1-megous@megous.com>
 <20190413165418.27880-7-megous@megous.com>
 <20190426182337.GA22245@bogus>
 <20190426192031.wtoaxctjo2qxxquq@core.my.home>
 <CAL_Jsq+o1j6AGL9UnhN1tV150DsFug6pg+UPEJ9EKqBc6rgq_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_Jsq+o1j6AGL9UnhN1tV150DsFug6pg+UPEJ9EKqBc6rgq_w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 03:02:50PM -0500, Rob Herring wrote:
> On Fri, Apr 26, 2019 at 2:20 PM Ondřej Jirman <megous@megous.com> wrote:
> >
> > On Fri, Apr 26, 2019 at 01:23:37PM -0500, Rob Herring wrote:
> > > On Sat, Apr 13, 2019 at 06:54:15PM +0200, megous@megous.com wrote:
> > > > From: Ondrej Jirman <megous@megous.com>
> > > >
> > > > Some Allwinner SoC using boards (Orange Pi 3 for example) need to enable
> > > > on-board voltage shifting logic for the DDC bus to be usable. Use
> > > > ddc-supply on the hdmi-connector to model this.
> > > >
> > > > Add binding documentation for optional ddc-supply property.
> > > >
> > > > Signed-off-by: Ondrej Jirman <megous@megous.com>
> > > > ---
> > > >  .../devicetree/bindings/display/connector/hdmi-connector.txt     | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/display/connector/hdmi-connector.txt b/Documentation/devicetree/bindings/display/connector/hdmi-connector.txt
> > > > index 508aee461e0d..33085aeb0bb9 100644
> > > > --- a/Documentation/devicetree/bindings/display/connector/hdmi-connector.txt
> > > > +++ b/Documentation/devicetree/bindings/display/connector/hdmi-connector.txt
> > > > @@ -9,6 +9,7 @@ Optional properties:
> > > >  - label: a symbolic name for the connector
> > > >  - hpd-gpios: HPD GPIO number
> > > >  - ddc-i2c-bus: phandle link to the I2C controller used for DDC EDID probing
> > > > +- ddc-supply: the power supply for the DDC bus
> > >
> > > It's not just for DDC. It powers the chips in bridge dongles for
> > > example. Pretty much every diagram I find just calls it 5V or +5V.
> > >
> > > So how about '5V-supply' or 'v5V-supply'?
> >
> > Just to be sure, the schematic that inspired this change looks like this:
> >
> > https://megous.com/dl/tmp/33b2971de6943e9d.png
> >
> > HDMI-5V is always on, and what is really being enabled here are mosfets
> > connected to DDC_CEC_EN and not the HDMI-5V power supply. So in this case it
> > really is just for DDC. It is conceivable that some boards may need both to
> > enable 5V for HDMI circuitry and some separate power shifting logic for
> > DDC bus.
> 
> Okay, not what I thought you were defining. DDC_CEC_EN is a GPIO line?
> I wouldn't characterize this as a voltage rail, so I don't think it
> should be a supply. Perhaps 'ddc-en-gpios'?

Yes it's GPIO. I'll implement it as GPIO.

> We certainly want to make it clear this is not the 5V supply.

Right. Thank you for review.

regards,
	Ondrej

> Rob
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

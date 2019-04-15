Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81152C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49DD420880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="VfVGaH3s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbfDOPGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:06:25 -0400
Received: from vps.xff.cz ([195.181.215.36]:40094 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbfDOPGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 11:06:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1555340782; bh=HFvy0q2gwTmM4xAW9w+gUodMDWGuSfLXWAUViBSn5lA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VfVGaH3s3USCap1XZmFFKt0pLc2cytBS64Fyak2t/dji2xK9NEgtoMW0h/bHZUhmE
         /RRVi+dRU515x6RJ3pc606jDqpP5VShBOtV17IWz/HChT+ch4dl0BGVESs7olT7oC0
         mmXf/5ymg85UtKLs3q5f9PAl5a+3IUbvy3msjqUE=
Date:   Mon, 15 Apr 2019 17:06:21 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        devicetree <devicetree@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH 1/4] dt-bindings: sound: sun4i-spdif: Add Allwinner H6
 compatible
Message-ID: <20190415150621.rbuhtoqkdnwgze6s@core.my.home>
Mail-Followup-To: =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        devicetree <devicetree@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Icenowy Zheng <icenowy@aosc.io>
References: <20190411214422.2267-1-peron.clem@gmail.com>
 <20190411214422.2267-2-peron.clem@gmail.com>
 <20190415080443.frubh4ln4agrdsfe@flea>
 <CAJiuCcc0Q8rh8u_30gKi8o07k0+e35UR99ZBHtCjx-DPkJEtdw@mail.gmail.com>
 <20190415081816.2pay4pioc5d4mojf@flea>
 <CAJiuCcedNF0xYSa_+Zfwj-vqYsbjfEpRqisOhEvuitYALMsyjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJiuCcedNF0xYSa_+Zfwj-vqYsbjfEpRqisOhEvuitYALMsyjw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Clement,

On Mon, Apr 15, 2019 at 10:30:38AM +0200, Clément Péron wrote:
> On Mon, 15 Apr 2019 at 10:18, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > On Mon, Apr 15, 2019 at 10:09:11AM +0200, Clément Péron wrote:
> > > Hi,
> > >
> > > On Mon, 15 Apr 2019 at 10:04, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Thu, Apr 11, 2019 at 11:44:19PM +0200, Clément Péron wrote:
> > > > > Allwinner H6 has a SPDIF controller with an increase of the fifo
> > > > > size and the possibility to output the master clock.
> > > > > However it's still compatible with the already existing driver for
> > > > > Allwiner H3.
> > > > >
> > > > > Add this compatible in the device-tree bindings documentation.
> > > >
> > > > How was this tested?
> > >
> > > Using Alsa utils on a Beelink GS1 and I check correct output sound on
> > > my home cinema.
> > >
> > > > After looking at the datasheet, it looks like it's still significantly
> > > > different. In particular:
> > > >
> > > >   - The MCLK divider isn't at the same offset
> > >
> > > We don't use the MCLK
> > >
> > > >   - The bits to flush the FIFO aren't at the same offset
> > > >   - The FIFO trigger levels aren't at the same offset
> > > >   - The FIFO status register layout is almost entirely different
> > >
> > > We use DMA not FIFO
> >
> > Well, DMA still uses the FIFOs. And even then, you're kind of missing
> > the point. The device tree's compatible is about whether a particular
> > device can be used as another one. How you are using it in the driver
> > is completely irrelevant.
> 
> Sorry I meant " We use DMA not PIO".
> 
> I didn't change the driver and the SPDIF is working what's irrelevant
> in declaring the driver as compatible ?
>
> If some feature are missing they can be introduce later as there is a
> special binding for H6 no ?

You have to drop fallback to allwinner,sun8i-h3-spdif at the very least:

+                       #sound-dai-cells = <0>;
+                       compatible = "allwinner,sun50i-h6-spdif",
+                                    "allwinner,sun8i-h3-spdif";
+                       reg = <0x05093000 0x400>;

If the H6 hardware doesn't just implement some optional superset of what H3
does.

regards,
	o.

> Clement
> 
> >
> > Maxime
> >
> > --
> > Maxime Ripard, Bootlin
> > Embedded Linux and Kernel engineering
> > https://bootlin.com
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

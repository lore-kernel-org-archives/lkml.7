Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81039C33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 13:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C742081E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 13:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578318679;
	bh=WTL6AAJGHSgduF8h7uccI4wLTd+i6OKpU4LDqmdW1d8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mtTR8kDOCy5ckjn/D2rOZfrziTdTjIg9K0t8NLWFzRGKOZvi+b6Tc3tfzgeIVjE1f
	 cuyWSf2XExfUs6uk/Rbmm3WLRmOUuWEdwP6rhHfNGfosIhW3asgKKFgTTdd5KMYFod
	 HAXJVALrr3P0nDtXn8tVnz+XsGJMF/2ZO0pnkG3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgAFNvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 08:51:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:49600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbgAFNvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 08:51:18 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DE1E2072E;
        Mon,  6 Jan 2020 13:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578318677;
        bh=WTL6AAJGHSgduF8h7uccI4wLTd+i6OKpU4LDqmdW1d8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x67zkGR98wfdcYmefSjrzMMDN6YPniRgFxaw2YjG4Y2XIFdO1OWVJpP/AIuRBiLMk
         bJeIm/AZ3//05tW/OI2e7m2ekwIeVQV3ANbESq5YqmPuu62u+pZ09xWcMKOci2uBEH
         C10An/AxR6Ztbmin7JwyDDXAsBZuHVwE/n5JnGU4=
Date:   Mon, 6 Jan 2020 14:51:14 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH v2] ARM: dts: sun8i: R40: Add SPI controllers nodes and
 pinmuxes
Message-ID: <20200106135114.nwgzlzvx4mty7fhq@gilmour.lan>
References: <20200106003849.16666-1-andre.przywara@arm.com>
 <20200106085613.mxe33t7eklj3aeld@gilmour.lan>
 <CAGb2v65=iJzPJneUF=e9Xsqj_ufhuZtr5javN5YNKtaApGq2zA@mail.gmail.com>
 <20200106134207.3088a74a@donnerap.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="behpb37ojul4ppun"
Content-Disposition: inline
In-Reply-To: <20200106134207.3088a74a@donnerap.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--behpb37ojul4ppun
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 06, 2020 at 01:42:07PM +0000, Andre Przywara wrote:
> On Mon, 6 Jan 2020 21:37:38 +0800
> Chen-Yu Tsai <wens@csie.org> wrote:
>
> Hi,
>
> > On Mon, Jan 6, 2020 at 4:56 PM Maxime Ripard <mripard@kernel.org> wrote:
> > >
> > > On Mon, Jan 06, 2020 at 12:38:49AM +0000, Andre Przywara wrote:
> > > > The Allwinner R40 SoC contains four SPI controllers, using the newer
> > > > sun6i design (but at the legacy addresses).
> > > > The controller seems to be fully compatible to the A64 one, so no driver
> > > > changes are necessary.
> > > > The first three controllers can be used on two sets of pins, but SPI3 is
> > > > only routed to one set on Port A.
> > > > Only the pin groups for SPI0 on PortC and SPI1 on PortI are added here,
> > > > because those seem to be the only one exposed on the Bananapi boards.
> > > >
> > > > Tested by connecting a SPI flash to a Bananapi M2 Berry SPI0 and SPI1
> > > > header pins.
> > > >
> > > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > >
> > > Applied, thanks!
> > > Maxime
> >
> > Looks like this patch doesn't build. The SPI device nodes reference
> > a non-existent DMA node.
>
> Argh, shoot, sorry for that. Looks like a rebase artefact (I
> originally had the DMA controller in, but then saw that this is
> actually not used by the SPI driver, so removed it).
>
> Thanks for testing!
>
> Maxime, shall I send a fixup or redo the patch?

Send a fixup, I'll squash it with the previous patch, thanks!
Maxime

--behpb37ojul4ppun
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXhM7UgAKCRDj7w1vZxhR
xTgVAQCIFwCATD+xEJi/hS9mLxPKqFFgDt2VKHHYiDVTmI8F4gD+N2z9f/fkGbcK
DrxwEKmBUFXRurhsZM7onrYL04WIVg0=
=Isq5
-----END PGP SIGNATURE-----

--behpb37ojul4ppun--

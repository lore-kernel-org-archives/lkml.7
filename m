Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530D6C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B94C20665
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565803639;
	bh=+41o6/e8C3rXOa97d7ojKaetkEKiEfIBz+3a72/HK8w=;
	h=In-Reply-To:References:Subject:From:To:Date:List-ID:From;
	b=1jv234uiY5oufrN+J6diZfq7tnscaHmY50FequiRcdw2n4UFW8NqWsgM1d9FSwh5s
	 7kLwCXsYOyqEmlmydcDBAsZTPtMFdhNfYTs7xarbVBVMLmBowZFstzOAx45OWvx2V4
	 r0n5VsVCeqK8wJwyb12LNFSlTR7i4AJoXbcZ1Ylg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbfHNR1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:27:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:48544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729593AbfHNR1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:27:13 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F8F6206C1;
        Wed, 14 Aug 2019 17:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565803632;
        bh=+41o6/e8C3rXOa97d7ojKaetkEKiEfIBz+3a72/HK8w=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=bz9MVcdnLCunPed+11bKUFqXoUxHJm8DV9Ku/iZIOTbgaS1Sjej5zap8bdJfM6HIU
         NRy/p5pGykiILOq6ab5LAu+cxIIUhfzftTQbRX1APx5bOywzIjEPOezyH5OB2nv9I0
         6O1GDRYSpW3DI/cwtbNyOsLvNyLCr7wunrBD+aJY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <DB7PR04MB51955595AB182A80162E313AE2AD0@DB7PR04MB5195.eurprd04.prod.outlook.com>
References: <20190812100103.34393-1-wen.he_1@nxp.com> <20190813182520.2914520665@mail.kernel.org> <DB7PR04MB51955595AB182A80162E313AE2AD0@DB7PR04MB5195.eurprd04.prod.outlook.com>
Subject: RE: [EXT] Re: [v1 1/3] clk: ls1028a: Add clock driver for Display output interface
From:   Stephen Boyd <sboyd@kernel.org>
To:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-devel@linux.nxdi.nxp.com" <linux-devel@linux.nxdi.nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "liviu.dudau@arm.com" <liviu.dudau@arm.com>,
        Leo Li <leoyang.li@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Wen He <wen.he_1@nxp.com>
User-Agent: alot/0.8.1
Date:   Wed, 14 Aug 2019 10:27:11 -0700
Message-Id: <20190814172712.7F8F6206C1@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Wen He (2019-08-14 02:38:21)
>=20
>=20
> > -----Original Message-----
> > From: Stephen Boyd <sboyd@kernel.org>
> > Sent: 2019=E5=B9=B48=E6=9C=8814=E6=97=A5 2:25
> > To: Michael Turquette <mturquette@baylibre.com>; Wen He
> > <wen.he_1@nxp.com>; Leo Li <leoyang.li@nxp.com>;
> > linux-clk@vger.kernel.org; linux-devel@linux.nxdi.nxp.com;
> > linux-kernel@vger.kernel.org; liviu.dudau@arm.com
> > Cc: Wen He <wen.he_1@nxp.com>
> > Subject: [EXT] Re: [v1 1/3] clk: ls1028a: Add clock driver for Display =
output
> > interface
> >=20
> >=20
> > Quoting Wen He (2019-08-12 03:01:03)
> > > diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig index
> > > 801fa1cd0321..0e6c7027d637 100644
> > > --- a/drivers/clk/Kconfig
> > > +++ b/drivers/clk/Kconfig
> > > @@ -223,6 +223,15 @@ config CLK_QORIQ
> > >           This adds the clock driver support for Freescale QorIQ plat=
forms
> > >           using common clock framework.
> > >
> > > +config CLK_PLLDIG
> > > +        bool "Clock driver for LS1028A Display output"
> > > +        depends on ARCH_LAYERSCAPE && OF
> >=20
> > Does it actually depend on either of these to build? Probabl not, so ma=
ybe just
> > default ARCH_LAYERSCAPE && OF? Also, can your Kconfig variable be named
> > something more specific like CLK_LS1028A_PLLDIG?
>=20
> Actually it also depends Display modules, but we allow building display d=
rivers as modules,=20
> so is here whether need add Display modules depend and also allow clock d=
river building
> to a module?=20
> Would it be better to reduce the number of the modules insert, I think th=
e clock driver
> should be long available for the system.

I'm asking if it actually requires ARCH_LAYERSCAPE or OF to successfully
compile the file. Is that true? I don't see any asm/ includes or
anything that's going to fail if either of these configs aren't enabled.
So it seems safe to change this to=20

	depends on ARCH_LAYERSCAPE || COMPILE_TEST
	default ARCH_LAYERSCAPE

so that it's compiled by default on this architecture and is available
to be compile tested by various test builders.

>=20
> looks like great if named Kconfig variable to 'CLK_LS1028A_PLLDIG'.
>=20
> >=20

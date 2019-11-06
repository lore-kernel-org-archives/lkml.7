Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF569C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 11:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E2F217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 11:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573041148;
	bh=OF5G2aua6XJ/Sp4YTPouRXr0Og+dxfgO9zAId67DLXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2MqhvZeXsWNQn+2Wma0h96R3uUJ5jFyEZ3dRUDW1q76XwDDXZq2elh5dOcymM4qhh
	 AxEz05Vjoq5P8/szJ7+LroDSq843aILQELUkHcYwizMNJjlGrZ181CVfC5LhR0rSjD
	 Yt7pdq+/CFfjZoVBaD6ljad/4JMf72HTcMWm/Ks4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbfKFLw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 06:52:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:38318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbfKFLw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 06:52:26 -0500
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 870302075C;
        Wed,  6 Nov 2019 11:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573041146;
        bh=OF5G2aua6XJ/Sp4YTPouRXr0Og+dxfgO9zAId67DLXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qIUFYfJ37F3Z3WnIERx/g5BXRvKYxqkb58MjBLfS4mnY4LrPgrprykjOUbSbTH9wM
         1BuL2ZUvQD1NSjB4KzI13eNg5rZ87yDmhcv8TXNPYjjm7WtzxFgizy7YU9zdiIVb+c
         P3USJmz6ZAZQsdpb0C+2dlJeMGpZWWzEeWU0kOrs=
Date:   Wed, 6 Nov 2019 12:52:22 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Alistair Francis <alistair23@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Alistair Francis <alistair@alistair23.me>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: dts: sun50i: sopine-baseboard: Expose serial1,
 serial2 and serial3
Message-ID: <20191106115222.GA8617@gilmour.lan>
References: <20191012200524.23512-1-alistair@alistair23.me>
 <20191016144946.p3tm67vh5lqigndn@gilmour>
 <CAGb2v67QrTJjSO99UNs-=3ZZnK948am11=izRTHT6gZ06E28eA@mail.gmail.com>
 <20191021111709.dpu6g7jltuw6cbbn@gilmour>
 <CAKmqyKN8Ru19h3y=9O13=5wpys3BC2LQM65S+2QYjPdJQn2O4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <CAKmqyKN8Ru19h3y=9O13=5wpys3BC2LQM65S+2QYjPdJQn2O4w@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 05, 2019 at 11:27:42AM -0800, Alistair Francis wrote:
> On Mon, Oct 21, 2019 at 4:17 AM Maxime Ripard <mripard@kernel.org> wrote:
> >
> > Hi,
> >
> > On Wed, Oct 16, 2019 at 10:54:27PM +0800, Chen-Yu Tsai wrote:
> > > On Wed, Oct 16, 2019 at 10:49 PM Maxime Ripard <mripard@kernel.org> wrote:
> > > > On Sat, Oct 12, 2019 at 01:05:24PM -0700, Alistair Francis wrote:
> > > > > Follow what the sun50i-a64-pine64.dts does and expose all 5 serial
> > > > > connections.
> > > > >
> > > > > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > > > > ---
> > > > >  .../allwinner/sun50i-a64-sopine-baseboard.dts | 25 +++++++++++++++++++
> > > > >  1 file changed, 25 insertions(+)
> > > > >
> > > > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> > > > > index 124b0b030b28..49c37b21ab36 100644
> > > > > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> > > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> > > > > @@ -56,6 +56,10 @@
> > > > >       aliases {
> > > > >               ethernet0 = &emac;
> > > > >               serial0 = &uart0;
> > > > > +             serial1 = &uart1;
> > > > > +             serial2 = &uart2;
> > > > > +             serial3 = &uart3;
> > > > > +             serial4 = &uart4;
> > > > >       };
> > > > >
> > > > >       chosen {
> > > > > @@ -280,6 +284,27 @@
> > > > >       };
> > > > >  };
> > > > >
> > > > > +/* On Pi-2 connector */
> > > > > +&uart2 {
> > > > > +     pinctrl-names = "default";
> > > > > +     pinctrl-0 = <&uart2_pins>;
> > > > > +     status = "disabled";
> > > > > +};
> > > > > +
> > > > > +/* On Euler connector */
> > > > > +&uart3 {
> > > > > +     pinctrl-names = "default";
> > > > > +     pinctrl-0 = <&uart3_pins>;
> > > > > +     status = "disabled";
> > > > > +};
> > > > > +
> > > > > +/* On Euler connector, RTS/CTS optional */
> > > > > +&uart4 {
> > > > > +     pinctrl-names = "default";
> > > > > +     pinctrl-0 = <&uart4_pins>;
> > > > > +     status = "disabled";
> > > > > +};
> > > >
> > > > Since these are all the default muxing, maybe we should just set that
> > > > in the DTSI?
> > >
> > > Maybe not, since people may want to only use RX/TX, and leave the other
> > > two pins for GPIO?
> >
> > Right, I'll apply that patch.
>
> Ping, just want to make sure this has been applied/will be applied.

This has been applied, and was part of the PR for 5.5 sent last week

Maxime

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXcKz9gAKCRDj7w1vZxhR
xfPJAP4qP44/SpPzLjXIyoizSx9xs7CQpWprZuxSoSTc3Ba5RgEA4Q2NIc2Xk6rr
HnXc85K09hZjEcpzLo2Q1Dw6Kx3rBw0=
=Zoc5
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--

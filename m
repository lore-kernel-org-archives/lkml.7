Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08746CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 11:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D06942084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 11:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571656634;
	bh=+HuhLJjJiwH7Kl+C7z+5jg90DFHTonlD/TcagMhzneg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=na38fz3MnpltTBeunWuEarXXOV1LZJLbTweZy/HZniOdl+pY3blgHgscjEaLJI1DO
	 Kn9Z0wzv+RixHq0MYKLvQrVK+w7SVuWqaIW49jEskTVkqsz/1Dw7ipeMYgCpz+Cu+7
	 5exw1sN1KLeE3a6Fay+pwtUqbhwLT1mzuZj8cUBI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbfJULRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 07:17:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:49908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727620AbfJULRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 07:17:13 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24665206C2;
        Mon, 21 Oct 2019 11:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571656632;
        bh=+HuhLJjJiwH7Kl+C7z+5jg90DFHTonlD/TcagMhzneg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WHEqFWuCUlAJUZ35FvUobSwWmnxHYqXGs7cDfeaufr9guGGbHGcoT+LAVfCOjJz7D
         WC3mUYHbu415W3tZ/a6rGOM3tOer6ga4TmcngO4OT6KTWKRKf4iDwuFZfeZxXEAzWF
         JnIw6fp7n5GkokmZulJjLAx60pIzr/419ar4dhx8=
Date:   Mon, 21 Oct 2019 13:17:09 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Alistair Francis <alistair@alistair23.me>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        alistair23@gmail.com
Subject: Re: [PATCH] arm64: dts: sun50i: sopine-baseboard: Expose serial1,
 serial2 and serial3
Message-ID: <20191021111709.dpu6g7jltuw6cbbn@gilmour>
References: <20191012200524.23512-1-alistair@alistair23.me>
 <20191016144946.p3tm67vh5lqigndn@gilmour>
 <CAGb2v67QrTJjSO99UNs-=3ZZnK948am11=izRTHT6gZ06E28eA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lkkvvoygykhcnyp4"
Content-Disposition: inline
In-Reply-To: <CAGb2v67QrTJjSO99UNs-=3ZZnK948am11=izRTHT6gZ06E28eA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lkkvvoygykhcnyp4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Wed, Oct 16, 2019 at 10:54:27PM +0800, Chen-Yu Tsai wrote:
> On Wed, Oct 16, 2019 at 10:49 PM Maxime Ripard <mripard@kernel.org> wrote:
> > On Sat, Oct 12, 2019 at 01:05:24PM -0700, Alistair Francis wrote:
> > > Follow what the sun50i-a64-pine64.dts does and expose all 5 serial
> > > connections.
> > >
> > > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > > ---
> > >  .../allwinner/sun50i-a64-sopine-baseboard.dts | 25 +++++++++++++++++++
> > >  1 file changed, 25 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> > > index 124b0b030b28..49c37b21ab36 100644
> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> > > @@ -56,6 +56,10 @@
> > >       aliases {
> > >               ethernet0 = &emac;
> > >               serial0 = &uart0;
> > > +             serial1 = &uart1;
> > > +             serial2 = &uart2;
> > > +             serial3 = &uart3;
> > > +             serial4 = &uart4;
> > >       };
> > >
> > >       chosen {
> > > @@ -280,6 +284,27 @@
> > >       };
> > >  };
> > >
> > > +/* On Pi-2 connector */
> > > +&uart2 {
> > > +     pinctrl-names = "default";
> > > +     pinctrl-0 = <&uart2_pins>;
> > > +     status = "disabled";
> > > +};
> > > +
> > > +/* On Euler connector */
> > > +&uart3 {
> > > +     pinctrl-names = "default";
> > > +     pinctrl-0 = <&uart3_pins>;
> > > +     status = "disabled";
> > > +};
> > > +
> > > +/* On Euler connector, RTS/CTS optional */
> > > +&uart4 {
> > > +     pinctrl-names = "default";
> > > +     pinctrl-0 = <&uart4_pins>;
> > > +     status = "disabled";
> > > +};
> >
> > Since these are all the default muxing, maybe we should just set that
> > in the DTSI?
>
> Maybe not, since people may want to only use RX/TX, and leave the other
> two pins for GPIO?

Right, I'll apply that patch.

Thanks!
Maxime

--lkkvvoygykhcnyp4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXa2TtQAKCRDj7w1vZxhR
xbyUAP9PwLyhb0omaH3Q6aySeHkcOMgye7JVSNrXofoOkyX1qgEAzoj0Rt+iokqY
UA3Ryk3GULps6bfsB7pZzNNQxNc4WQI=
=K29e
-----END PGP SIGNATURE-----

--lkkvvoygykhcnyp4--

Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCF4C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F973233FF
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566999819;
	bh=PfdDBsRCBBChXNzCDotQ1Pc7yIyNBpQQ3ATlOtaDOC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IYS1/Po+VLuMhWUOMdsAfqSqWG441ZCBUBtR+eTjm65Ft+0bYNP/OEmlSijjH5iRK
	 G/K6pSrevb9/ypWTwgnOBvYD//3tTOxblDlDiS9+t9dVH9T7xTreb9tlFIgO8/Sk+r
	 HIuBPKP/EYriqyqKFocJOjI/gmFbQGD4IFENL8do=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfH1Nni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:43:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:47132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbfH1Nnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:43:37 -0400
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C5B022CF5;
        Wed, 28 Aug 2019 13:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566999816;
        bh=PfdDBsRCBBChXNzCDotQ1Pc7yIyNBpQQ3ATlOtaDOC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vrdJ3HfPobb2OsDW8pbRC6kIQu+M8yr50ucNLFVYTeNTKvLnO6nyKvDDpbmHFOJae
         BH6dkijIWCasP0rO2X7LUyBR1E1ZIsj6yaAd2rKfKTLspoDx1SyGcEY5p9+FHRy4q1
         m8OXKEa1iDTbzsnltW5dZ5sSPKxK/nsX6gP28+Ik=
Date:   Wed, 28 Aug 2019 15:43:34 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Alejandro =?utf-8?B?R29uesOhbGV6?= 
        <alejandro.gonzalez.correo@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [linux-sunxi] Re: [PATCH] mmc: sunxi: fix unusuable eMMC on some
 H6 boards by disabling DDR
Message-ID: <20190828134334.qzuwodoxmw7ov5yg@flea>
References: <20190825150558.15173-1-alejandro.gonzalez.correo@gmail.com>
 <CACRpkdazfe3gJr6Q+X05GzxPuKtUg0M780SPA_oR5bd+-xBPvA@mail.gmail.com>
 <CAGb2v67e8EiS-LUuhAyPc57nWd4iOBEWC_SZbH801Lzi4QWGyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v6flhv747vrdixqb"
Content-Disposition: inline
In-Reply-To: <CAGb2v67e8EiS-LUuhAyPc57nWd4iOBEWC_SZbH801Lzi4QWGyg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v6flhv747vrdixqb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2019 at 09:29:32PM +0800, Chen-Yu Tsai wrote:
> On Wed, Aug 28, 2019 at 8:52 PM Linus Walleij <linus.walleij@linaro.org> =
wrote:
> >
> > On Sun, Aug 25, 2019 at 5:06 PM Alejandro Gonz=E1lez
> > <alejandro.gonzalez.correo@gmail.com> wrote:
> >
> > > Jernej Skrabec compared the BSP driver with this
> > > driver, and found that the BSP driver configures pinctrl to operate at
> > > 1.8 V when entering DDR mode (although 3.3 V operation is supported),=
 while
> > > the mainline kernel lacks any mechanism to switch voltages dynamicall=
y.
>
> AFAIK The Pine H64 does not have the ability to switch I/O voltages. It is
> fixed to either 1.8V (the default based on the schematics) or 3.3V.

Should that be handled at the board level then maybe?

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--v6flhv747vrdixqb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXWaFBgAKCRDj7w1vZxhR
xUbcAQDTgCwVjSWuZKxoSkt/fp1VLfWi1UjCpSZ0cCr11a5BwAD8DLgodYfexZWL
iW8NfsUfcOV7SktdFUgfMP1x74uruwE=
=sxYW
-----END PGP SIGNATURE-----

--v6flhv747vrdixqb--

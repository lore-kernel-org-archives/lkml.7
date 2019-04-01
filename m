Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0396FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C6F213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554104948;
	bh=HnJVqeAnj6MgPtswtZD3Y3xZp+N1KhSwSehy96KOHNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ikmFBXlaQRXr3ToL5zr6Ki1KfbWp2/xjgfHNblFRvnzbpGC3+t1NWCafZHjSFINfD
	 g+cI2azmo+MZpoQqLmyhQsapKawJhD9Cqw7GxmNpxQ3bgmf/GmQhTCEIsjuQxvltCA
	 6z5e/8l1IGYtEjwYx3nhdnrjF3PxRtcEIq+Xxgc4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732107AbfDAHtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:49:07 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36178 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731769AbfDAHtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 03:49:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XrBOJXE/K1TNMPytR5nrymtuh7ciNGGdQE216nZJFK4=; b=UcZBzWjamHgV/bNP8w8eBbU52
        75Eu9HTDsR0IgA+9BjeQbshPX91B1yj4GhXSby64PkCG8f9CMbJALLIACTc8mKHmeqRrqEYPJ53J2
        aVf3uys+yqp/Ij2EqKu1QDaz9+x0DL9rGulItCDZuv/OibF1A6OPDFrzEg/bflM7BXLL0=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hArgj-00088C-Bs; Mon, 01 Apr 2019 07:49:01 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 90F3A440082; Mon,  1 Apr 2019 08:48:57 +0100 (BST)
Date:   Mon, 1 Apr 2019 14:48:57 +0700
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, talho@nvidia.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kyarlagadda@nvidia.com,
        ldewangan@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V1 18/26] spi: tegra114: add support for hw based cs
Message-ID: <20190401074857.GK2059@sirena.org.uk>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
 <1553666207-11414-18-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="W/+CTqSGWdiRg+8j"
Content-Disposition: inline
In-Reply-To: <1553666207-11414-18-git-send-email-skomatineni@nvidia.com>
X-Cookie: Use extra care when cleaning on stairs.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--W/+CTqSGWdiRg+8j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2019 at 10:56:39PM -0700, Sowjanya Komatineni wrote:

> Tegra SPI driver default uses SW CS control for transfers and HW CS
> control can be enabled through SPI client device node DT property
> nvidia,enable-hw-based-cs and is used only for single transfers.

Why have a property - if this feature works and is useful why would a
system ever not want to use it?

> +	single_xfer =3D list_is_singular(&msg->transfers);
>  	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
>  		u32 cmd1;
> =20
>  		reinit_completion(&tspi->xfer_completion);
> =20
> -		cmd1 =3D tegra_spi_setup_transfer_one(spi, xfer, is_first_msg);
> +		cmd1 =3D tegra_spi_setup_transfer_one(spi, xfer, is_first_msg,
> +						    single_xfer);

It's not sufficient to check if there's only one transfer, you also need
to make sure that the driver isn't using cs_change to use non-standard
chip select handling.

--W/+CTqSGWdiRg+8j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyhwmgACgkQJNaLcl1U
h9Cd2gf+IZg5c+h4154oTSypXNSKODiicQai//JHZ+vsyi8kNDmkDif8XKvC8xLJ
osqeztdDZ6jhaIM4G2ar4A7kLWqnA/s5iLl/vOCUgmKj6r9qhHh1BvWOli9GFpnz
9KCXQOQRaXUY6Fja4oF0z7fk52xPIWoh2XrJPuUy18sfla52jMFxIQWu7p7WItd4
Wq57omDJVMJ6gxHYhmD4ED3cGQo3pWI1aRQPvbdMopRCGI5YSAtToZjrnbFByYRg
q6RCcD7BcWoihdUKPeXpeq4oM0MZXrZYfISZe8/7VYgI6b5WpXZC/4sgUfTFVzbq
E/8rSGhA1a2xURQV/0bgEK5cKMzpHg==
=iU8U
-----END PGP SIGNATURE-----

--W/+CTqSGWdiRg+8j--

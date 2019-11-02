Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F17CA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 15:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F21D420663
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 15:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572709249;
	bh=ixoHOTVHRLDxCWfvZIdJ2yDzmRsS3DJ1UxXSSRLuEfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j1SE4jvou0q27bP1Nq3WryXO4SShWPJWZfNoUSrvk12N9rxxtEZf5XxkWpWamWVis
	 YWLja6drQchsUydD6YBGct9Bpa/VJUwIxQhV/mFvVsiVWcs71HLQnP82muD6SCe046
	 LNF53jT3wyueEo1px/fjimhCqRDT5NSHJWEr//x8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfKBPkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 11:40:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:39474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbfKBPkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 11:40:46 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5819A20663;
        Sat,  2 Nov 2019 15:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572709245;
        bh=ixoHOTVHRLDxCWfvZIdJ2yDzmRsS3DJ1UxXSSRLuEfA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pAjN/KeF5Bdy7IbfQh6xKI6rnWkUlvboGue18CzO9byHOi/+Jy+53+DV4SAKSDynd
         7lAJFwZBBMceupgPm3seDL9L8kOj1AVLawBYbvR071I6gxbuOnL/H/93YAHvf5hJ1R
         oiY7hNkL+BzAXPLFU7zYgGqbprDyV17XZuXEBT24=
Date:   Sat, 2 Nov 2019 16:40:42 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: allwinner: h6: Enable GPU node for Tanix TX6
Message-ID: <20191102154042.friao2rlmergzt2p@gilmour>
References: <20191102120427.19350-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2gt4cvqwobr7lljk"
Content-Disposition: inline
In-Reply-To: <20191102120427.19350-1-peron.clem@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2gt4cvqwobr7lljk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 02, 2019 at 01:04:27PM +0100, Cl=E9ment P=E9ron wrote:
> Unlike other H6 boards, Tanix TX6 doesn't have a PMIC so we can enable
> the GPU without providing a specific power supply.
>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>

Applied, thanks
Maxime

--2gt4cvqwobr7lljk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXb2jegAKCRDj7w1vZxhR
xbOmAP9dPuOKLyRWvCNQd+Pt0s0yp2OsQrHFJevcolwW1K+aBwD4nCS2u0DLBsHd
xdLffKhx91+L6l2+2J3AhunGizlZBA==
=+WaH
-----END PGP SIGNATURE-----

--2gt4cvqwobr7lljk--

Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3218BC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE7AF214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565609210;
	bh=WMX5WzUBHC7wrBcFibKuCXcsI0mYQCxfu+77DTSZQHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OKZdUbrs9KUP7OJbcBanNEKTjfIw3FCfNTQcSz5JdfdMOgAof9FnqEsWCAxZbZnU6
	 JTWYg5R+qmEskHIwpWrnkgPsLcAkZQMU++HsExrh6O1EnOB0yo+A3Bo6+h0KwnSHmS
	 ohAWrE6IF5+nMKBzJfZpsCVJuTlDDOEBTDfVwmlE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbfHLL0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 07:26:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:52534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727691AbfHLL0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 07:26:48 -0400
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E86E208C2;
        Mon, 12 Aug 2019 11:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565609207;
        bh=WMX5WzUBHC7wrBcFibKuCXcsI0mYQCxfu+77DTSZQHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jmrlemJOZkcq7TFqEpSIyvlO5ThYDd7E/0FPazJ/0SSO95N8OALMPNG+Dv9Lzu77H
         oD53cj2dOs4yc31OKOaVSUa6DJLcG0nIUJ+RixdUj91vIqWuImq8HAjj7rlCdG7QIC
         04knvFtiuXW9NftL4mCeQcu9dp9bNGim2mOXEHbk=
Date:   Mon, 12 Aug 2019 13:26:45 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH] arm64: dts: allwinner: Enable DDC regulator for Beelink
 GS1
Message-ID: <20190812112645.avyyf5iexxatgrwe@flea>
References: <20190812102355.22586-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="myuur5a3gwhb4nbt"
Content-Disposition: inline
In-Reply-To: <20190812102355.22586-1-peron.clem@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--myuur5a3gwhb4nbt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2019 at 12:23:55PM +0200, Cl=E9ment P=E9ron wrote:
> Beelink GS1 has a DDC I2C bus voltage shifter. This is actually missing
> and video is limited to 1024x768 due to missing EDID information.
>
> Add the DDC regulator in the device-tree.
>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>

Applied, thanks
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--myuur5a3gwhb4nbt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXVFM9AAKCRDj7w1vZxhR
xXlfAQCzGoHNMF6inUbK/DxstBsOVMBjL9GAKYk4ftUwdU7LDQEAq6yMKoeAHhfX
FQiNLVXWJr+pVOrIPUOnWyLlp/Ocrgk=
=XUMj
-----END PGP SIGNATURE-----

--myuur5a3gwhb4nbt--

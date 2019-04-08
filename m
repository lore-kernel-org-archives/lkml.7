Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52E9C282DD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 06:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8276C20833
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 06:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554705497;
	bh=Jb/AZKlkZn5Fk45U1JLCMpgl0Zr9clnxsxmGk/jvdhA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WJqDA5Apc8AJRUUps3HRIlwTLX/SgSVdGT3saV5qGOllsKni3x6mbGgVsgmVZG+hF
	 Xf7bRFkRqFq4W15fkNHWdCv/nNMRPFvo/BoW+eELevmXSPSuIY4OjrvlXQGEjuRzsw
	 y9FXIg5oMl8yLbyPGdclgBuLBdoDIvEZi5ywxnQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfDHGiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 02:38:07 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37322 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfDHGiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 02:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=g9Wqmy/TaeacjPVG1SqNfKJAbxOr29MphTAyMzcWaQI=; b=eR6OwDUz8mxZVfQoHQrR6O8EX
        P/c+1PBRXuLrh4D3fsQr01tVH3ys7yhlXMzzSoGa8HWCkXTn3Nvl3x4BOrApVI5/WI/ftl+Qcg55j
        m3hVTRgoKwwjzsOalfdHk6d9RjWPscag3ZGpzkE8lVjoMsz1AfHY29ial5SAdIQwcsDfs=;
Received: from [8.46.76.46] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hDNup-0003ef-TC; Mon, 08 Apr 2019 06:38:01 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id B5224441D56; Mon,  8 Apr 2019 13:28:19 +0700 (+07)
Date:   Mon, 8 Apr 2019 13:28:19 +0700
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, talho@nvidia.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kyarlagadda@nvidia.com,
        ldewangan@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2 11/20] spi: expand mode support and add LSBYTE_FIRST
 mode
Message-ID: <20190408062819.GJ2803@sirena.org.uk>
References: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
 <1554423259-26056-11-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="F4+N/OgRSdC8YnqX"
Content-Disposition: inline
In-Reply-To: <1554423259-26056-11-git-send-email-skomatineni@nvidia.com>
X-Cookie: Shah, shah!  Ayatollah you so!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--F4+N/OgRSdC8YnqX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2019 at 05:14:10PM -0700, Sowjanya Komatineni wrote:
> Some SPI Master controllers support configuring Least significant byte
> first or Most significant byte first order for transfers. Also some SPI
> slave devices expect bytes to be in Least significant first order and
> some devices expect Most significant first order.
>=20
> SPI driver declares mode and mode_bits as u16 and all bits are used.
>=20
> This patch changes mode and mode_bits to be u32 to allow for more mode
> configurations.
>=20
> This patch also creates SPI_LSBYTE_FIRST mode to allow SPI clients to
> choose LSByte order or MSByte order through the device tree property
> spi-lsbyte-first.

Please submit one patch per change, each with a clear changelog, as
covered in SubmittingPatches.  This makes it much easier to review
things since it's easier to tell if the patch does what it was intended
to do and means that if one part of the patch casues problems it won't
hold up the other parts.

--F4+N/OgRSdC8YnqX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyq6gIACgkQJNaLcl1U
h9DuHwf/ZtMyHrfW3WzW3cRTFF1ocpo6CZNO/MsgbS9BbngjgkNeCST7eNBKSUIx
PRhkYretkGShqbxWzCcImUTUuMcJfD4ssKG9DGWiYAtAs8kK0YRsPgrmWEjKNwDm
tUf5RsjgebZukSQo/Ba53PNmWosGCg1STb2gs8ZWE8HO/zxCGH6DFPSgMuRZk/iB
bTwVJGKKXuNW2UMMCRwvv6b5+Zm8E/HWGwlfXBOeI1X9WXKNhWUQfl0bIv0qps59
ViMc+YMFcSD1JRE1471cWONSKbcMWPx7TQFUaQBBszdRn+asko27l0hHcvH7chDt
K7/zgtAI3QFNjfN3Oc1UPzMrfk4c3Q==
=XP4S
-----END PGP SIGNATURE-----

--F4+N/OgRSdC8YnqX--

Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA5AC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 09:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2912C2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 09:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557912929;
	bh=nBQ5nMWhbC/YuNyAQbbT0fMAJ498XMGyauSYgCVkDUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=io1U1lhD8qimJcU6e5GhmE5bxhE/hGX62noRM5FUf/kdHBOugAOqGGIhpF40saRyU
	 Vj3jr2gpG+VlzCeHP+t4uIGvCsHer5dsF4qAEezuCfY93a9ppBu5m/O10gei8j9mB0
	 imWtOEt6VDYTuYacq3KaFqb6cReTtp1AEVpj9KiA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfEOJf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 05:35:28 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50890 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfEOJf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 05:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=h6tbazTbo2wFwWyE9fnl5htOCMABGokXLkWNr2arzpU=; b=xKOja/nU32roMxp3sGAIfk0pT
        e8z52PIxjOZoe8uytGhx4H5amhlD8MgtXrkbfnbCJ1bo1CBSdgAnJ9zCjQcTEmNcQ+6Yul7w8qAo3
        HIYEEjIjJ9C+/p7ZufngpGmsluK21EjB1jeAAeYbnmmFe3/UCPl9GZrFDy/IcT3SNn6cM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hQqJo-0003Jh-5B; Wed, 15 May 2019 09:35:24 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 90C3F1126D5D; Wed, 15 May 2019 10:35:22 +0100 (BST)
Date:   Wed, 15 May 2019 10:35:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: [PATCH V5 1/4] spi: tegra114: add support for gpio based CS
Message-ID: <20190515093522.GC5613@sirena.org.uk>
References: <1557810235-16401-1-git-send-email-skomatineni@nvidia.com>
 <1557810235-16401-2-git-send-email-skomatineni@nvidia.com>
 <cf4bd167-49b8-5649-a2e2-7bf5ddcc6e2d@nvidia.com>
 <BYAPR12MB33986B88CF3A30036E3F1F04C2080@BYAPR12MB3398.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="raC6veAxrt5nqIoY"
Content-Disposition: inline
In-Reply-To: <BYAPR12MB33986B88CF3A30036E3F1F04C2080@BYAPR12MB3398.namprd12.prod.outlook.com>
X-Cookie: You will lose an important tape file.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--raC6veAxrt5nqIoY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2019 at 05:18:48PM +0000, Sowjanya Komatineni wrote:

> Tegra SPI doesn=E2=80=99t support inter byte delay directly to meet some =
SPI slave requirements.
> So we use GPIO control CS in parallel with a dummy HW CS and use inactive=
 cycles delay of SPI controller to mimic inter byte delay.

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

Please don't ignore review comments, people are generally making them
for a reason and are likely to have the same concerns if issues remain
unaddressed.  Having to repeat the same comments can get repetitive and
make people question the value of time spent reviewing.  If you disagree
with the review comments that's fine but you need to reply and discuss
your concerns so that the reviewer can understand your decisions.

--raC6veAxrt5nqIoY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzb3VkACgkQJNaLcl1U
h9DDwgf+IgSDwzI5qR9A6I3NzqXiuPcYQwmgXzmah1o3/xQ9fvEAUz4bAkK2FkqX
VtvQy+JWAMR/3O5ydxa3czZfwgWVTXvwM45kwrgye/uuc6plpsJmsHPNraBuy28z
iPEJZSuAWrhTYT/5sHrjAv4tEapzYRBMs/HIYxXclBbz3mvHy9TvgF49iwgScJF/
p2GZVLoX2cfaxzvhdFzV2HZrJA/838DdOp06vKR1PPr7csfwDtTBOnjpMd6WLEJ1
pi/+g/kRW7qCzshGjqBhKGorhPo5HONC9qap8+D1RU8ol7p4JjuxgDhjgaSDa/rY
x/RgG+BBwZjujStSaE/v31pqdFUAzA==
=GuwL
-----END PGP SIGNATURE-----

--raC6veAxrt5nqIoY--

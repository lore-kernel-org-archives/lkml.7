Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58282C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A27F222AF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555698103;
	bh=mndNB3NJKtjTSXWqW7UKN7Gn1zfIUq8XEhxf+xj0RFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iIbp4B49bStF9fMEF+kXAOvd3tGuWt3eD8Uh9qPLyEcd19BGL8qn5rdIoqY5TTI+Z
	 jg0KQsLOnbFT+ZyG9wNeG/QPThoM/t30szbh0Z0tTCgB/XTjpvpHkqNCp42xb/D65w
	 PyKDiXBenr4GZHq0CMECSJckT5gslvL0lluTQKjU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbfDSSVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:21:42 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38528 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbfDSSVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:21:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6njRe5o8G6A+ppBgPdqz2Z6b688AhITNwzCSnl4pMIE=; b=Oph9NWt2oKBUOzs4gd8+/wNvw
        qwqXgco4cvwrNzOWmL2pW1dLljwWTXpwEyYOWjnWGVgkrytcXlFQSfxeFGDb5ZcEIZOcZTcD5pewX
        QsFKn2q08xDPbu7fmzkx5myCwFgafQ9ILbezAAmhbRHJoZODB12O/I3jkipNhR/PiMddU=;
Received: from 188.29.164.213.threembb.co.uk ([188.29.164.213] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hHVL8-0008HD-AH; Fri, 19 Apr 2019 15:22:10 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 6FCC6441D3B; Fri, 19 Apr 2019 16:22:08 +0100 (BST)
Date:   Fri, 19 Apr 2019 16:22:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, talho@nvidia.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kyarlagadda@nvidia.com,
        ldewangan@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V3 3/9] spi: add SPI_LSBYTE_FIRST mode
Message-ID: <20190419152208.GT2803@sirena.org.uk>
References: <1555363834-32155-1-git-send-email-skomatineni@nvidia.com>
 <1555363834-32155-4-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pnDjx0H/VpusRTEI"
Content-Disposition: inline
In-Reply-To: <1555363834-32155-4-git-send-email-skomatineni@nvidia.com>
X-Cookie: Shah, shah!  Ayatollah you so!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pnDjx0H/VpusRTEI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2019 at 02:30:28PM -0700, Sowjanya Komatineni wrote:
> Some SPI slaves expect bytes to be in least significant first order
> and some expects most significant first oder.
>=20
> This patch adds support for requesting SPI master controllers for
> least significant first order using SPI_LSBYTE_FIRST mode.

This is byte ordering as opposed to bit ordering which the core already
supports.  Do you have any examples of devices that need this or is it
just being added for completeness?  If devices are going to rely on this
we probably need emulation support in the core I guess given that this
is a pretty unusual controller feature.

--pnDjx0H/VpusRTEI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAly5558ACgkQJNaLcl1U
h9ABdAf/VSTPgRMQCRuu5mKG7sETGap2gcwbgefEWavIGVVyUwfycisAdwMX7fnz
o9BCutybIvNC09o6dTuMEwJEVfYDMDQGdLY337ofB/O1lOKbFNp51bOC5knj69Rn
rX1O0T5DP9pHAbAWle473JCt4QXoLjw6bfasqZww/g6GQBQVFTMFw5RAI6Tbdwci
OSEmszHN/b8s6u5oty9GmPjc0kn2SPoahgM4myTvTBNFrzabvsfyXhV7XeaHOox8
kmMRDhZ2X8hrOkBpno4nFW63ZmVzKgqKkcrNoERIPmzw6awYpNCaWmvIA88Ba/es
TMw7K+3CDCo+OOrDtOWR/CQ2VCUNAw==
=00zp
-----END PGP SIGNATURE-----

--pnDjx0H/VpusRTEI--

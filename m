Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8FAC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9202120643
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554179137;
	bh=+vSgYABV/ew6RMpnSop/p2u+RbTsJ6Oli3qTtLNorrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mRQqBzFglzI08I/zNCcB00tLKt5J1MSazCRarIucZwfmJfzIOf/E1JhcVBd9LGAX1
	 M4tI0QZRCfuFrfSja+YWXjYuGHaTNPGVt/p2ms6kBAZVMWC/2lBMkNOOJHw3cOhl2g
	 feSQlP1kT9Cz3CfhrlF0y8uRNiVDQIkzUUz3hg7A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbfDBEZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 00:25:36 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50944 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfDBEZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 00:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KwXc7XHefa4E4ENOaLDa8Tie/RfoRX9wV6MkrGF00Go=; b=fwG2wuP38r33B8bq2KcmH88i0
        waPmyxaRL06YBE+HI2PD5iMiZOU5Xz7ogCViD7g0aR/ANroBcY8bYZIwaty5lNMR44wsCKUuRmOyP
        DkeH1H5E4hsBg5oByJomfS9iJhqxnKdEwfcLHw+YrQvuqZiW9EjVNM2s8r21YweOaac4A=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBAzK-0005hZ-0k; Tue, 02 Apr 2019 04:25:30 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id BE1F5440082; Mon,  1 Apr 2019 10:17:53 +0100 (BST)
Date:   Mon, 1 Apr 2019 16:17:53 +0700
From:   Mark Brown <broonie@kernel.org>
To:     Randolph =?iso-8859-1?Q?Maa=DFen?= <gaireg@gaireg.de>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] spi: tegra20-slink: change chip select action order
Message-ID: <20190401091753.GP2059@sirena.org.uk>
References: <20190329174411.13832-1-gaireg@gaireg.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QKpLca3blcvhMJ0W"
Content-Disposition: inline
In-Reply-To: <20190329174411.13832-1-gaireg@gaireg.de>
X-Cookie: Use extra care when cleaning on stairs.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QKpLca3blcvhMJ0W
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2019 at 06:44:11PM +0100, Randolph Maa=DFen wrote:
> To transfer via SPI the tegra20-slink driver first sets the command
> register, which contains the chip select value, and after that the
> command2 register, which contains the chip select line. This leads to a
> small spike in the chip selct 0 line between the set of the value and
> the selection of the chip select line.

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

--QKpLca3blcvhMJ0W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyh1z4ACgkQJNaLcl1U
h9BDYgf/YxJE2IHgyTgkto9LXOZqZugnVydpvQUWbP2oMfH2WkmNmnGlkfheNMCX
CG7QiiEJ1ynANmzUkhSa7TZ6dVYDKc2Jrd58Bth540GSOhL9ceRsueaHtcH/glYs
qDuha+hrPYhrQT3x9YcgS1lr6fzTO62aypzjX0cc/CcNcPzURQL9FOuMHtFyElG3
SVHWVIBJnrMGac4te496gGdZe2oXBOv5QN9jcViRvRGQSYCJX2NJpyfpQmWj9sbZ
H3d1N1gfc53ailiOM9JVKmjTQgOR8r9XADjukWUw/NUwDyJw7RgAcWEj3VGo7Sen
6pEk4fP6z+P8lYmEX1OD3zTnNz9Bcw==
=406+
-----END PGP SIGNATURE-----

--QKpLca3blcvhMJ0W--

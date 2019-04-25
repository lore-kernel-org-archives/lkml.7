Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91C9C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52AB72084F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556214114;
	bh=z30ieZT6D5+Gm7c3sdJY+JUh/cQNgf3u56+2m3ku9Z0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pQWQpKX+fj/fnhcWOGBGaegIB8n9AwVjEqvq/7hER8NybhlCIKp2rFgZ69ayscSkl
	 SdPqGVz1EvMYJ4NsnDB3FHQIo0bM8QXxmdgw0ejler/w6T6NMF+eilIe9aaqFGPGLb
	 pkzf8++2QlcDt0VAkexgHW46uNLXn+sh6XJiCYhE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbfDYRlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 13:41:52 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45558 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfDYRlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 13:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=z30ieZT6D5+Gm7c3sdJY+JUh/cQNgf3u56+2m3ku9Z0=; b=kNFVqt6C6qL/bkP8GPs+QeSiO
        ivZ09lgqmM9QiO0lSOTtj41RyzilVossahFtKIMBpEyt+0sjfmiV7UX4gqSa0o2heK8P68OKgCbVH
        7RoHlOOQYEgE5DM3TsPqGVzRejhMSQfzjuV92jA69/xNvmZjL7Kx1aXIcYRLIy9bTRlcE=;
Received: from 92.40.248.65.threembb.co.uk ([92.40.248.65] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJiNV-0003Mh-IE; Thu, 25 Apr 2019 17:41:45 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 36A96441D3B; Thu, 25 Apr 2019 18:41:44 +0100 (BST)
Date:   Thu, 25 Apr 2019 18:41:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Mallikarjun Kasoju <mkasoju@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] regulator: max77620: Support Maxim 77663
Message-ID: <20190425174144.GC22575@sirena.org.uk>
References: <20190424224900.8018-1-digetx@gmail.com>
 <20190424224900.8018-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="B4IIlcmfBL/1gGOG"
Content-Disposition: inline
In-Reply-To: <20190424224900.8018-4-digetx@gmail.com>
X-Cookie: Drilling for oil is boring.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--B4IIlcmfBL/1gGOG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 25, 2019 at 01:48:57AM +0300, Dmitry Osipenko wrote:
> Add support for Maxim 77663.

Acked-by: Mark Brown <broonie@kernel.org>

--B4IIlcmfBL/1gGOG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzB8VcACgkQJNaLcl1U
h9C5MQf/e2dZ7OiWk6YvNr2eKFK3rstlkbMyDYubayOmpQ+34xTFCBU3W6VHjoPC
kF+Aqr8vVUh8VFcEAU/kw4V7P5ghtZ8IPV3SrT4Ta1dP4ntd12SKkD9EwBIsXlGg
NrSblWxWunv+aSUaPZ/1gkdvJ+orhRkul+f8yoxPZGKqcGhvDTcBOIfYYkxSfqm9
d8OEf+hf9hNC1uxg/Jawtm/8oi9hYQEIQm/sm6M33DkBkScHkhUXYZB2KQRWx3LE
wnryRHfks1n1aXDudkiBwjpXZ094cBTtx519NZR7DQKNZ3TMQZVe6T7t9cIF0RN/
rRUgO7y5ZPqYJnP6iK6UxLWfW4TH+Q==
=AyPs
-----END PGP SIGNATURE-----

--B4IIlcmfBL/1gGOG--

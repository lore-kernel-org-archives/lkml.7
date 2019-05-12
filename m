Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74844C04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46E4B2173B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557680783;
	bh=p6OWInJwZBJiI99YrSxWGAImNFc+IMjVvhSnNs0jVFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZbBEK77boBDupqkcKZInQAH7S2YwRROXtT5dJDSQ/5FImuS8Cq7D1vb/2YpaO0Vdo
	 nD9bo3fYjm3eBqgzaKE08VUrsceZVQ7jPXBuwnWJCKkZtITxi3OqoES2drvp+F3jV4
	 CLvK/7jPUTDpGhpsLYrLfEphXL+cHvw2PrNKhg+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfELRGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 13:06:22 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49574 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbfELRFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 13:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=f61YpczbbTMv0calrg2aAD9rT2tVBXPGrc7DIwQXTro=; b=hHby0WejM3CuabDfv3c1pDZLf
        9FuQRW5VhKm1rJjiEfCAiHgpTsOtAzbbPlzMOyPWHzWRPcQZGddpc41kDpqXuUWoZzYQ08RS9pvbM
        e9u/glImqcaHzcBjbSo7H0BXJgWEm13FFpV0G2mdpmrpq8hiWBcc+TZuH2pfwI79PnxdQ=;
Received: from [81.145.206.43] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hPrut-00044T-MU; Sun, 12 May 2019 17:05:39 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 0C9CB440017; Sun, 12 May 2019 08:42:53 +0100 (BST)
Date:   Sun, 12 May 2019 16:42:53 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-rockchip@lists.infradead.org, drinkcat@chromium.org,
        Guenter Roeck <groeck@chromium.org>, briannorris@chromium.org,
        mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/4] spi: Allow SPI devices to specify that they are
 timing sensitive
Message-ID: <20190512074252.GD21483@sirena.org.uk>
References: <20190510223437.84368-1-dianders@chromium.org>
 <20190510223437.84368-3-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+B+y8wtTXqdUj1xM"
Content-Disposition: inline
In-Reply-To: <20190510223437.84368-3-dianders@chromium.org>
X-Cookie: HOST SYSTEM RESPONDING, PROBABLY UP...
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+B+y8wtTXqdUj1xM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 10, 2019 at 03:34:35PM -0700, Douglas Anderson wrote:

> + * @timing_sensitive: Transfers for this device are senstive to timing
> + *	so we should do our transfer at high priority.

Not sure this is the best name.  Every device is timing sensitive to
some extent and it's a bit wooly about what it's trying to accomplish,
it's specifically about the timing involved in ensuring that the entire
message goes out as quickly as possible AIUI.  I think if anything I'd
just have the caller specifying a RT priority for the thread, but that's
awkward as we might want to switch over to deadline at some point.  How
about just calling the parameter rt the same as it is when the
controller does the same configuration?

--+B+y8wtTXqdUj1xM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzXznkACgkQJNaLcl1U
h9BbrAf/QuZJvvnzSN9f3YRIMrxOcWjPSXe8m7cpjjYwT8RgFk/K/D2EtHZqpPa8
elj2mlHof5nWuPrCydyTZz4dV2Q7K49cprgr2q7oK+nifKWCIVDFZvB5NjIP165o
dI34Xs1qOUui3KPVSl1CGed2W9d2y+5TEck0os5MsnjpL89b4NrMr/lq3z8zZ0dE
6WfF7Tr49s10iLyo0g7QYPqvw1/nGoxKloIEGs2j2GALOqzDZgd6UjXOTig8UfgR
VYCn8zQ3IO2FBFLnnS+jSqzNwacaKtqLIP+4oeKiQWCzIiw6HDvV/vMbOg6PvAUO
cWErMjpY5aVcL/XP4BawO+V+ivVgVw==
=Eybc
-----END PGP SIGNATURE-----

--+B+y8wtTXqdUj1xM--

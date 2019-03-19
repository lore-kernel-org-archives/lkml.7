Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FCBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2BB82146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553000501;
	bh=lmqxsl1xin+NweTXv9eP9kV2rNfl3zewBxkHmoXQW7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Fj+Fj2qF52eNWGhecMxmOb+tQWLHe4PHe9LCt9ilN+dYHNkujvwY5zZ+7zQQ9GHF+
	 DyoNvEsE/dLe2oKl5GXfL7M3rs9e4jf68E6mLiirsnTIok4EeXE+R/hD6eM8gz3Dj6
	 OepztZUlJkYBy8420I7/EPi7Sjx9A6FL5YKAu2hQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfCSNBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 09:01:40 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56676 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfCSNBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 09:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lmqxsl1xin+NweTXv9eP9kV2rNfl3zewBxkHmoXQW7s=; b=EhJC47jA/ZDP0i4coV/EegiTp
        LWEea6LixjttFOA4G0UTHNADDUNjMmwKEpKmvmJgUO2ZsyOca+ezdaQZcPtq2xliWJ19nytvrLciJ
        0ZOb/XPpujNBeoQ/Y/lypNPL9+E5Qfrbkd2Ku5Rye8VaXdcu+/Pj64hDGKnGX0xHFCXwo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h6EN5-00031P-6M; Tue, 19 Mar 2019 13:01:35 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 8E6B611288DF; Tue, 19 Mar 2019 13:01:34 +0000 (GMT)
Date:   Tue, 19 Mar 2019 13:01:34 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 4/6] regulator: da9063: move definitions out of a header
 into the driver
Message-ID: <20190319130134.GD5514@sirena.org.uk>
References: <20190318154759.21978-1-wsa+renesas@sang-engineering.com>
 <20190318154759.21978-5-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vni90+aGYgRvsTuO"
Content-Disposition: inline
In-Reply-To: <20190318154759.21978-5-wsa+renesas@sang-engineering.com>
X-Cookie: PURGE COMPLETE.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vni90+aGYgRvsTuO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 18, 2019 at 04:47:56PM +0100, Wolfram Sang wrote:
> Those definitions are only used within the driver meanwhile, so put them
> there.

Acked-by: Mark Brown <broonie@kernel.org>

--vni90+aGYgRvsTuO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyQ6C0ACgkQJNaLcl1U
h9AbAgf/dHp2suacInailmibsa6sHXFHFH3Y/YWTdj3VUHWgteCfmnSr9UpxV+Dw
/lpC1r+hXzGjof9eoe4pJtHSan1GFAKz51ycikvKiAdBg4V39Rve7Rh63Yca5ks8
CXhXhGS1nEWngr5ho/x7K89I21YNxVv1o0BCERmwHHKWiJGmIZ60nO8SwL7upJyd
bOXOcI4cY48MhqJYoFfSZu2GDaX1s0jU0f40MHc8MhgobUUwAdK/5hWU0tsCVF5I
91nL9iqfsgLRCRZD21xUzuvVR9mmME8NyBg5Q37PjKpA7SOUFJTlFPaIaqTdCHRS
EZzMCJRxlNYoZkQQDZImZD73BlOZ2Q==
=YkpE
-----END PGP SIGNATURE-----

--vni90+aGYgRvsTuO--

Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF703C46470
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B28DE2173B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557680796;
	bh=IVwVVz/LmvOQ5mEEi2TI2p0k4+pdD5FUmeet6/++rjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Kx7xnWbLTVyigz2g972FbN+92hdjsjaFYNDsdvZCfBP51cdTj3eDlypzqx5AUUVor
	 pkupw53FJt8XDD1vJVZ+Q5aGpF3ooUzKvdXPzIl9XSu7rOUknbstPJzab8gAi9z6fj
	 xzMMzhU1PXClO6g0T0Ypaau0csalOzwkvKVLmZyg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfELRGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 13:06:35 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49324 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfELRFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 13:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=g0o6QTLEOtgvR54hMzPmyJFqu/fIVI/i9nJj0DYc180=; b=NuYX5Xefn+tpSrY6feFiLvbNT
        fe77L/itDkUAtYBI3Xih9ZXu9S5a+TbAO83cm9CaQ867LR9RZbuxs3YUZ56VyBOdk0lnk+21WRjKE
        kh/h2lYBp+6kEmShmacXNlQ4sYS5dmr0ozRMbj2ZsQuBQCy1L7riwB7ayr0O9M4pgbR8M=;
Received: from [81.145.206.43] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hPruu-00044p-9z; Sun, 12 May 2019 17:05:40 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 6A56044005F; Sun, 12 May 2019 10:04:46 +0100 (BST)
Date:   Sun, 12 May 2019 18:04:46 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 6/6] soc/tegra: regulators: Add regulators coupler
 for Tegra30
Message-ID: <20190512090446.GN21483@sirena.org.uk>
References: <20190414175939.12368-1-digetx@gmail.com>
 <20190414175939.12368-7-digetx@gmail.com>
 <20190508075848.GX14916@sirena.org.uk>
 <af6de446-ab45-1745-30e5-426c6b34421f@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b/Q3JWIUAuLE0ZFy"
Content-Disposition: inline
In-Reply-To: <af6de446-ab45-1745-30e5-426c6b34421f@gmail.com>
X-Cookie: HOST SYSTEM RESPONDING, PROBABLY UP...
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b/Q3JWIUAuLE0ZFy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 08, 2019 at 04:27:42PM +0300, Dmitry Osipenko wrote:

> Constraints:

> 1) The max-spread voltage is 300mV.

> 2) CORE voltage must be higher than the CPU by at least N mV, where N
> varies depending on the CPU voltage.

Those seem like they should be doable in generic code, though the fact
that the constraint is variable makes it annoying to specify - otherwise
it'd just be a minimum and maximum spread.  I'm not really coming up
with any great ideas right now, it's getting into OPP type territory but
it sounds like there's more flexibility for ramping the core voltage so
you'd end up with silly numbers of OPPs.

> 3) There is a constraint on the maximum CORE voltage depending on
> hardware model/revision (cpu_speedo_id) where a higher voltages
> apparently may cause physical damage, so it's better to hardcode the
> limitation in the code rather than to rely on a board's device-tree
> description. This constraint is quite vaguely defined in the downstream
> kernel, I'm not really sure if it's solely about the hardware safety.

I'd expect this to be enforced by the cpufreq driver just not selecting
higher voltages on affected parts.

--b/Q3JWIUAuLE0ZFy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzX4aoACgkQJNaLcl1U
h9BiSAf+PlAvjLtCQwRR2XCmR5U+AAAivAT1sm0iqUlGmSdBNtuUBw609WkyoTmA
KoNugG/GkOu80UcYui0jUCeRfvejDmWwCchaus32RReYk6Ba9PNDw0LMNpbQGIAq
j0o+h0Sy/U7LZxRh/945sGUNmnrpRySwIfl1ethg7mlVUrJJfOoGwEIvLjGazE1i
xrFjQzDWxP/8XXhBTecQN47o6giksCkvdr6FMF7EX//STlsEuZIFQsen0EM8P5QG
QAN+aLmvrePr7FFBwxeVavmzdQZo5aRE5KQ/OYSIQD4FRBDGE6kmhapQa0+djsPv
W5+GFDWNTOrCFEU7TJXZIl5Po5ijlw==
=25S4
-----END PGP SIGNATURE-----

--b/Q3JWIUAuLE0ZFy--

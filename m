Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D13C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B145721874
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560956810;
	bh=66EX8TEZZ7OKHcQ2izZyrfFxJKOCLHMiSEehSG6EsVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z/YcXrxj+KBZKAaoqz+njVuwTS5LQD1lKBrlRiQKycG9n2zwHcuyqdBv2Kr8pUIDm
	 VsDPEl85eDsvuLDfHhDqDljn/e/6jwLxBaV+SpmhvygePhqbl6dj6BpNgP2z7gVS9v
	 AGEd+x+Wb021xujDxhxDtzImLmorp5rtZYkMQKmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbfFSPGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 11:06:49 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58368 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729179AbfFSPGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 11:06:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=66EX8TEZZ7OKHcQ2izZyrfFxJKOCLHMiSEehSG6EsVg=; b=r6PK4fzRtM7TpxW7NpH/G9Egy
        VKh8mid04p/2HJjYcWiaOxUmGcvM4GQRqmnAVKuNkQUxVOaHtB525iqFyk0citQpPLNj9jG1PGCXQ
        lmUDfECZwqr76biElSqEMkX45mCNMcMd0R376BGzRySlEHQGSXzFJonj/Bay57lt6bajU=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hdcAg-0007SZ-7A; Wed, 19 Jun 2019 15:06:46 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id D7907440046; Wed, 19 Jun 2019 16:06:44 +0100 (BST)
Date:   Wed, 19 Jun 2019 16:06:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Steve Twiss <stwiss.opensource@diasemi.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Felix Riemann <Felix.Riemann@sma.de>,
        Support Opensource <support.opensource@diasemi.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] regulator: da9061/62: Adjust LDO voltage selection
 minimum value
Message-ID: <20190619150644.GT5316@sirena.org.uk>
References: <20190619124209.BE6863FB35@swsrvapps-01.diasemi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/7AFTq66AsXNQ7GX"
Content-Disposition: inline
In-Reply-To: <20190619124209.BE6863FB35@swsrvapps-01.diasemi.com>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/7AFTq66AsXNQ7GX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2019 at 01:30:00PM +0100, Steve Twiss wrote:

>=20
> Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>
> Tested-by: Steve Twiss <stwiss.opensource@diasemi.com>
> Signed-off-by: Felix Riemann <felix.riemann@sma.de>
> ---

I can't do anything with this since you've not signed it off.

--/7AFTq66AsXNQ7GX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0KT4EACgkQJNaLcl1U
h9BYCAf/c9Iy4wJLLJ1xBeh3IBrebWIpTxbJaWKC7N9u3yczjD7qOh8vBiF97BZK
5OlNk1bKrGbmVUoEiE7e5C8bqnmB2PTPCme1AN3DUiXXZzOI9cd2MnxW+d8DeGPl
K9t0W00tkkmD4hlEqFmdahoedLSXmY+tbRH4j3RmaTBHx8TQW3px9OOnAFdpYMN+
ubC+GdUdJ8Wa4uC56/al86IkB/fcA6od3vFmW0NIfU9MYwS9xQmodszHXnC00Imq
taOsDvz18HJLY3iIcpJhXY35d+8jElwBcAGzNOHExZ7HAwOkTHcrvn0g7dlHcTty
l+BsjLnN1MDFdxZBvs+97ZX2tsfAcw==
=NVsz
-----END PGP SIGNATURE-----

--/7AFTq66AsXNQ7GX--

Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BCCC606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA5FA21537
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562599892;
	bh=qyBwxgCFWqn1lWvjY/nMZjG/tRC5LA15HbtcLpmzFbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=F1z5ClwiSqBxWj66WV+flFnx1BpT0NeOS4YU8aw88+7y7jNkEa2IDeGPaxXR7iZT7
	 p4wCZ0mb4h1HBIHgZykMji7m29NaRwxsZ4wVBKZ0R8BjAy3rMsWmSIXzDgR1fvBRok
	 /OJPc0+xKVlAz4h6xIwxWo7djXluWD+wS1pB5ON0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389918AbfGHPbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:31:31 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40044 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389702AbfGHPb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TSb9RZHxfeUIgcG4AaJCXnlRIyBQa6Hm5im5gRdlLAI=; b=lYpAV7pyexRRFGgMLB8Yxj4bW
        IfR4+conmhOKMAdcNo69eTK/D2RLLtmdA9nGkDBU3/Nx7/IMnPsdURrFzAyxZE6IqLB536nS0Eg47
        17NtHdMQLy96yG4ygWsXHuRA3GV8bWd7OZGUsWQPGhcquIY8fC19NnYL7a7eIzfga+rbM=;
Received: from [217.140.106.53] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hkVbv-0000cW-9D; Mon, 08 Jul 2019 15:31:23 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id ECD7FD02C61; Mon,  8 Jul 2019 16:31:22 +0100 (BST)
Date:   Mon, 8 Jul 2019 16:31:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     wens@csie.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] regulator: axp20x: fix DCDCA and DCDCD for AXP806
Message-ID: <20190708153122.GA14859@sirena.co.uk>
References: <20190706100545.22759-1-jernej.skrabec@siol.net>
 <20190706100545.22759-2-jernej.skrabec@siol.net>
 <20190706112144.GH20625@sirena.org.uk>
 <24416869.PQYcAB5yxk@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <24416869.PQYcAB5yxk@jernej-laptop>
X-Cookie: Visit beautiful Vergas, Minnesota.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 06, 2019 at 02:44:03PM +0200, Jernej =C5=A0krabec wrote:
> Dne sobota, 06. julij 2019 ob 13:21:44 CEST je Mark Brown napisal(a):

> > This is not a great changelog - what are the bugs and how does
> > this patch fix them?

> In case of DCDCA, number of steps for second range should be 20 (0x14), b=
ut it=20
> was set to 14. So I guess patch author missed "0x".  Currently, math does=
n't=20
> work, because sum of both number of steps plus 2 must be equal to number =
of=20
> voltages macro.

> Same error is present in AXP803 DCDC6 regulator.

> In case of DCDCD, array of ranges (axp806_dcdcd_ranges) contains two rang=
es,=20
> which use same start and end macros. By checking datasheet or just checki=
ng=20
> macros at the top of the source file, it's obvious that "1" is missing in=
=20
> second range macro names (1600 instead of 600).=20

Can you please resend these with changelogs on the relevant
patches so they can be reviewed more sensibly?

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0jYcoACgkQJNaLcl1U
h9DtSgf/URiCB0wuaBFm1xBj0lR4/D/ZwJ69BPtFimhZoiJ51iNYlrGoCrIqwEjo
1M9VM72VcUprApRg0AzDRc17gcABv83YX3ejsUkfORYTpHMTKeo5BdILaDjWkhKu
mLUwoW0ZhLD9vJ8LyHe+pz9SPQnIMsnzJWqJdocqbdodGgfqGT4cxXkv1W4IjAAn
CigWB3O/7IQi6a6rKlH0US5UEpTGcrT4O3A+hJbfRXPYN49pzKMo5AXoCUQtJq0u
A3uXF3m9s1spI2DlWSRzQZdivv9VbFDWimwFrFclfCUudiEPuQ+7Pm5mT1E8PIB9
FCTsHO7Zb789/zwzUq5Ej7zwbGCnIQ==
=5luO
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--

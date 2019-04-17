Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7886EC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA4C20656
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555516152;
	bh=XAlvS4Jw6k318R8PrK7HsVRz7jt4M7fKyVEW8+LIrWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HAfgM2UNC7LMAdlZRKH9ynAVkLs1TcqQQmxaAgwapm7r5lGJa/BYHqZ3cYWUjrInS
	 ac78HyFiDZrfdE5fYsZ4yQAjZQjDuRur0875HNIkvp51DQrY+2Ql21Vt0pZAeKgVFt
	 wsip5BfaCvGYtI1GH7YNhkKoTU0/VZp+tVYpx5p0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732819AbfDQPtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 11:49:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60744 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732637AbfDQPtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 11:49:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=u5rHoHZF6/viqyzahaEaixyUtWbVy9lY7TLd+/uIj24=; b=fPi+QQEbuEApcgNr+DuDdHAKE
        zYmC5AG9yoWZP/df0fXc73FbOeJNa4IhKw5mkabO50PfIo6IKQQuCOG44ZPfixII+7cTtVqFAvvRl
        SwJT55CzMuXJV47wLSWL8124LqgJqV08OwKvaBZUzLKFb0HI6GRv2WzUXWCGzgZCSOtL0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hGmo5-0000eD-MW; Wed, 17 Apr 2019 15:49:05 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 152AF1128283; Wed, 17 Apr 2019 16:49:05 +0100 (BST)
Date:   Wed, 17 Apr 2019 16:49:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Eric Hyeung Dong Jeong <eric.jeong.opensource@diasemi.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        DEVICETREE <devicetree@vger.kernel.org>,
        LINUX-KERNEL <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: Re: [PATCH V1 3/3] regulator: slg51000: add slg51000 regulator driver
Message-ID: <20190417154905.GD5703@sirena.org.uk>
References: <cover.1555389447.git.eric.jeong.opensource@diasemi.com>
 <5e4a6a007e45feac6d35203305cafd865be48755.1555389447.git.eric.jeong.opensource@diasemi.com>
 <20190416152448.GC4834@sirena.org.uk>
 <VE1PR10MB288069C2FC4B6F79AE8F26A891250@VE1PR10MB2880.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="11Y7aswkeuHtSBEs"
Content-Disposition: inline
In-Reply-To: <VE1PR10MB288069C2FC4B6F79AE8F26A891250@VE1PR10MB2880.EURPRD10.PROD.OUTLOOK.COM>
X-Cookie: Boy!  Eucalyptus!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--11Y7aswkeuHtSBEs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2019 at 11:25:29AM +0000, Eric Hyeung Dong Jeong wrote:
> On Wednesday, April 17, 2019 12:25 AM +0900, Mark Brown wrote:

> > This looks like it should be a get_status() operation as it's reading
> > status bits rather than the command we sent to the device - for that
> > just use regulator_is_enabled_regmap().

> I thought that it needs to return current status of a regulator when the =
function is called.
> I am wondering that the *is_enabled()* function is just to check=20
> If a regulator has been turned on or not rather than getting current stat=
us of the regulator.

It should say if we told the hardware to enable the regulator so the
former - basically, is the hardware in the same state it'd be in after
we called _enable() or _disable().  If there's a fault then that should
only affect is_enabled() if it resets the enable bit that _enable() set.

--11Y7aswkeuHtSBEs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAly3SvAACgkQJNaLcl1U
h9Crhwf9H312wObjFKX5Rz+Mwx7XZg7FSv06VMhCQ9BkLOva1gyLRu9r6ZTFM5XP
5cxvKfVvZkoqgH9gxa6Rciqsq/sui+JcVQc5wYgUOkJWEOq31rlF3CnVm3k7tCCI
U8B6o5j2QKK+yUfX1EOG3DshTe8vyZ0h8zEGDPB266jDjaIi8xg+PItqL8BUl7Nw
9g342bLs4nUBQTopToy+xuGJ//QRE1M0+vm+BSwknSN+N9hH6nFRf2ijTJhFUWWi
DEK/vBmKmwd+/eFFU+djUmP/UDzfVVXvD7iLaY/Lw4C/3JUC6xi7qjtQ+lEsOE4i
ERqzG670pPBpTc4/q0j/03br7Ckmdw==
=GfsX
-----END PGP SIGNATURE-----

--11Y7aswkeuHtSBEs--

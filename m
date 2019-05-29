Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF0AC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 11:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCD1721019
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 11:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559128568;
	bh=ymvUg06cR3uVZAead0DxphjXjeUzgb2DfPShyNmSrOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HNSg0KBNeFiNFdRjlmzrV387wpsayrjEDpGkkrIvn3BHhX/Wo6fb+9xYuLzJwpxxA
	 wbcRWTeyrOQDcYuxG8W3W2LtC2GD/W3lK6VLcmJygSGeqNAavYmi8YMzfDtlE/AroX
	 XNsFMtHl+HK4+GgixpJP32qq74jZgOXjUUohzlQI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfE2LQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 07:16:08 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40862 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfE2LQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 07:16:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ymvUg06cR3uVZAead0DxphjXjeUzgb2DfPShyNmSrOo=; b=xbHC+5IWGUh9LKH0aRq2nPxa4
        LwaWJNwmKQv6ACpskI7sYOoUkKbMyixIy+n4hidK/Xkgm8J5i2QkajPPUG+Q151eYhiqqtkLe4XX1
        UMbr7tF+RfSPxyhkga2xetXnRgB7ZxwrP2d4eyWc9Qhg5e9cuuNju+Xtz2LKqOM+KdOm0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hVwYl-0004pw-Ml; Wed, 29 May 2019 11:15:55 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id AD492440046; Wed, 29 May 2019 12:15:54 +0100 (BST)
Date:   Wed, 29 May 2019 12:15:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Duan <fugang.duan@nxp.com>
Cc:     "david@lechnology.com" <david@lechnology.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        Robby Cai <robby.cai@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] Re: Issue: regmap: use debugfs even when no device
Message-ID: <20190529111554.GO2456@sirena.org.uk>
References: <VI1PR0402MB3600F0FB1A031BE502588C93FF1E0@VI1PR0402MB3600.eurprd04.prod.outlook.com>
 <20190528132632.GJ2456@sirena.org.uk>
 <VI1PR0402MB3600AD425469BAF9BCC5CC2FFF1F0@VI1PR0402MB3600.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kUBUi7JBpjcBtem/"
Content-Disposition: inline
In-Reply-To: <VI1PR0402MB3600AD425469BAF9BCC5CC2FFF1F0@VI1PR0402MB3600.eurprd04.prod.outlook.com>
X-Cookie: The other line moves faster.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kUBUi7JBpjcBtem/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2019 at 01:33:46AM +0000, Andy Duan wrote:

> Correct, regmap without device also has issue when power if off, because =
regmap
> doesn't implement runtime pm for the device, but maybe device driver impl=
ement
> the runtime pm for the device.=20

> So regmap how to manage the clock and power when access registers by debu=
gfs ?

Like I say the basic recommendation is to use a cache.

--kUBUi7JBpjcBtem/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzuaekACgkQJNaLcl1U
h9D7agf/dSRk9A2I23hG8npW4JstXPO1trIkiV7i6P6GTvY9ujiGfWA1Q5JcHH4F
K5pVSvuD5gGnSpY3OaPsJv15NW9E6K3XPZmkc/TP4nbbiHM3DZLeXByF/5h9mYtM
LEl6SzxaIrwt5IQ3HdyppH3Ipp0wf7C7RxomSwlTU5PMxu1nGSIRcjtCWJBGGM6J
YAWCP6flJL7Ddcibvx4dhxv5VPFLMg9YEfZNWZYnAk1/YECxgW5SbSsMFqtJNTw6
DokoaLn8K0xCuYfsZnSI3qnIlYXhIcI5Inloylgl+6fzpKf3BRBd+Zcy/DD1ALex
KHMcrFAr5lEAQXSV9mpdpYo4RvEzkw==
=+KcL
-----END PGP SIGNATURE-----

--kUBUi7JBpjcBtem/--

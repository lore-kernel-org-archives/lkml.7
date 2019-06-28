Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3839C5B579
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7448A21773
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561739298;
	bh=aiJProecfCoOFOmMzWWwfmO5TFzjKsVdJFvDr/zMYYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mP2YR1+ijfwVmVZQonnTtXK/eTDx/0J9Icc0368kETmpNUWIGjMELXfNhX5bU2E36
	 Mj56U2Wx+is/UYM7ci18CFMvmj+O5taC+St6b6LIgTvmkZrEiIdP3xZ3u39/wgax89
	 nr+qNVpn43K6dwzkO+tRkKJTumLHXGZru5hfoGOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfF1Q2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 12:28:17 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50944 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfF1Q2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 12:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aiJProecfCoOFOmMzWWwfmO5TFzjKsVdJFvDr/zMYYo=; b=HBGZ+5qpNe4XDtk4pe9C5Q4z1
        5uaCDcqpoKb76uGbK0SMlo3mlLJGiIdvt73p4wedBNFu0A4+LMJdGnDslEkQBY3+FchygQrM9X5r3
        l7fn98KeEEsrcTVcf4Ue4NC+97J4U5bYAg7Svk9esf8foCGUGYAjsZHC8Pl6tFfkLBuMM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hgtjO-00075K-Pu; Fri, 28 Jun 2019 16:28:10 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 660E0440050; Fri, 28 Jun 2019 15:32:29 +0100 (BST)
Date:   Fri, 28 Jun 2019 15:32:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, alexandre.torgue@st.com,
        mcoquelin.stm32@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/4] regulator: add support for the stm32-booster
Message-ID: <20190628143229.GI5379@sirena.org.uk>
References: <1561709289-11174-1-git-send-email-fabrice.gasnier@st.com>
 <1561709289-11174-3-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+ZmrHH5cGjskQnY1"
Content-Disposition: inline
In-Reply-To: <1561709289-11174-3-git-send-email-fabrice.gasnier@st.com>
X-Cookie: You need not be present to win.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+ZmrHH5cGjskQnY1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2019 at 10:08:07AM +0200, Fabrice Gasnier wrote:
> Add support for the 3.3V booster regulator embedded in stm32h7 and stm32m=
p1
> devices, that can be used to supply ADC analog input switches.
>=20
> This regulator is supplied by vdda. It's controlled by using SYSCFG:
> - STM32H7 has a unique register to set/clear the booster enable bit
> - STM32MP1 has separate set and clear registers to configure it.

This doesn't apply against current code, please check and resend.

--+ZmrHH5cGjskQnY1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0WJPwACgkQJNaLcl1U
h9CEYwf/S479W8LgrEaeHTTFG3CzS+H7XcqwsFf6ZMmLHg4A/fZD3UOrWsupb7XW
5Pn1ugPul+BpUs3M6dew3VdsiqOt/JWl3QC0KPKetya58X+NKnGTtnv+F17u5WyL
pv5f6/FzM3/rN6AhpDN3pbRxUbMj87J3dxVDS/rNh6IYiTjrkIvkXIWO1oiN84aD
KjarUQFfuqKmKDGsCvkzysX+e7npMdAyqntAdYJqtBVsUHPWDPygEfgedZlFjFUa
ktNcysf3sDZpFdDiqzCgLYA52R2rWjJGQbZN9TlMx5iK45iLVjGjTbf11arVCcUw
HT/WrvMzxZT3GvZsaV/sSCOpY7di8A==
=l6Rr
-----END PGP SIGNATURE-----

--+ZmrHH5cGjskQnY1--

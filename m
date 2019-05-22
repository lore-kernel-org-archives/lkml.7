Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B51C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 15:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009F320868
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 15:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558539338;
	bh=zh8hGcmZTNKAIQnav7doHJn1oBv4am+LNeGlrek06I0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s5fIJAs4SspdYLxpCnI3pXiGKHJxCitPqcK/6z5CQRaEquwzi7AXBA05SfEbbWaSr
	 3BOTOLOwDoLm5UD0nX8UtoZ1tcdxPPV786CHjntoPHu24cOs3/hqMpV8uB5UpmrERr
	 FuHoBAuzj/2RXhyWkiLOoIQKUGOztsNz1jM9BFWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbfEVPfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 11:35:37 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36228 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729472AbfEVPfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 11:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zh8hGcmZTNKAIQnav7doHJn1oBv4am+LNeGlrek06I0=; b=N68q3uVaZYlhhRFEQ+rt7Hith
        rhH9zNy58U1wb4zvS8Ynz1+uoLwV1bLpwC1gXZwsGnmgYQoEVpgO6+iqfuwjMUVlFUuWi1JENXCG/
        yW0rfEE4XRnDhJYR544V5Ah5C95uwU/LhZVkdjfIJ91/Rd/je8grUmdMB0g6r/+qgCSr0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hTTH9-0004dA-TL; Wed, 22 May 2019 15:35:31 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 7144011226BC; Wed, 22 May 2019 16:35:28 +0100 (BST)
Date:   Wed, 22 May 2019 16:35:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Keerthy <j-keerthy@ti.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, t-kristo@ti.com
Subject: Re: [PATCH v2 3/3] regulator: lp87565: Add 4-phase lp87561 regulator
 support
Message-ID: <20190522153528.GG8582@sirena.org.uk>
References: <20190516043218.8222-1-j-keerthy@ti.com>
 <20190516043218.8222-4-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p7qwJlK53pWzbayA"
Content-Disposition: inline
In-Reply-To: <20190516043218.8222-4-j-keerthy@ti.com>
X-Cookie: Does the name Pavlov ring a bell?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p7qwJlK53pWzbayA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 16, 2019 at 10:02:18AM +0530, Keerthy wrote:
> The LP8756x family has a single output 4-phase regulator
> configuration. Add support for the same. The control
> lies in the master buck which is buck0 for 4-phase
> configuration. Enable/disable/voltage set happen via
> buck0 registers.

Acked-by: Mark Brown <broonie@kernel.org>

--p7qwJlK53pWzbayA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzlbD8ACgkQJNaLcl1U
h9Alygf9F5WNeDtw1PhBSqAc0Si59+B44/gYO/ffBTyuP2A3hzVd3VvhrYSk1+gO
gGPdCGdyRMIcs83ijz02XKwWIDhrazQcDQhyVCd0QpbPAB6CpgJnj43DQMgFzAHS
2i5le6Ossnsc/aPGDgumb26OIL2v6H/mgmTSGEUynKl+0Z3M5MgQHgWmzTNMytLH
at5abgsiKSt8MCEXReN3AY83M6IdCew01AtsRUAklTLEkC8ggDXrTT8kAYn5mvb+
a0VpR9W2JNJ8Dxc3i82UY3vrQ35UnIP5/SnUH+apbWcVIcbO46RtXAkHC4yo8tZz
vBpiIoYfUBSL6hPKnfzob+ryXb8EFA==
=k1Kg
-----END PGP SIGNATURE-----

--p7qwJlK53pWzbayA--

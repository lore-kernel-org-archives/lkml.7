Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08355C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 16:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D06E22173E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 16:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560963338;
	bh=0uBfXbSfwftsfAb3rvm6Hxv7kIBbI907/jvdLRUYduE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nY7oIzE4iTdhBzBK8293r4Lqbtmsp+/5wAoBPqpB1pQpbZhQJb0q0Xf0SOFKZYb8M
	 i1iocaUhQm39OIYuIWsOE1DOrWk97/pNPHTwOuv5Z8x4NmHNacvU/BguKSgATu5bal
	 gdX3A1duY9/u1F61xxpIWAd3QSCSY7G5w1Y38c6Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbfFSQzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 12:55:37 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43688 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfFSQzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 12:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0uBfXbSfwftsfAb3rvm6Hxv7kIBbI907/jvdLRUYduE=; b=q44krPwrUfFT1CcHdUNVhDfjC
        oFnHUdasnWhj9q1M1nbb7Ek/WlWY+gA+vZ4s7/3lqTy2wUFdS0zf4SHICzKYHZ1QRWmsSncc6ZrOq
        CeAMJmlB5rDjyu72WpNquAewR/1RPshHlqQXEV+yPxwNzsklRJBat8CYnjp9V/ikTPeLw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hddrx-0007Xg-SS; Wed, 19 Jun 2019 16:55:33 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 43A85440046; Wed, 19 Jun 2019 17:55:33 +0100 (BST)
Date:   Wed, 19 Jun 2019 17:55:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Steve Twiss <stwiss.opensource@diasemi.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Felix Riemann <Felix.Riemann@sma.de>,
        Support Opensource <support.opensource@diasemi.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3] regulator: da9061/62: Adjust LDO voltage selection
 minimum value
Message-ID: <20190619165533.GW5316@sirena.org.uk>
References: <20190619163457.A35B73FB46@swsrvapps-01.diasemi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="71H8RJdeoX6JglLe"
Content-Disposition: inline
In-Reply-To: <20190619163457.A35B73FB46@swsrvapps-01.diasemi.com>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--71H8RJdeoX6JglLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2019 at 05:35:00PM +0100, Steve Twiss wrote:

> Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>
> Tested-by: Steve Twiss <stwiss.opensource@diasemi.com>
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> Signed-off-by: Felix Riemann <felix.riemann@sma.de>
> ---
>=20
> Hi Mark,
>=20
> I've added my signed-off tag to the commit patch of V3.

The signoffs really should come in order - the last signoff should be
=66rom the person sending the patch.

--71H8RJdeoX6JglLe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0KaQQACgkQJNaLcl1U
h9CGDAf6A1LnzLtLW8dE/WmDAzXwgYnJyYKiX0azXh3sud0eMWgeeKXK5TdgnUlF
LsVFs4YuC4O0AsatuwFqN+9yOflt3RxbtxMPmVJ3wLKWbA5NM5mh16B/xuqlyDpE
LbeeQ029pfINEZEguTJICGhvZMMdniwW6P2iRAwHFHNUotIWDJHzna9Ja1M06sFc
Fig0uAm7PHd8W4H+sHF6oIquu2IYUj9rlTCqPkEY6i9Thlfib9LOYB0ruVvRcXUf
Ya+KMj7jn70vxeHlqVyuzXkHSbLY4R5BXiarwN+U1x5ygyYJjihFE2HrHWLQ+VMz
II867UFn2iZ9kKZNwmSj4gbOrRN0Kw==
=H2wN
-----END PGP SIGNATURE-----

--71H8RJdeoX6JglLe--

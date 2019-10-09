Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D423ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3530120679
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570636839;
	bh=hRY58LnYSXOo+fSSqNnEbJhfY+4/pq3bx1U2r9s0T+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZonD4OmUo7WTKGfyOrJu6Sou5xtn1dUnIc+tq/GQQfCaWGXKIueqDPRRYIBOuWOZi
	 h2iOAgj+wgxy6zhN8hC80eWUSrykoxfegMX+w5h09njhsURR6iDdrOGq2N/YFtb8up
	 YmekD8+aRiKehCG1KteJSsq6jlL/RVJqlQtujJQU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731661AbfJIQAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 12:00:38 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48268 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729644AbfJIQAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 12:00:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZkEZaeUG2LDB7osCCzA5SGc46/Ti4vNDPD35O8V/wEU=; b=fRSoG5IPBwTlf8+/uwewnaoO2
        PPQAsKxb3vydNdYfAmppcADKDWbo4O4IFN7Cb7o6wx2ZXI3BWi+soz5OkrNa/QbPb+2dFqQkwGhLU
        aSdjW9JvtHnotZOkP5i9r5Mp6oiT008KhxfV6TPVeVGY9XJjAVNVQrbmDgrQpx8euT7Ig=;
Received: from 188.29.185.136.threembb.co.uk ([188.29.185.136] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iIENy-00059v-Ow; Wed, 09 Oct 2019 16:00:22 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 97E72D03ED3; Wed,  9 Oct 2019 17:00:21 +0100 (BST)
Date:   Wed, 9 Oct 2019 17:00:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Sasha Levin <sashal@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 0/1] [for 4.4/4.9] VAG power control improvement for
 sgtl5000 codec
Message-ID: <20191009160021.GI2036@sirena.org.uk>
References: <20191009142822.14808-1-oleksandr.suvorov@toradex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yqoYZO0eSM9FLp66"
Content-Disposition: inline
In-Reply-To: <20191009142822.14808-1-oleksandr.suvorov@toradex.com>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yqoYZO0eSM9FLp66
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2019 at 02:28:36PM +0000, Oleksandr Suvorov wrote:
>=20
> This is a backport to stable kernel versions 4.4 and 4.9.

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--yqoYZO0eSM9FLp66
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2eBBIACgkQJNaLcl1U
h9AbxAf+MlzUGC3a6HyTWNrYD7RjNIuqO5iMIsQXvmAOjQQaQcKxIokPtRdZ0DQF
hm0TpNMj97hj0LUvY8P17SP3CJcSJbfsj+ikz2gRL4C1dTmwEIYpeUzvt2ujR58r
mxqx612RmrOalJymH6BKYjw6NUElAjIvO9+bHWCjww3PzfMNj4y9WLZoA9v+BENa
eHNBLuay5ropZOJqhMc6GMNi9EKGnONc1wxw9bFVMGfGK7FiVB9MCOYoeMGVDjvh
5hjeiSmi41giMyjsOQ1NQPtbTW6ymSmT2VPSBEkbulwO0B2oz35hrI9J/JWJmxHh
RofXuI2v8EOT61r3XR7bevxA8PxT8g==
=Psvc
-----END PGP SIGNATURE-----

--yqoYZO0eSM9FLp66--

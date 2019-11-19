Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BB7C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 13:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B33521783
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 13:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574168856;
	bh=Ng9fIA08i4piQoiH5MdBgJDj2WqleYcqoyToDHOvGnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YmjbZzKMBPcuzY6LsKjibiNmbW+zFn3H2wPS6v2Clpjy7bqT6RKx/C2HMKWKsVCSz
	 XA5l1OJENHpZNie62FjOEdAEpb3FD5ayNgXGaSLANqMGS+YjtSxbCAQb9LxgRAvtGM
	 y26OgiX+O1puiUTOkBfNE29f5UGMMxdPPaGnuKn8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbfKSNHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 08:07:35 -0500
Received: from foss.arm.com ([217.140.110.172]:52480 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfKSNHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 08:07:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A9181FB;
        Tue, 19 Nov 2019 05:07:34 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDAFF3F703;
        Tue, 19 Nov 2019 05:07:33 -0800 (PST)
Date:   Tue, 19 Nov 2019 13:07:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regmap: regmap-w1: Drop unreachable code
Message-ID: <20191119130732.GB3634@sirena.org.uk>
References: <20191119125837.47619-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Content-Disposition: inline
In-Reply-To: <20191119125837.47619-1-mika.westerberg@linux.intel.com>
X-Cookie: Beam me up, Scotty!  It ate my phaser!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2019 at 03:58:37PM +0300, Mika Westerberg wrote:
> Both init functions have a stray "return NULL" at the end which is never
> reached so drop them.
>=20
> Fixes: cc5d0db390b0 ("regmap: Add 1-Wire bus support")

You're overusing the Fixes tag here...

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3T6RMACgkQJNaLcl1U
h9DovAf+Kq/XgV3oMDovumGvtDIz+iBmEa2yyUrpwsFba7NWDaOlf7GeTjV58dX8
7U8fDA/eih+EbtCNJ7Y67GGGdV93VvTHN/xoAOS4x70nAJ3FzZ2NU+Gecz0/7vfC
w+WniRPq2/YYEs1k8YBIy0YekoSJT0/bVUq9Cjz8W0CKqOUBEIisuiqA+XONnz6r
MlSlKn1IBfl1Yd27DiJHcykWR2PRquJ+U/AmDqY9iXrqVDLWqDQw4qCyy89Nk1uH
K+/63dZu654k6b079yuqNgXlQiX5juZBhNwy1DG9HGAiN9pbyOLlU+Aw+G4R7Zso
F/eaHh/3VQ2cPg80xNxxcvC1CjJlCw==
=tDD1
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--

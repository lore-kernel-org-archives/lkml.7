Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E3FC32767
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 16:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE9B222C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 16:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgACQeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 11:34:07 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:45338 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgACQeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 11:34:07 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 407DA1C25EC; Fri,  3 Jan 2020 17:34:05 +0100 (CET)
Date:   Fri, 3 Jan 2020 17:34:04 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Maurizio Lombardi <mlombard@redhat.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 054/114] scsi: scsi_debug: num_tgts must be >= 0
Message-ID: <20200103163404.GB14328@amd>
References: <20200102220029.183913184@linuxfoundation.org>
 <20200102220034.493876476@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Content-Disposition: inline
In-Reply-To: <20200102220034.493876476@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Maurizio Lombardi <mlombard@redhat.com>
>=20
> [ Upstream commit aa5334c4f3014940f11bf876e919c956abef4089 ]
>=20
> Passing the parameter "num_tgts=3D-1" will start an infinite loop that
> exhausts the system memory

Should we provide some kind of upper bound for num_tgts, too?
Otherwise integer overflow will follow later in the code. Even without
overflow, it will kill the system due to OOM...

Best regards,
								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl4PbPwACgkQMOfwapXb+vJe+QCgxM6mHDdr9lN4KVhL48lnkSd6
uW0AnAnlyoORhsiDZEtCaYQJO1xEfsUN
=wV7f
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--

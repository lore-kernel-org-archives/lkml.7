Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54B4C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E1D2183E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733279AbfDXUvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 16:51:55 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33525 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbfDXUvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 16:51:54 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id C3E4B80558; Wed, 24 Apr 2019 22:51:42 +0200 (CEST)
Date:   Wed, 24 Apr 2019 22:51:50 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Jens Axboe <axboe@kernel.dk>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, lduncan@suse.com, hare@suse.com,
        mcgrof@kernel.org, jthumshirn@suse.de, hch@lst.de,
        gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        bvanassche@acm.org
Cc:     kernel list <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net,
        linux-pm@vger.kernel.org, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, hdegoede@redhat.com,
        linux-ide@vger.kernel.org
Subject: Re: regression -next -- scsi: sd: Rely on the driver core for
 asynchronous probing was Re: next-20190408..0418: Suspend/resume problems on
 Thinkpad X60
Message-ID: <20190424205150.GA4582@amd>
References: <20190408173928.GB13260@amd>
 <20190412102812.GA24977@amd>
 <20190423102239.GA15531@amd>
 <41d56ba6-d0cb-5d5e-f5f4-9bca045440dd@kernel.dk>
 <20190424095431.GA32457@amd>
 <20190424104850.GC32457@amd>
 <20190424202119.GA26357@amd>
 <20190424204832.GA3111@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <20190424204832.GA3111@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-04-24 22:48:32, Pavel Machek wrote:
> Hi!
>=20
> > Not block, but it seems scsi subsystem is:
>=20
> commit 21e6ba3f0e0257cce1a226c1f15e0a8ba4338ca3
> Author: Bart Van Assche <bvanassche@acm.org>
> Date:   Wed Mar 20 13:09:19 2019 -0700
>=20
>     scsi: sd: Rely on the driver core for asynchronous probing
>=20
>     As explained during the 2018 LSF/MM session about increasing SCSI
>     disk
>         probing concurrency, the problems with the current probing
>     approach are as
>=20
> Seems to be responsible. Full log attached.

Unfortunately, that one does not revert cleanly on top of -next.

Any ideas what is wrong?

Does suspend/resume work for you?

I can test patches.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzAzGYACgkQMOfwapXb+vJq4QCeNjbDQJS2ZM3PimuT0IZmO9cB
VzAAoLzlKI6Ec0myLfIAxqC1T64C9p6y
=lQq0
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--

Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F412C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 08:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F2020679
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 08:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbfHMIWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 04:22:17 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:44001 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbfHMIWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 04:22:17 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 8EC188053B; Tue, 13 Aug 2019 10:22:01 +0200 (CEST)
Date:   Tue, 13 Aug 2019 10:22:13 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     Roger Quadros <rogerq@ti.com>, Pavel Machek <pavel@denx.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>,
        Anil Joy Varughese <aniljoy@cadence.com>
Subject: Re: [PATCH v10 0/6] Introduced new Cadence USBSS DRD Driver.
Message-ID: <20190813082213.GA9298@amd>
References: <1563733939-21214-1-git-send-email-pawell@cadence.com>
 <20190721190335.GA19831@xo-6d-61-c0.localdomain>
 <BYAPR07MB470904ACCD1ED91B10BB6BEFDDC40@BYAPR07MB4709.namprd07.prod.outlook.com>
 <20190722114839.GA10515@kroah.com>
 <20190722115644.GA12069@amd>
 <20190722210021.GA25235@amd>
 <BYAPR07MB470966850323EE3003B3097ADDC70@BYAPR07MB4709.namprd07.prod.outlook.com>
 <93b4a702-227b-0410-a414-76873088ad72@ti.com>
 <BYAPR07MB47095895491CFD211EE9E051DDD70@BYAPR07MB4709.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <BYAPR07MB47095895491CFD211EE9E051DDD70@BYAPR07MB4709.namprd07.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I think that I understand your concerns. My idea was not to expand the su=
pported=20
> dr_mode. Rather I wanted to have possibility to limit this (only for test=
ing).=20
>=20
> Eg.=20
> If  cdns->dr_mode =3D USB_DR_MODE_OTG
> then we can limit mode to HOST or DEVICE or DRD
> if cdns->dr_mode =3D=3D USB_DR_MODE_HOST ||=20
>    cdns->dr_mode =3D=3D USB_DR_MODE_PERIPHERAL)=20
> then driver can't change anything
>=20
> It allows me for testing some functionality using only single board=20
> and even with lacking right cable for proper otg detection.=20

Yes, and it looks like people need this functionality in production,
too, so it should be in sysfs (and not debugfs).

If it means sysfs interface need to be extended to cover all the
cases, so be it.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1SczUACgkQMOfwapXb+vJaHwCgj0Z1ZJUsMMMCPML7HzUkrMP+
AAIAnRi/ojI3Y/dmV1HgjQJmSt62O69r
=hZ0K
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--

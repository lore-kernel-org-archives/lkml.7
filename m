Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276BAC76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 11:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B422184E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 11:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbfGVL4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 07:56:50 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:43020 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbfGVL4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 07:56:49 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 828CF80342; Mon, 22 Jul 2019 13:56:35 +0200 (CEST)
Date:   Mon, 22 Jul 2019 13:56:45 +0200
From:   Pavel Machek <pavel@denx.de>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     Pawel Laszczak <pawell@cadence.com>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>,
        Anil Joy Varughese <aniljoy@cadence.com>
Subject: Re: [PATCH v10 0/6] Introduced new Cadence USBSS DRD Driver.
Message-ID: <20190722115644.GA12069@amd>
References: <1563733939-21214-1-git-send-email-pawell@cadence.com>
 <20190721190335.GA19831@xo-6d-61-c0.localdomain>
 <BYAPR07MB470904ACCD1ED91B10BB6BEFDDC40@BYAPR07MB4709.namprd07.prod.outlook.com>
 <20190722114839.GA10515@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <20190722114839.GA10515@kroah.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > >> This patch introduce new Cadence USBSS DRD driver to linux kernel.
> > >>
> > >> The Cadence USBSS DRD Controller is a highly configurable IP Core wh=
ich
> > >> can be instantiated as Dual-Role Device (DRD), Peripheral Only and
> > >> Host Only (XHCI)configurations.
> > >
> > >I see you are using debugfs to select between DRD, peripheral-onlyh an=
d XHCI...
> > >
> > >Is that good idea?
> >=20
> > Yes driver allows selecting dr_mode by debugfs. Controller also support=
 such functionality=20
> > so I don't understand why would it not be a good idea.=20
> >=20
> > I personally use this for testing but it can be used to limit controlle=
r functionality without=20
> > recompiling kernel.=20
>=20
> debugfs is ONLY for debugging, never rely on it being enabled, or
> mounted, on a system in order to have any normal operation happen.
>=20
> So for testing, yes, this is fine.  If this is going to be the normal
> api/interface for how to control this driver, no, that is not acceptable
> at all.

It makes a lot of sense for end-user to toggle this... for example
when he is lacking right cable for proper otg detection. As it is
third driver offering this functionality, I believe we should stop
treating it as debugging.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl01pHwACgkQMOfwapXb+vIDNQCgwTTLQIqZhxOPwF0uWn3pcLMd
9qQAnjloOlNoULIYu4F5WNb9967eMecO
=BZoL
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--

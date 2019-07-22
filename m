Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA93C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3998521901
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730558AbfGVVAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 17:00:25 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55991 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730284AbfGVVAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:00:24 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id D5A94802EE; Mon, 22 Jul 2019 23:00:10 +0200 (CEST)
Date:   Mon, 22 Jul 2019 23:00:21 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Pavel Machek <pavel@denx.de>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Pawel Laszczak <pawell@cadence.com>,
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
Message-ID: <20190722210021.GA25235@amd>
References: <1563733939-21214-1-git-send-email-pawell@cadence.com>
 <20190721190335.GA19831@xo-6d-61-c0.localdomain>
 <BYAPR07MB470904ACCD1ED91B10BB6BEFDDC40@BYAPR07MB4709.namprd07.prod.outlook.com>
 <20190722114839.GA10515@kroah.com>
 <20190722115644.GA12069@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
In-Reply-To: <20190722115644.GA12069@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-07-22 13:56:44, Pavel Machek wrote:
> Hi!
>=20
> > > >> This patch introduce new Cadence USBSS DRD driver to linux kernel.
> > > >>
> > > >> The Cadence USBSS DRD Controller is a highly configurable IP Core =
which
> > > >> can be instantiated as Dual-Role Device (DRD), Peripheral Only and
> > > >> Host Only (XHCI)configurations.
> > > >
> > > >I see you are using debugfs to select between DRD, peripheral-onlyh =
and XHCI...
> > > >
> > > >Is that good idea?
> > >=20
> > > Yes driver allows selecting dr_mode by debugfs. Controller also suppo=
rt such functionality=20
> > > so I don't understand why would it not be a good idea.=20
> > >=20
> > > I personally use this for testing but it can be used to limit control=
ler functionality without=20
> > > recompiling kernel.=20
> >=20
> > debugfs is ONLY for debugging, never rely on it being enabled, or
> > mounted, on a system in order to have any normal operation happen.
> >=20
> > So for testing, yes, this is fine.  If this is going to be the normal
> > api/interface for how to control this driver, no, that is not acceptable
> > at all.
>=20
> It makes a lot of sense for end-user to toggle this... for example
> when he is lacking right cable for proper otg detection. As it is
> third driver offering this functionality, I believe we should stop
> treating it as debugging.

At least renesas usb controller seems to have variables in sysfs:
drivers/phy/renesas/phy-rcar-gen3-usb2.c : functions role_show and
role_store. See also
Documentation/ABI/testing/sysfs-platform-phy-rcar-gen3-usb2 .

I believe this driver should do same.

Thanks and best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl02I+UACgkQMOfwapXb+vLksgCcDVEb7y8BZQQVDtLc5uhbTm3O
4soAn0QMwPr/VfDUGwp4kC7STMJmZn30
=blsD
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--

Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67034C31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 08:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A36D21721
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 08:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbfHOI4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 04:56:52 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60884 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfHOI4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 04:56:51 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id D5F3780BF7; Thu, 15 Aug 2019 10:56:36 +0200 (CEST)
Date:   Thu, 15 Aug 2019 10:56:50 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Pavel Machek <pavel@denx.de>,
        kernel list <linux-kernel@vger.kernel.org>, stable@kernel.org,
        matthias.bgg@gmail.com, neil@brown.name,
        thirtythreeforty@gmail.com, christian@lkamp.de,
        nishadkamdar@gmail.com, ser.perschin@gmail.com, blogic@openwrt.org,
        jan.kiszka@siemens.com
Subject: Re: [stable] Deleting "mt7621-mmc" with "interesting" license?
Message-ID: <20190815085649.GB5955@amd>
References: <20190815071350.GB3906@amd>
 <20190815075132.GA30284@kroah.com>
 <20190815075927.GC3669@amd>
 <20190815084406.GC3512@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mxv5cy4qt+RJ9ypb"
Content-Disposition: inline
In-Reply-To: <20190815084406.GC3512@kroah.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2019-08-15 10:44:06, Greg KH wrote:
> On Thu, Aug 15, 2019 at 09:59:27AM +0200, Pavel Machek wrote:
> > On Thu 2019-08-15 09:51:32, Greg KH wrote:
> > > On Thu, Aug 15, 2019 at 09:13:50AM +0200, Pavel Machek wrote:
> > > > Hi!
> > > >=20
> > > > I realize that "interesting" license is not on a list of bugs suita=
ble
> > > > for -stable, but on the other hand, this tends to scare corporate
> > > > lawyers... so perhaps we should remove the driver in -stable, too?
> > > >=20
> > > > Upstream commit id is 441bf7332d55c4d34afae9ffc3bbec621093f4d1.
> > > >=20
> > > > 4.19 has the problematic driver, 4.4 does not.
> > >=20
> > > If a lawyer has issues with this, please just upgrade to the latest
> > > kernel release :)
> >=20
> > We are talking this project:
> > https://wiki.linuxfoundation.org/civilinfrastructureplatform/start .
> > Upgrading is not an option, but I can take the patch locally.
>=20
> It does not meet the stable rules, sorry, I'm not going to take it.

No problem, I can take the patch locally.

> > If someone has confirmation that "interesting" license is a mistake
> > and it is indeed GPL, that would be nice, too.
>=20
> Feel free to discus it with the company who wrote the driver :)

I hope I got Cc list right, and they should be cce-ed.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--mxv5cy4qt+RJ9ypb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1VHlEACgkQMOfwapXb+vKekQCfcy5kPkBCn0Ugkku5WXdugKU2
vxIAnA7UUxEK2Wz/aYUay6I28Gphn8gw
=xI8P
-----END PGP SIGNATURE-----

--mxv5cy4qt+RJ9ypb--

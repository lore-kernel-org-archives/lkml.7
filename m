Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_SBL,URIBL_SBL_A
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2F6C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 18:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50CAE20B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 18:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfEFSvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 14:51:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:34382 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726435AbfEFSvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 14:51:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6121AACCD;
        Mon,  6 May 2019 18:51:49 +0000 (UTC)
Message-ID: <9871b5d816b3868633381dba84b315bb21bb2ace.camel@suse.de>
Subject: Re: [PATCH v2 0/3] staging: vchiq: use interruptible waits
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        linux-kernel@vger.kernel.org
Cc:     phil@raspberrypi.org, dan.carpenter@oracle.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org
Date:   Mon, 06 May 2019 20:51:47 +0200
In-Reply-To: <b2679404-ba00-d18e-fe15-44c6e280dc11@i2se.com>
References: <20190506144030.29056-1-nsaenzjulienne@suse.de>
         <b2679404-ba00-d18e-fe15-44c6e280dc11@i2se.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-7b5y6BpkJZ6GF8kuMfMZ"
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7b5y6BpkJZ6GF8kuMfMZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-05-06 at 20:12 +0200, Stefan Wahren wrote:
> Hi Nicolas,
>=20
> Am 06.05.19 um 16:40 schrieb Nicolas Saenz Julienne:
> > Hi,
> > ...
> >=20
> > Regards,
> > Nicolas
> >=20
> > [1] https://github.com/raspberrypi/linux/issues/2881
> > [2] https://archlinuxarm.org/forum/viewtopic.php?f=3D65&t=3D13485
> > [3]=20
> >=20
https://lists.fedoraproject.org/archives/list/arm@lists.fedoraproject.org/m=
essage/GBXGJ7DOV5CQQXFPOZCXTRD6W4BEPT4Q/
> >=20
> > --
> >=20
> > Changes since v1:
> >   - Proplery format revert commits
> >   - Add code comment to remind of this issue
> >   - Add Fixes tags
> >=20
> > Nicolas Saenz Julienne (3):
> >   staging: vchiq_2835_arm: revert "quit using custom
> >     down_interruptible()"
> >   staging: vchiq: revert "switch to wait_for_completion_killable"
> >   staging: vchiq: make wait events interruptible
> >=20
> >  .../interface/vchiq_arm/vchiq_2835_arm.c      |  2 +-
> >  .../interface/vchiq_arm/vchiq_arm.c           | 21 +++++++------
> >  .../interface/vchiq_arm/vchiq_core.c          | 31 ++++++++++++-------
> >  .../interface/vchiq_arm/vchiq_util.c          |  6 ++--
> >  4 files changed, 35 insertions(+), 25 deletions(-)
> >=20
> against which tree should this series apply?
>=20
> Since the merge window opened the current staging-linus wont be
> available soon.

I don't know if that's what you meant, but I guess we should wait for 5.2-r=
c1
and then push it, the fixes will eventually get into the stable version of =
5.1.


Regards,
Nicolas


--=-7b5y6BpkJZ6GF8kuMfMZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlzQgkMACgkQlfZmHno8
x/5aeQf/WayQQc7jVUFGX+QXs7v5yyWsQeju/5uDmQTIx7tBkCMoEjSTOzlRs4eI
Sql06hOgpYwHD2U74Mu2bqon/sgK3royEyESPglhyI4v/V3/rFoGSd2qyRCRNs0U
ev6zXzgWYntfEguNgzhAMB+VN6MP36ea+UbPgr+88YCzKR1KBPxNjbpRH5gSoPn0
nWVFaxYidiJvFuHpuwDVYwBpDpSQkGcwhUL3ubPtZP3N0QO1MgdpJwY8+pWf+aHU
Uou4nOuQuZ7smASZ4aPWSu5HU0QoA2E+4WvKx6VezMDoBrcmH37jYUi+NIlp6dHC
dOxi0KAZi7Tam8WdDqSlo8upfd6qAQ==
=EZQz
-----END PGP SIGNATURE-----

--=-7b5y6BpkJZ6GF8kuMfMZ--


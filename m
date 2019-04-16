Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27298C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0122820868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbfDPHTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 03:19:46 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36114 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbfDPHTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 03:19:43 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 7BDD8808F5; Tue, 16 Apr 2019 09:19:33 +0200 (CEST)
Date:   Tue, 16 Apr 2019 09:19:41 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-pm@vger.kernel.org, sre@kernel.org,
        Sameer Nanda <snanda@chromium.org>, bleung@chromium.org,
        rjw@rjwysocki.net, gwendal@chromium.org,
        linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        groeck@chromium.org, Adam.Thomson.Opensource@diasemi.com,
        kernel@collabora.com
Subject: Re: [RESEND PATCH v3 1/2] power: supply: add input voltage limit
 property
Message-ID: <20190416071941.GB14538@amd>
References: <20190415220049.14924-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Content-Disposition: inline
In-Reply-To: <20190415220049.14924-1-enric.balletbo@collabora.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch exposes a new property, similar to input current limit, to
> re-configure the maximum voltage from the external supply at runtime
> based on system-level knowledge or user input.

Well, and I suspect it should expose input power limit, not input
voltage limit.

DC-DC convertor efficiency normally does not much depend on input
voltage....

								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAly1gg0ACgkQMOfwapXb+vIwfACfdFHwprUPu+40TOX0mT/D2Q1Z
y/gAoKzB8tOLf82MCBIKKEQTadtoz1Q5
=Z/JO
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--

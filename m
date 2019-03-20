Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00ED0C10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D872184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfCTQ6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 12:58:23 -0400
Received: from sauhun.de ([88.99.104.3]:54944 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbfCTQ6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 12:58:22 -0400
Received: from localhost (p5486CF7E.dip0.t-ipconnect.de [84.134.207.126])
        by pokefinder.org (Postfix) with ESMTPSA id 6F02B4A1348;
        Wed, 20 Mar 2019 17:58:20 +0100 (CET)
Date:   Wed, 20 Mar 2019 17:58:20 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Gareth Williams <gareth.williams.jx@renesas.com>
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v5 2/2] i2c: designware: Add support for an interface
 clock
Message-ID: <20190320165820.pjydd5ophxoulwza@ninjato>
References: <1551361930-24434-1-git-send-email-gareth.williams.jx@renesas.com>
 <1551361930-24434-3-git-send-email-gareth.williams.jx@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xfr6vjbdofsxw5tr"
Content-Disposition: inline
In-Reply-To: <1551361930-24434-3-git-send-email-gareth.williams.jx@renesas.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xfr6vjbdofsxw5tr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 28, 2019 at 01:52:10PM +0000, Gareth Williams wrote:
> From: Phil Edworthy <phil.edworthy@renesas.com>
>=20
> The Synopsys I2C Controller has an interface clock, but most SoCs hide
> this away. However, on some SoCs you need to explicitly enable the
> interface clock in order to access the registers. Therefore, add=20
> support for an optional interface clock.
>=20
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
> Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-next, thanks!


--xfr6vjbdofsxw5tr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyScSsACgkQFA3kzBSg
Kba/Fw//ZY5silg+MDSe2w4nAQY0r1OsdEGU1eHK7QCZlVV8NtBAkThhCsXNDFFK
SI05H3PSl1VhMzWlD+hAwX4REJ27xqeoFtgKwSrN/BoxYmxK8/3p3TPRBOgbYdaB
3H8kFD0TChviM+tIDPnUGWK/AiQ+FYl0QG/VUgJN1xkhf3AVj2fIruoU7pwyAI1a
HOTvJf1yDp0yAKK/WCerDd5NaUfVI/XqKUf4sx+p8BTBt7KWnHrDrQOj5GrEMg6g
he/BwENfDMaGbSBhMPWJEWxvwG/8G3e49C1w66xxwhBGSEH/MEyR+pVA1p+uDjfL
OMrdtxrlOTntamR0wGbKBV7dY9Bgz0zrbpd8dhV9Qc9WWrqHaaYeP36LgKIyAcib
SmWKEumv0b7uRhlM/kvH7yP7lwFdzLUXTzVvyGbQonbywimHs20DPtymxDaixsHv
bqybg99UXSB4I+MRhm3KChsurNv05jVZQavPQOeqihqNFG6yysZWYQd/HW5Z8/cl
LKUhtvRbMtcSk/jUf16ioiq1qymUTAwLnAcYIs5kVINXdVsWUyJDAtis6QOI+bDP
R6dwjontf8gpQSp2tP/ISOFfIiR/IRK8/Iw6S4ma3UqrIU5MfOHUtfGgVrpVPOlR
/q9Fj6R03Z97GbqQaLbfoDs7S0VVO06ZggqZb4PikONM17dp4uw=
=tTfE
-----END PGP SIGNATURE-----

--xfr6vjbdofsxw5tr--

Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04F0C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7970620665
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391852AbfFMQT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:19:27 -0400
Received: from sauhun.de ([88.99.104.3]:42288 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731137AbfFMQTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 12:19:24 -0400
Received: from localhost (p5486CF99.dip0.t-ipconnect.de [84.134.207.153])
        by pokefinder.org (Postfix) with ESMTPSA id B46C24A127B;
        Thu, 13 Jun 2019 18:19:22 +0200 (CEST)
Date:   Thu, 13 Jun 2019 18:19:22 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] media: cxd2820r: don't check retval after our own
 assignemt
Message-ID: <20190613161922.GA5015@kunai>
References: <20190613155421.16408-1-wsa+renesas@sang-engineering.com>
 <20190613155421.16408-2-wsa+renesas@sang-engineering.com>
 <550e0dbf-1776-000b-27ca-40e40e317da2@ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
In-Reply-To: <550e0dbf-1776-000b-27ca-40e40e317da2@ideasonboard.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> In the title/subject:
>=20
> media: cxd2820r: don't check retval after our own assignemt
>=20
> s/assignemt/assignment/

Eeeks, in deed :( Shall I resend? Sorry for the noise.


--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl0Cd4YACgkQFA3kzBSg
KbZgow//aNxohRzQcF1sIHDVxMCgP1WbXbfoU0g5CY4c8lZ+/ythaFlCOQ7pa5OF
3CYujuPha//WElGBiD1DME/qXmdwNAAH2U2QqxuER/14vXW0jpHEoX7TIf2zuoxV
72dW5Mt9XvBKX4rXpxQO0qucIR+F4Us2ayN3UrhkuG2gPrvtV+hHnp6zKxVam21S
uqiodFXng2fRMympaV8LYaV/oUj8qWCsWbp5q1hOkT2iKjEyCkMjwVMLFn/onpaA
eAEQ9MlGKA+hJfDjqMF9gcqoFGn0FYtL2KsptwrPAy8KLgldVuma4eIFIDTp9iwb
UZMUqHIs1Xpf3xQEs/FVwvols+rDPSIAg1515+heM66WbHU3mLq+fc79v4ZHBdii
JjvoJFN4EgAzqy6FL57GLYIZEezfwJ5sC55Rp7mL/dUrDg7oqrOOZJiQRFxXfMeF
T1ZIkeAsFglARaXwFUopVUD4hw8vxMqe/EKhLau6jyp8Pw60j0LBwREAFCmPCqN3
F6zTeLvwJfuzmPlBbVkxH2AeTStxPDvOlZ2O2YBh8FyizNCEzMabds2wqbif5IF9
xju81GoMANuzx9G/Rb/W873e8s0KBTunTEw8coznK/XPcrZtKxUnyaHsF7PdXWD6
ckAffB5GgNDqA+8sp3E0i+atD/Ajf/nFPLfCnrNP/FlNtwd7I5A=
=iAmu
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--

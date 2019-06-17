Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D867C31E5D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E5DC2063F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FIVNj3B0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbfFQVqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:46:13 -0400
Received: from ozlabs.org ([203.11.71.1]:34255 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbfFQVqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:46:13 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45SPss2JY4z9sN6;
        Tue, 18 Jun 2019 07:46:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560807970;
        bh=RgNeTQMvCxLOoSFbmSKjBEXMtoKP1fIbf8EOxRwN36U=;
        h=Date:From:To:Cc:Subject:From;
        b=FIVNj3B0o+APTlLVXIvUcFq9UCK/68bcR6TOhIF5ak7w5gCyXPdk1KHVrByrfhhTV
         dpARZ4ebWpIU1RKsF3J3kHZYcwgpU6QI+esVkkUqtyRC7c7Vexd4jUyV7chxPZjIP2
         Dyky3gzWBN8sUhqEEefrXi5PHG3Q0VDF65+Jj2EBTiceJ4UNgW6/73zCK0FnvaEJrA
         Prlq3LciTHb6yRf0wlsEhDzonXKh6zcHAmDsLgD0lHUxtcLrQt9fZvRr5bPk+Nzb+f
         q3HmOQ/A73g8Xz/Zprqld47ug5cPh4vrfXBRAT23EEC2PQuE36INvMpwGQjsGwBFXB
         1x5bq/591X+gg==
Date:   Tue, 18 Jun 2019 07:46:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Benson Leung <bleung@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: linux-next: Signed-off-by missing for commits in the
 chrome-platform tree
Message-ID: <20190618074607.09dfcdbd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/6lpIufEY/+HHMGTjilpPQHO"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6lpIufEY/+HHMGTjilpPQHO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  0ac39915c00e ("mfd: cros_ec: Update I2S API")
  273e4a83784f ("mfd: cros_ec: Add Management API entry points")
  5fb684b28ddf ("mfd: cros_ec: Add SKU ID and Secure storage API")
  fa1edb8224c9 ("mfd: cros_ec: Add API for rwsig")
  a5a60125c987 ("mfd: cros_ec: Add API for Fingerprint support")
  ff5599529a19 ("mfd: cros_ec: Add API for Touchpad support")
  a97c5892c8cf ("mfd: cros_ec: Add API for EC-EC communication")
  381041521d3a ("mfd: cros_ec: Add I2C passthru protection API")
  d18e0cde8705 ("mfd: cros_ec: Add Smart Battery Firmware update API")
  e4de049a3892 ("mfd: cros_ec: Add Hibernate API")
  44f251dc6e69 ("mfd: cros_ec: Add API for keyboard testing")
  03dc9f7cdc8a ("mfd: cros_ec: Complete Power and USB PD API")
  a704e1450f07 ("mfd: cros_ec: Fix temperature API")
  fa5a714e9d54 ("mfd: cros_ec: Add fingerprint API")
  cbc1d3b7c5a4 ("mfd: cros_ec: Fix event processing API")
  b841c3496d0d ("mfd: cros_ec: Complete MEMS sensor API")
  b4e686e9eecd ("mfd: cros_ec: Add EC transport protocol v4")
  743875b6af81 ("mfd: cros_ec: Expand hash API")
  051cf1f83491 ("mfd: cros_ec: Add lightbar v2 API")
  b1bd73c9e90f ("mfd: cros_ec: Add PWM_SET_DUTY API")
  998b37cad349 ("mfd: cros_ec: Add Flash V2 commands API")
  d8064663d3c4 ("mfd: cros_ec: Remove zero-size structs")
  036957c19978 ("mfd: cros_ec: move HDMI CEC API definition")
  0ee2b17ec310 ("mfd: cros_ec: Update ACPI interface definition")
  6f6db199e544 ("mfd: cros_ec: use BIT macro")
  a5f0ac50978b ("mfd: cros_ec: Define commands as 4-digit UPPER CASE hex va=
lues")
  de18e8beadcc ("mfd: cros_ec: add ec_align macros")
  bf96c5f1276c ("mfd: cros_ec: set comments properly")
  6b854d5fbda9 ("mfd: cros_ec: Zero BUILD_ macro")
  5a0d32c91830 ("mfd: cros_ec: Update license term")

are missing a Signed-off-by from their committer.

These were all rebased.

--=20
Cheers,
Stephen Rothwell

--Sig_/6lpIufEY/+HHMGTjilpPQHO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0ICh8ACgkQAVBC80lX
0GwxCgf/RPP1T4jOpAtCmvTcnsfF/kRHpu5B5I33mFAwbX34H7ot5zA/Xt4FQ1Am
SvF9CFX1CFc8RSVKZUQmUZIJB7oNjenCN0R52O9y2MNw07jeUAx1mEItzsxJZxB8
xDzGYdiVacB5FC5gg6k8KSHcA98PtNKwRnJdsgvdNP5TKcE0rR8j1hRjW69fmcHR
TdFj7akj07GB9nFZTD0bghJBVGoLCB65TOJI80WGxGd+wI4fjVeD7Fa6D6Q5wsv6
LMKXnGCewrtdV816sRlFLxKK2A6JTHHNZPq4rB1F6PhAoFf1Qe34uda3QhvyLPIf
ylMX1QtCs5ixA3tLe7ypixKQLa0D4A==
=BYBT
-----END PGP SIGNATURE-----

--Sig_/6lpIufEY/+HHMGTjilpPQHO--

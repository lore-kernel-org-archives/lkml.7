Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDA3C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 16:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5320C20645
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 16:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbfFFQZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 12:25:26 -0400
Received: from sauhun.de ([88.99.104.3]:35498 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728223AbfFFQZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 12:25:26 -0400
Received: from localhost (p5486CDEB.dip0.t-ipconnect.de [84.134.205.235])
        by pokefinder.org (Postfix) with ESMTPSA id 7FAEA2C35BF;
        Thu,  6 Jun 2019 18:25:23 +0200 (CEST)
Date:   Thu, 6 Jun 2019 18:25:23 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Vitor Soares <Vitor.Soares@synopsys.com>
Cc:     linux-iio@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        bbrezillon@kernel.org, Joao.Pinto@synopsys.com,
        lorenzo.bianconi83@gmail.com
Subject: Re: [PATCH v2 0/3] Add ST lsm6dso i3c support
Message-ID: <20190606162522.GA3782@kunai>
References: <cover.1559831663.git.vitor.soares@synopsys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <cover.1559831663.git.vitor.soares@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 06, 2019 at 05:12:01PM +0200, Vitor Soares wrote:
> This patch series add i3c support for STM LSM6DSO and LSM6DSR sensors.

Why is the I2C list on CC? Is there something relevant I missed?


--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlz5Pm4ACgkQFA3kzBSg
KbapNg//cBKxDRaQW1S7u+5yCetAmE74WJLlzFtJOzL0oS+qcPOsi5YATvPGnu/1
k+bPwNGKf3MT1fvax7/qcZjGxLsiGqUfx7AkDYwUEK9Z1Uy6ZN+zdvGjNw9hw5mB
vbF4un8buF3bMxM31ggNx3nQL28SXKgnCiqKkyL/7Ohr1x9jodcSeCrZlLsDjebm
x68IPtUsPZkd3sVfUEdirkoBuX7j0H0dbzUyoxYM/Zfooo79uDH/pXKhiBMWQmtK
vixrFUwZdPO3i2hUtvG4K+8gMUNfH7Z0bLBRVV3P8yZ1Zae0IcBPilJUZifirOLr
8BOxiI03pzrn1LbOG0HkB6RcsgnSaHWZmycLyWJmdcrm6TDzq8e/eCFs9ZhVl0Hx
12OSitCoI2oX8GJnW2uCdruh/twfwXtZMOvJpaRHFApGQbnH+FRIfC9Bm3+Jrt/K
z0baLeWx4fl+YDeKyHhtNcTR0o3hAT7yMiNDDU2duYiCbpH7/+Bp6Pun61WHsPSX
aNmH0UwyPyRQNxrVHi3ytxSfJQ/Zi/dr9XI+ls2idGR5OnjpZhUR1QxNd84Rm529
WTBKK/1ygE72ulUl5aX45FcyGEVLf6QMjDRBAJZebVXNVcEYQauMr/C/JjFUMQN1
1Nitl/qlfEf4FITpEWE351oJF3RjrNgmSmpyEI0vNccDLOVl134=
=/qTU
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--

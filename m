Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63687C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F14F2084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfDCUo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 16:44:27 -0400
Received: from sauhun.de ([88.99.104.3]:51486 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbfDCUo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 16:44:26 -0400
Received: from localhost (p54B3311F.dip0.t-ipconnect.de [84.179.49.31])
        by pokefinder.org (Postfix) with ESMTPSA id C9D542C282F;
        Wed,  3 Apr 2019 22:44:23 +0200 (CEST)
Date:   Wed, 3 Apr 2019 22:44:23 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: Re: [PATCH v6 0/9] iProc I2C slave mode and NIC mode
Message-ID: <20190403204423.btgtke3tmt7pkr3j@ninjato>
References: <20190403011830.3254-1-ray.jui@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gaiqb3qmgvc3uh4b"
Content-Disposition: inline
In-Reply-To: <20190403011830.3254-1-ray.jui@broadcom.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gaiqb3qmgvc3uh4b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2019 at 06:18:21PM -0700, Ray Jui wrote:
> This patch series adds the following support to the iProc I2C driver:
> - Increase maximum read transfer size to 255 bytes
> - I2C slave mode
> - Polling mode
> - NIC I2C mode
>=20
> This patch series is based on kernel v5.1-rc3 and available at:
> https://github.com/Broadcom/arm64-linux.git
> branch: i2c-slave-v6
>=20
> Changes from v5:
>  - Address various comments from Wolfram

In the future, please write in detail what you changed. I review so many
patches that I can't recall all my comments on every patch.

That being said, all patches applied to for-next, thanks!

Can be fixed incrementally, my code checkers complain about:

    CPPCHECK
drivers/i2c/busses/i2c-bcm-iproc.c:720:14: warning: Shifting signed 32-bit =
value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
    val |=3D 1 << M_TX_WR_STATUS_SHIFT;
             ^
drivers/i2c/busses/i2c-bcm-iproc.c:847:13: warning: Shifting signed 32-bit =
value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
 val &=3D ~(1 << TIM_CFG_MODE_400_SHIFT);
            ^
drivers/i2c/busses/i2c-bcm-iproc.c:998:13: warning: Shifting signed 32-bit =
value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
 val &=3D ~(1 << TIM_CFG_MODE_400_SHIFT);


--gaiqb3qmgvc3uh4b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlylGyIACgkQFA3kzBSg
KbacLg//WGHt+fUGF8nDYQKJyHBwFfi0NNQNNBnCpwCEdnXra1d7pp3hs2rcKcvQ
UEayjxajINusfafeT84eFqIEC0qLxRSrYs2nDOKY1V+S88j+K3zJLoToSHjKbNZa
41JvzQ18CgaLANnp2laqrJC/oP4EWhsnOpfjjDVixvPHWNg1SkIhCDyKAmoLN9k7
pJ2ZmKCn0rIya9R0bane8LSHVDiLLFhjdDoOLLNO5jD3++eXQBoNdikMpBl2WUZ/
U7lAGEKjtXMxirLKCmkkZFFF0oQe1kEM5zT9B0X8Ox+r3UbFidHwx2Qj67hfmAAf
7OdpU4GZ9KgcC60wfF0C6g79r6qBjNh7lutlHNmbOA4iLpLw7hQ6d2EJ6NxbuhJV
NcEQBqPAS9gJb6fO6CifdSf7L/cR32QAF1i+JF4g9cZqVegdLt8T3oyt//sC+nAi
rhMQBb63PzlzAA3lVS8TrhKq6DmcBTiwwwdjP9QQomz9RdEyBg7UGTNlV5eM5TfQ
3DcKGvBzJ+QzKZrdYT1F57bFMD+GtBpBSDL4/KprcnL4G+0Z0PjwP2kvbp++NDGC
Ux3/AYMGKMC0sfb2IuHCBMK8ROeR4nRDgS38c6jlwacyD+iRHF2BjELlESGVIWpf
t8oIuiLK1S0CQo7zPOL45I2Y1Oubaxq/ujXCA3rQU662+nBWlSc=
=5xqG
-----END PGP SIGNATURE-----

--gaiqb3qmgvc3uh4b--

Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3EBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73672082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbfC0W1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 18:27:14 -0400
Received: from sauhun.de ([88.99.104.3]:39536 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfC0W1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 18:27:14 -0400
Received: from localhost (p5486CE6B.dip0.t-ipconnect.de [84.134.206.107])
        by pokefinder.org (Postfix) with ESMTPSA id 741FA2E35A2;
        Wed, 27 Mar 2019 23:27:12 +0100 (CET)
Date:   Wed, 27 Mar 2019 23:27:12 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: Re: [PATCH v5 0/8] iProc I2C slave mode and NIC mode
Message-ID: <20190327222712.GD15396@kunai>
References: <20190214175725.60462-1-ray.jui@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Hf61M2y+wYpnELGG"
Content-Disposition: inline
In-Reply-To: <20190214175725.60462-1-ray.jui@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Hf61M2y+wYpnELGG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 14, 2019 at 09:57:17AM -0800, Ray Jui wrote:
> This patch series adds the following support to the iProc I2C driver:
> - Increase maximum read transfer size to 255 bytes
> - I2C slave mode
> - Polling mode
> - NIC I2C mode
>=20
> This patch series is based on kernel v5.0-rc3 and available at:
> https://github.com/Broadcom/arm64-linux.git

So, I had a high level look at these patches and made a few comments. For
the details, I trust you (being the maintainer :))


--Hf61M2y+wYpnELGG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyb+L8ACgkQFA3kzBSg
KbZYPw/+PYVz9b2xHF9zo5/uC9rhvfMlpbw80Qc8bL+eeE9+/Q2HTKCxNxTCuUIh
oO1z66oFTDIdSPCQKnUKKSbiMun4a5k88lFQFm2emSU435yccnuCE+sAe+ER3XWJ
zFi2OjtBBERc/doieK68ppcyRTOg5Vj2jIWhyTQs6ZdcDAn4VtzZEzMyKemZdS1l
FUlNzfb+drlxqK1N96cnDHOl0laTEmp/CqbePXw4FJ9rGToXCMKf334knDJBgqU4
xzieZMQPVSXAOVI7uADihzvYq3GL1YQhcM4bf5G8mTkNPHDKhFbXBjHorH3hEFbH
YmGd5YUjaqpLhoKfZ5caapuryUM17BWzlT4QWAVvdMFpE/RYUIchkePU4tWZ1q7q
l6hB6VrTHsZ15kPCNQUD5aJpWJKnMWI/LwHbFrsiVxB2FqGD5RA18U6S3LRAOzQL
I8xj+O8Bvl3wtp1olbE++CXMd0Hk3AwLq+9p+Us18/AVgI9JGiCYinL/h4557TSK
y4oDvJXGW09QZnBgK7KkNiF3glVDbcOQyV2HWLFjCuWJVgXDcrSYKG0szW/Az+Rr
gIg+qa9x11nXjb5hhwWbPUY0HqoeMOCN3kp4BVrk2o5MhlBi4/G26yKPGHrljRyE
Jicrspmf50xyXSOLL9dz0B3FPYWTzssM6UDdsfrvkXvGB75FTIY=
=1BDz
-----END PGP SIGNATURE-----

--Hf61M2y+wYpnELGG--

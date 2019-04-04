Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66241C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 06:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E0A20882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 06:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfDDGQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 02:16:08 -0400
Received: from sauhun.de ([88.99.104.3]:55082 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfDDGQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 02:16:07 -0400
Received: from localhost (p5486CF5E.dip0.t-ipconnect.de [84.134.207.94])
        by pokefinder.org (Postfix) with ESMTPSA id 5B4C92C0114;
        Thu,  4 Apr 2019 08:16:05 +0200 (CEST)
Date:   Thu, 4 Apr 2019 08:16:01 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Ray Jui <ray.jui@broadcom.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 0/9] iProc I2C slave mode and NIC mode
Message-ID: <20190404061601.c7sbti2zyu6tsoyw@katana>
References: <20190403011830.3254-1-ray.jui@broadcom.com>
 <20190403204423.btgtke3tmt7pkr3j@ninjato>
 <06dff712-151b-f188-d154-3130d56d01d8@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nuqsrixpylmauw4w"
Content-Disposition: inline
In-Reply-To: <06dff712-151b-f188-d154-3130d56d01d8@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nuqsrixpylmauw4w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2019 at 03:20:14PM -0700, Florian Fainelli wrote:
> On 4/3/19 1:44 PM, Wolfram Sang wrote:
> > On Tue, Apr 02, 2019 at 06:18:21PM -0700, Ray Jui wrote:
> >> This patch series adds the following support to the iProc I2C driver:
> >> - Increase maximum read transfer size to 255 bytes
> >> - I2C slave mode
> >> - Polling mode
> >> - NIC I2C mode
> >>
> >> This patch series is based on kernel v5.1-rc3 and available at:
> >> https://github.com/Broadcom/arm64-linux.git
> >> branch: i2c-slave-v6
> >>
> >> Changes from v5:
> >>  - Address various comments from Wolfram
> >=20
> > In the future, please write in detail what you changed. I review so many
> > patches that I can't recall all my comments on every patch.
> >=20
> > That being said, all patches applied to for-next, thanks!
>=20
> OK, I will drop patch #9 from my queue then, thanks.

Sorry, I meant patches 1-8 applied, assuming patch 9 was already taken.
I usually don't pick up DTS patches, so I'd be happy if you could keep
#9 in your tree.


--nuqsrixpylmauw4w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyloR0ACgkQFA3kzBSg
KbaJkw//RcBa5KxvEuhAkwsWdS8X9lWErh6M1DVqlE6esIV5BzyjO+AcpQ4gfGTq
aPcO/Im6utF5SWnnHgnYwvCv/CKP9sA1ha5FWMmkd8aIZ5dHcrESvA3kKWKpirsZ
5bkphYdM2llcoxLEKJ361zVRoxIxhJ53HBuRDqv8jI7z8UFwU3CX1Io5a51ZiwcE
T5xJpIkdqq/N2vH24T8PS5nmUYO8ir7mImua/wM374RjqAmP+v/pS+lolBW8E6Dg
t+a6YIZ8pu3x8a3cz6EBZfhcvBiuZx/w0IOBFgSShmozJZUlOBjSrC76B3Puwu0M
Xj8Q7xRLlfXzuqTuCLOzAzGbnQa8uf23WXaAfHgzL1DwKEg6uuPVp594sWqyKRaz
Imps+m1Whii+u74Uvzf8Ig7keC9+5ho8xMlS4GQC5le6ZIrqxmcQUYWFnP4uVYhV
4ymcsTOeoJu7dABW8VTc9VCPYc/2olP8Xi4EXq1CE9k1Mr2sFbbTaq/FwiHFd8Eh
1RIR/D8sEMAVByWc9kjKfA+suCu8+0wzmebUo9NjTKvdfxqkQpc7fY51zqvKepys
9TXPAFFafNnZ/PCoSZXJCex5nauCFJMeKkJZHMDDQPyN2nTDCM+msp1JBVNyzIR9
0tKmVqSUen8WMVWrij6+xfsUIIDBK6h2A2ainrrFv76mfc3zruA=
=yCr3
-----END PGP SIGNATURE-----

--nuqsrixpylmauw4w--

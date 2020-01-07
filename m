Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82FCC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E5F206DB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbgAGTbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 14:31:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:34258 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728682AbgAGTbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 14:31:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9853BAC4A;
        Tue,  7 Jan 2020 19:31:49 +0000 (UTC)
Message-ID: <a2f77f1a8bb3b981d3e2fccd3fcb56733b63946a.camel@suse.de>
Subject: [GIT PULL] bcm2835-dt-next-2020-01-07
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <wahrenst@gmx.net>
Date:   Tue, 07 Jan 2020 20:31:48 +0100
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-dPkd0/o+G6GVBoisjtIy"
User-Agent: Evolution 3.34.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-dPkd0/o+G6GVBoisjtIy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Florian,

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a=
:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  https://github.com/vianpl/linux tags/bcm2835-dt-next-2020-01-07

for you to fetch changes up to 530735df62582d5d1f41faf0e0d1ca7d21dca571:

  ARM: dts: bcm2711: Enable HWRNG support (2020-01-07 20:11:51 +0100)

----------------------------------------------------------------
Stephen Brennan (2):
      ARM: dts: bcm2835: Move rng definition to common location
      ARM: dts: bcm2711: Enable HWRNG support

 arch/arm/boot/dts/bcm2711.dtsi        | 6 ++----
 arch/arm/boot/dts/bcm2835-common.dtsi | 6 ++++++
 arch/arm/boot/dts/bcm283x.dtsi        | 6 ------
 3 files changed, 8 insertions(+), 10 deletions(-)


--=-dPkd0/o+G6GVBoisjtIy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl4U3KQACgkQlfZmHno8
x/65SAf+NmZ2tYuGVZ1tPFBGugW+TKZ4/sZc8XrBeX8tDg1ozDZp27WsDe9umGb6
ojqvPr7FUtSL1kG5PIBAqTIJl9upzCsmEECpLIp8ZES243ZcH7dWARjqM0SCBxVs
OomJMI2NEuRyteq7s/7ibmVDyJGHSianm06hafyiups++fvjz0q8TrcZ6wM31Cu8
eJ70koJNf+R/2xcMRKdqjAtu47NJ1c5ny7NxN6BGeRyuc99Owl7qyK+V8y0jnteK
Ua4cW+EFy1DWILtDUT6tZpG+LEqdhcSM0V1f6KFPi3BwSDqtLPuszVMCf4iHkPCF
LFgv6rKl1SrB/4es1gFccTV8lfV18w==
=Hz8W
-----END PGP SIGNATURE-----

--=-dPkd0/o+G6GVBoisjtIy--


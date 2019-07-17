Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FC9C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 07:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D0A20818
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 07:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfGQHl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 03:41:26 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38511 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfGQHl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 03:41:26 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 7C61880592; Wed, 17 Jul 2019 09:41:13 +0200 (CEST)
Date:   Wed, 17 Jul 2019 09:41:24 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     jglisse@redhat.com, ebaskakov@nvidia.com, jhubbard@nvidia.com,
        mhairgrove@nvidia.com, SCheung@nvidia.com, sgutti@nvidia.com,
        aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
        benh@kernel.crashing.org, dan.j.williams@intel.com,
        dnellans@nvidia.com, hannes@cmpxchg.org,
        kirill.shutemov@linux.intel.com, mhocko@kernel.org,
        paulmck@linux.vnet.ibm.com, ross.zwisler@linux.intel.com,
        vdavydov.dev@gmail.com, liubo95@huawei.com,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        kernel list <linux-kernel@vger.kernel.org>
Subject: HMM_MIRROR has less than useful help text
Message-ID: <20190717074124.GA21617@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Commit c0b124054f9e42eb6da545a10fe9122a7d7c3f72 has very nice commit
message, explaining what HMM_MIRROR is and when it is
needed. Unfortunately, it did not make it into Kconfig help:

CONFIG_HMM_MIRROR:

Select HMM_MIRROR if you want to mirror range of the CPU page table of
a
process into a device page table. Here, mirror means "keep
synchronized".
Prerequisites: the device must provide the ability to write-protect
its
page tables (at PAGE_SIZE granularity), and must be able to recover
=66rom
the resulting potential page faults.

Could that be fixed?

This is key information for me:

# This is a heterogeneous memory management (HMM) process address space
# mirroring.
# This is useful for NVidia GPU >=3D Pascal, Mellanox IB >=3D mlx5 and more
# hardware in the future.

Thanks,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0u0SQACgkQMOfwapXb+vJ8zACcDY6r6pIBRTTsorfNlv1bWsri
YsoAn1qx2CsKnc8psHoMGpmjiWiWW/zT
=4Hji
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--

Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6700C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 12:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D7421849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 12:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbfGSMEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 08:04:36 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35807 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfGSMEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 08:04:36 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 8C75780305; Fri, 19 Jul 2019 14:04:22 +0200 (CEST)
Date:   Fri, 19 Jul 2019 14:04:33 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, john.hubbard@gmail.com,
        SCheung@nvidia.com, akpm@linux-foundation.org,
        aneesh.kumar@linux.vnet.ibm.com, benh@kernel.crashing.org,
        bsingharora@gmail.com, dan.j.williams@intel.com,
        dnellans@nvidia.com, ebaskakov@nvidia.com, hannes@cmpxchg.org,
        jglisse@redhat.com, jhubbard@nvidia.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        liubo95@huawei.com, mhairgrove@nvidia.com, mhocko@kernel.org,
        paulmck@linux.vnet.ibm.com, ross.zwisler@linux.intel.com,
        sgutti@nvidia.com, torvalds@linux-foundation.org,
        vdavydov.dev@gmail.com
Subject: Re: [PATCH] mm/Kconfig: additional help text for HMM_MIRROR option
Message-ID: <20190719120432.GC11224@amd>
References: <20190717074124.GA21617@amd>
 <20190719013253.17642-1-jhubbard@nvidia.com>
 <20190719055748.GA29082@infradead.org>
 <20190719105239.GA10627@amd>
 <20190719114853.GB15816@ziepe.ca>
 <20190719120043.GA15320@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="XWOWbaMNXpFDWE00"
Content-Disposition: inline
In-Reply-To: <20190719120043.GA15320@infradead.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XWOWbaMNXpFDWE00
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2019-07-19 05:00:43, Christoph Hellwig wrote:
> On Fri, Jul 19, 2019 at 08:48:53AM -0300, Jason Gunthorpe wrote:
> > It is like MMU_NOTIFIERS, if something needs it, then it will select
> > it.
> >=20
> > Maybe it should just be a hidden kconfig anyhow as there is no reason
> > to turn it on without also turning on a using driver.
>=20
> We can't just select it due to the odd X86_64 || PPC64 dependency.
>=20
> Which also answers Pavels question:  you never really need it, as we
> can only use it for optional functionality due to that.

Okay, just explain it in the help text :-)..

Alternatively... you can have WANT_HMM_MIRROR option drivers select,
and option HMM_MIRROR which is yes if WANT_HMM_MIRROR && (X86_64 ||
PPC64), no?

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--XWOWbaMNXpFDWE00
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0xsdAACgkQMOfwapXb+vJ4xQCgwUle9cq2liiK/z3wCY8zVZHp
nbwAoKj+VBag+zS1XtCAE1xHv6gYjwtN
=O3+x
-----END PGP SIGNATURE-----

--XWOWbaMNXpFDWE00--

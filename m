Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231F8C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 10:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00BAC20873
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 10:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfGSKwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 06:52:43 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33920 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfGSKwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 06:52:43 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id AEBEB802EE; Fri, 19 Jul 2019 12:52:28 +0200 (CEST)
Date:   Fri, 19 Jul 2019 12:52:39 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     john.hubbard@gmail.com, SCheung@nvidia.com,
        akpm@linux-foundation.org, aneesh.kumar@linux.vnet.ibm.com,
        benh@kernel.crashing.org, bsingharora@gmail.com,
        dan.j.williams@intel.com, dnellans@nvidia.com,
        ebaskakov@nvidia.com, hannes@cmpxchg.org, jglisse@redhat.com,
        jhubbard@nvidia.com, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org, liubo95@huawei.com,
        mhairgrove@nvidia.com, mhocko@kernel.org,
        paulmck@linux.vnet.ibm.com, ross.zwisler@linux.intel.com,
        sgutti@nvidia.com, torvalds@linux-foundation.org,
        vdavydov.dev@gmail.com, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] mm/Kconfig: additional help text for HMM_MIRROR option
Message-ID: <20190719105239.GA10627@amd>
References: <20190717074124.GA21617@amd>
 <20190719013253.17642-1-jhubbard@nvidia.com>
 <20190719055748.GA29082@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <20190719055748.GA29082@infradead.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2019-07-18 22:57:48, Christoph Hellwig wrote:
> On Thu, Jul 18, 2019 at 06:32:53PM -0700, john.hubbard@gmail.com wrote:
> > +	  HMM_MIRROR provides a way to mirror ranges of the CPU page tables
> > +	  of a process into a device page table. Here, mirror means "keep
> > +	  synchronized". Prerequisites: the device must provide the ability
> > +	  to write-protect its page tables (at PAGE_SIZE granularity), and
> > +	  must be able to recover from the resulting potential page faults.
> > +
> > +	  Select HMM_MIRROR if you have hardware that meets the above
> > +	  description. An early, partial list of such hardware is:
> > +	  an NVIDIA GPU >=3D Pascal, Mellanox IB >=3D mlx5, or an AMD GPU.
>=20
> Nevermind that the Nvidia support is stagaging and looks rather broken,
> there is no Mellanox user of this either at this point.
>=20
> But either way this has no business in a common kconfig help.  Just
> drop the fine grained details and leave it to the overview.

I disagree here. This explains what kind of hardware this is for (very
new). Partial list does not hurt, and I know that I probably don't
need to enable this.

How else am I supposed to know if my computer needs page tables
synchronized?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0xoPcACgkQMOfwapXb+vIiygCgpZIgxcueA5lGweI7pvQKR6l2
oNQAn2gePbpEnABaDspF4wN2+WKGu1GH
=y1s7
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--

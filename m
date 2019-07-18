Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71450C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 16:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F477208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 16:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731930AbfGRQgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 12:36:05 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36432 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbfGRQgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 12:36:04 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 262EE8029D; Thu, 18 Jul 2019 18:35:51 +0200 (CEST)
Date:   Thu, 18 Jul 2019 18:36:01 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Balbir Singh <bsingharora@gmail.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Evgeny Baskakov <ebaskakov@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        Sherry Cheung <SCheung@nvidia.com>,
        Subhash Gutti <sgutti@nvidia.com>,
        Aneesh Kumar KV <aneesh.kumar@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Nellans <dnellans@nvidia.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Bob Liu <liubo95@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: HMM_MIRROR has less than useful help text
Message-ID: <20190718163601.GA21502@amd>
References: <20190717074124.GA21617@amd>
 <CAKTCnzkzvPgMK8i-cTuWFLRPPg4=DTkVQmS238VTgYJaUy=iVA@mail.gmail.com>
 <CAPcyv4i3vzuWfKQXF-GWKpCXACjE6HTeczPRoHUp+tOBMEAP-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <CAPcyv4i3vzuWfKQXF-GWKpCXACjE6HTeczPRoHUp+tOBMEAP-Q@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2019-07-18 07:25:42, Dan Williams wrote:
> On Thu, Jul 18, 2019 at 4:04 AM Balbir Singh <bsingharora@gmail.com> wrot=
e:
> >
> > On Wed, Jul 17, 2019 at 5:41 PM Pavel Machek <pavel@ucw.cz> wrote:
> > >
> > > Hi!
> > >
> > > Commit c0b124054f9e42eb6da545a10fe9122a7d7c3f72 has very nice commit
> > > message, explaining what HMM_MIRROR is and when it is
> > > needed. Unfortunately, it did not make it into Kconfig help:
> > >
> > > CONFIG_HMM_MIRROR:
> > >
> > > Select HMM_MIRROR if you want to mirror range of the CPU page table of
> > > a
> > > process into a device page table. Here, mirror means "keep
> > > synchronized".
> > > Prerequisites: the device must provide the ability to write-protect
> > > its
> > > page tables (at PAGE_SIZE granularity), and must be able to recover
> > > from
> > > the resulting potential page faults.
> > >
> > > Could that be fixed?
> > >
> > > This is key information for me:
> > >
> > > # This is a heterogeneous memory management (HMM) process address spa=
ce
> > > # mirroring.
> > > # This is useful for NVidia GPU >=3D Pascal, Mellanox IB >=3D mlx5 an=
d more
> > > # hardware in the future.
> > >
> >
> > That seems like a reasonable request
>=20
> Hi Pavel, care to send a patch?

I hoped patch author would fix up their code. I'm not HMM expert, he
should be...

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0wn/EACgkQMOfwapXb+vLB6ACeLmMyj948TuYUlFIoTfib+UuC
2KwAn3SFfrNn/UFu/9H/1W7LWAGPUp1U
=54UH
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--

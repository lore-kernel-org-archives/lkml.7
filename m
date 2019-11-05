Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631CAC010A2
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4383021D71
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388019AbfKEMD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 07:03:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:47920 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730816AbfKEMD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 07:03:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E06A6B175;
        Tue,  5 Nov 2019 12:03:55 +0000 (UTC)
Date:   Tue, 5 Nov 2019 13:03:51 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Juri Lelli <juri.lelli@redhat.com>, mathieu.poirier@linaro.org
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tj@kernel.org, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com,
        lizefan@huawei.com, longman@redhat.com, dietmar.eggemann@arm.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v9 3/8] cpuset: Rebuild root domain deadline accounting
 information
Message-ID: <20191105120351.GA27680@blackbody.suse.cz>
References: <20190719140000.31694-1-juri.lelli@redhat.com>
 <20190719140000.31694-4-juri.lelli@redhat.com>
 <20191104185742.GC7827@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <20191104185742.GC7827@blackbody.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 04, 2019 at 07:57:42PM +0100, Michal Koutn=FD <mkoutny@suse.com=
> wrote:
> I came across a cgroup_enable_task_cg_lists() call from the cpuset
> controller...
>[...]
> > +	cgroup_enable_task_cg_lists();
> ...and I wonder why is it necessary to call at this place?
Consider this resolved.

I realized the on-demand linking is being removed [1].

Michal

[1] https://lore.kernel.org/lkml/20191024190351.GD3622521@devbig004.ftw2.fa=
cebook.com/

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl3BZSAACgkQia1+riC5
qSjJeA/+LieD4P2wFDrQQPLnvZP9VNIuG9T3bfqR5ZJVjmkp6k+r6SLFfUl6WmBj
bghhTtSKRhwgs6DY/2CoV5HmmYIbTXkDMBO5dHzspdAlSnE/ZMDjjp2g+6Tpz5Tw
dKs/nVqJZlAu2sNwZ1QiA1EELGQsSkRLEdcA1GuTTag0ISTUA6eq/lQYjqrXzenj
4a5lhILdqLg4kc1rgns5kJqZsrv9XND34MsaYS6ozYbeiDGAcuUpNXl3dv+B6tip
vlN2FntBa3oOndXEtMpsblTsgyyq1ejc1F6dO1RXpQMAz0+xZfwKJCItsUp0QQZD
8XkSZ5r+ZBWQkOIwjXm3j1DmUO9/THcjUs5Fy1NRupBZb9aM/D4en9CbCMjO9+QR
KPFWxqc/ZoutHXk0hEtgMBkTli7+bEUMJMxAR2pHol4+2igm5J3qDLUtQ0c4NoSA
9n/d/C34cRLZ5kF7yM8ZhxpUj3HaCWXjHGjU7cjKS8P3fV/NdLzmGZ62ERvlnW3x
ZGPDl/Kfmdm6wtoLvFKPHL+ZKPVcf5ZBd38i2dxDtB2iT9RfKhQl+s6f2V59tmXB
GYnWZ/xC3m65yUpu0vY8gpwY9dsPy9HoA3PUOhs3xXggnuCAPFrK1O20RWHGLycv
dpYJ0D/pjWVm2zRpNN0/G6wLPqPTZns3QHZdJnBQtaYZXSf4iUU=
=7YJf
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--

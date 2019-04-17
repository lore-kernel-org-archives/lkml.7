Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BC4C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE67F2173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732453AbfDQOo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:44:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:56062 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727087AbfDQOo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:44:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BE7A4AC8D;
        Wed, 17 Apr 2019 14:44:56 +0000 (UTC)
Date:   Wed, 17 Apr 2019 16:44:54 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     kbuild-all@01.org, Michael Kerrisk <mtk.manpages@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        kbuild test robot <lkp@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Andrey Vagin <avagin@openvz.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>
Subject: Re: [PATCH] prctl: Don't compile some of prctl functions when CRUI
Message-ID: <20190417144454.GG8962@blackbody.suse.cz>
References: <20180420140044.478b4c88d3cf238bd440f2a7@linux-foundation.org>
 <20190417122349.GA15498@blackbody.suse.cz>
 <20190417123841.GA3040@uranus.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="I3tAPq1Rm2pUxvsp"
Content-Disposition: inline
In-Reply-To: <20190417123841.GA3040@uranus.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--I3tAPq1Rm2pUxvsp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 17, 2019 at 03:38:41PM +0300, Cyrill Gorcunov <gorcunov@gmail.com> wrote:
> I've a bit vague memory what we've ended up with, but iirc there was
> a problem with brk() syscall or similar. Then I think we left everything
> as is.
Was this related to the removal of non PR_SET_MM_MAP operations too?
Do you have any pointers to the topic?

Thanks,
Michal

--I3tAPq1Rm2pUxvsp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+amhwRV4jZeXdUhoK2l36XSZ9y4FAly3O98ACgkQK2l36XSZ
9y7esA//WwmLG83LYCd7UEnuhi8+S8kWjuiCuHatRKNARkvCkRH7bJglwfiqMm12
N0dFp1jMqVmB2Hjj7n6o+Md64ssWNZIRFVR7VOY4b039IhaBrT+HXjjRn6ZzqRR+
gazA5YSYjRNgolW/ecD5bLkKiIGFYtXHDwW2iS7sqQbnXDidVa+kUM85Qo+b7T+T
v5QhVVWav63gQI17o9zn3n0k5P+ZZSUwzQgBo+t6JHAmepLXARZPiDL6OFPDYGb8
IqApKCMjTY8+8QumsjjsxDgsKzr8tRZ2C2R/ZDfzRESpSy8zfd/p58hVnp3zu3v9
vqb4juSEZjCZkwGbKt13BCgQhvfGxPKa8WfjeJJwTXsSBBDIPtuIqaJdpFqJE4qm
h1cBCRyxLBpPQWc1yhhvWHptiZO08+pMi8/MSHCyunp6DgMKYdq8G2JTmMuDHTit
nYeifRH12O7F8uF4wIR1vx8w+iX+kySnB26edPhD0QDF5rmwFqAiWfoufVhv8jkS
EYeE5EO0M08eUPC/jZ3BVnZeyE7HnSaPs2LtO6BfjOt8hnoD+jUxwcNVSXxHxOzU
8BZOIEaRU2Sv98Drlgj5h7+Y7rhQDpfnfwIbtfCmuQv679UIpPh5X3LE4f7kZ06I
cYoTF1Nnb1OIvg/W45K+dMceADvMjszmIBy2tFIton2pAdJU12w=
=Daol
-----END PGP SIGNATURE-----

--I3tAPq1Rm2pUxvsp--

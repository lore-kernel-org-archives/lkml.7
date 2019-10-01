Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F1CC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 15:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCD2A21872
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 15:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389345AbfJAPMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 11:12:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:40862 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727234AbfJAPMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 11:12:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D34D9AE6F;
        Tue,  1 Oct 2019 15:12:06 +0000 (UTC)
Date:   Tue, 1 Oct 2019 17:12:02 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH RFC 00/14] The new slab memory controller
Message-ID: <20191001151202.GA6678@blackbody.suse.cz>
References: <20190905214553.1643060-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <20190905214553.1643060-1-guro@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2019 at 02:45:44PM -0700, Roman Gushchin <guro@fb.com> wrot=
e:
> Roman Gushchin (14):
> [...]
>   mm: memcg/slab: use one set of kmem_caches for all memory cgroups
=46rom that commit's message:

> 6) obsoletes kmem.slabinfo cgroup v1 interface file, as there are
>   no per-memcg kmem_caches anymore (empty output is printed)

The empty file means no allocations took place in the particular cgroup.
I find this quite a surprising change for consumers of these stats.

I understand obtaining the same data efficiently from the proposed
structures is difficult, however, such a change should be avoided. (In
my understanding, obsoleted file ~ not available in v2, however, it
should not disappear from v1.)

Michal

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl2TbL0ACgkQia1+riC5
qSjtyw//Q9irsBUmzzO7fLu+QOyURpQ2ZjO3sXu7uIrvowbkqO8p92+uOW80tg63
wr/cj1FDqvjH2PifafSPtveuj9u082401P1d6b9FhSJHPVPPFLEDNb0jlGCykkAE
FyecsMGIisiDA/SUQsY1IC+Xo8emxHADFH74SK0AMfVSqxlwM+DKxZE3kyBEWPTs
/Je+RmHv0Hn5em6OecPSS5PNfw3ckAd1C+gvBdQtsZmHXUjdqHPIBCpm62F7sVpl
hDs9VRe8+4SoBPd1qjSQFChaiR4eGFd5JE5ncQrYEdjoheWC2+ofJzxAg8fPhIXJ
8nAPyczxoYwTXZiMscSyCmPDNOdMWeU6LwnM9QP67RLTWk9EsnfB5AVK7YCHZvrv
l07HUv8hV3PbA8gFcAnG/Ad6xFuV9wEvT+ORl2eztGdaTzV/kwl5q/blgipCL6Uv
A7nTqOUnVNVnbDld1HUUpFy+cIzIwAAJ5dGrh92vl9QA9TERzGvNmGBS0Td5NfKY
vUE3NfXRhXt4auowuiAZaIxJbM3KM1wrc9S7A7AVjZlOwqVXho//Ijn6z38dwBWA
s3xIggc7XkezkbOMqdQacX/4E+AL5tFVaS1esTw/1lKQwDDQRCATdP6Ikah/erR1
k4RS9nN9EovAsXLErxoXGctOoHrr0hQqs/hkW80YtiXtxVIOsnU=
=HEF2
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--

Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9B7C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2ECC20684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfCFXJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 18:09:56 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57471 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfCFXJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 18:09:56 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 69B4A80192; Thu,  7 Mar 2019 00:09:47 +0100 (CET)
Date:   Thu, 7 Mar 2019 00:09:53 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        eranian@google.com, vincent.weaver@maine.edu,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: System crash with perf_fuzzer (kernel: 5.0.0-rc3)
Message-ID: <20190306230953.GC7915@amd>
References: <7c7ec3d9-9af6-8a1d-515d-64dcf8e89b78@linux.ibm.com>
 <20190125160056.GG6118@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Sr1nOIr3CvdE5hEN"
Content-Disposition: inline
In-Reply-To: <20190125160056.GG6118@tassilo.jf.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Sr1nOIr3CvdE5hEN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2019-01-25 08:00:56, Andi Kleen wrote:
> > [Fri Jan 25 10:28:53 2019] perf: interrupt took too long (2501 > 2500),=
 lowering kernel.perf_event_max_sample_rate to 79750
> > [Fri Jan 25 10:29:08 2019] perf: interrupt took too long (3136 > 3126),=
 lowering kernel.perf_event_max_sample_rate to 63750
> > [Fri Jan 25 10:29:11 2019] perf: interrupt took too long (4140 > 3920),=
 lowering kernel.perf_event_max_sample_rate to 48250
> > [Fri Jan 25 10:29:11 2019] perf: interrupt took too long (5231 > 5175),=
 lowering kernel.perf_event_max_sample_rate to 38000
> > [Fri Jan 25 10:29:11 2019] perf: interrupt took too long (6736 > 6538),=
 lowering kernel.perf_event_max_sample_rate to 29500
>=20
> These are fairly normal.

Unfortunately, they are. Could we set up our defaults so that they
don't normally happen?

pavel@amd:~/g/unicsy_demo$ dmesg | grep "took too"
[  761.507893] perf: interrupt took too long (2516 > 2500), lowering
kernel.perf_event_max_sample_rate to 79250
[ 4736.674595] perf: interrupt took too long (3209 > 3145), lowering
kernel.perf_event_max_sample_rate to 62250
pavel@amd:~/g/unicsy_demo$


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Sr1nOIr3CvdE5hEN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyAU0EACgkQMOfwapXb+vJTEQCghbIoqocOdk1rDwJsoRb7+0Jp
IbMAoL+bib41Od+R688k6MrE2rLmkTxQ
=14SK
-----END PGP SIGNATURE-----

--Sr1nOIr3CvdE5hEN--

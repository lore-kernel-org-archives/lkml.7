Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F97CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF4AD20717
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731636AbfJ2JQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:16:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:39818 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727195AbfJ2JQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:16:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D3EDBB1A3;
        Tue, 29 Oct 2019 09:16:47 +0000 (UTC)
Message-ID: <35fdb9117d7a50677e28ef865c83ca6c8a325f03.camel@suse.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
From:   Dario Faggioli <dfaggioli@suse.com>
To:     Aaron Lu <aaron.lu@linux.alibaba.com>,
        Aubrey Li <aubrey.intel@gmail.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?ISO-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Date:   Tue, 29 Oct 2019 10:16:46 +0100
In-Reply-To: <277737d6034b3da072d3b0b808d2fa6e110038b0.camel@suse.com>
References: <20190726152101.GA27884@sinkpad>
         <7dc86e3c-aa3f-905f-3745-01181a3b0dac@linux.intel.com>
         <20190802153715.GA18075@sinkpad>
         <eec72c2d533b7600c63de3c8001cc6ab9e915afe.camel@suse.com>
         <69cd9bca-da28-1d35-3913-1efefe0c1c22@linux.intel.com>
         <fab8eabb-1cfa-9bf6-02af-3afdff3f955d@linux.intel.com>
         <20190911140204.GA52872@aaronlu>
         <7b001860-05b4-4308-df0e-8b60037b8000@linux.intel.com>
         <20190912120400.GA16200@aaronlu>
         <CAERHkrsrszO4hJqVy=g7P74h9d_YJzW7GY4ptPKykTX-mc9Mdg@mail.gmail.com>
         <20190915141402.GA1349@aaronlu>
         <277737d6034b3da072d3b0b808d2fa6e110038b0.camel@suse.com>
Organization: SUSE
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-d6+O5MDGW9DsW0uRNY0L"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-d6+O5MDGW9DsW0uRNY0L
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-10-29 at 10:11 +0100, Dario Faggioli wrote:
> On Sun, 2019-09-15 at 22:14 +0800, Aaron Lu wrote:
> > I'm using the following branch as base which is v5.1.5 based:
> > https://github.com/digitalocean/linux-coresched coresched-v3-
> > v5.1.5-
> > test
> >=20
> > And I have pushed Tim's branch to:
> > https://github.com/aaronlu/linux coresched-v3-v5.1.5-test-tim
> >=20
> > Mine:
> > https://github.com/aaronlu/linux coresched-v3-v5.1.5-test-
> > core_vruntime
> >=20
> Hello,
>=20
> As anticipated, I've been trying to follow the development of this
> feature and, in the meantime, I have done some benchmarks.
>=20
> I actually have a lot of data (and am planning for more), so I am
> sending a few emails, each one with a subset of the numbers in it,
> instead than just one which would be beyond giant! :-)
>=20
KERNBENCH
=3D=3D=3D=3D=3D=3D=3D=3D=3D

http://xenbits.xen.org/people/dariof/benchmarks/results/linux/core-sched/mm=
tests/boxes/wayrath/coresched-email-3_kernbench.txt

                                       v                      v            =
         BM                     BM                     BM                  =
   BM                     BM                     BM
                                   BM-HT                BM-noHT            =
         HT                   noHT                 csc-HT        csc_stallf=
ix-HT             csc_tim-HT        csc_vruntime-HT
Amean     elsp-2       200.07 (   0.00%)      196.88 *   1.60%*      199.93=
 (   0.07%)      196.89 *   1.59%*      200.86 *  -0.39%*      200.83 *  -0=
.38%*      199.47 *   0.30%*      200.45 *  -0.19%*
Amean     elsp-4       115.56 (   0.00%)      108.64 *   5.99%*      115.12=
 (   0.39%)      108.72 *   5.92%*      118.17 *  -2.25%*      116.92 *  -1=
.18%*      115.92 (  -0.31%)      115.86 (  -0.25%)
Amean     elsp-8        84.72 (   0.00%)      110.77 * -30.75%*       84.19=
 (   0.62%)      111.03 * -31.06%*       84.78 (  -0.07%)       84.63 (   0=
.11%)       89.09 *  -5.16%*       90.21 *  -6.48%*
Amean     elsp-16       85.06 (   0.00%)      113.63 * -33.59%*       85.33=
 (  -0.32%)      113.83 * -33.81%*       85.95 *  -1.04%*       85.73 *  -0=
.78%*       90.20 *  -6.04%*       90.46 *  -6.35%*
Stddev    elsp-2         0.11 (   0.00%)        0.05 (  59.33%)        0.43=
 (-278.63%)        0.05 (  60.30%)        0.20 ( -75.43%)        0.15 ( -28=
.90%)        0.16 ( -40.87%)        0.08 (  26.69%)
Stddev    elsp-4         0.54 (   0.00%)        0.37 (  30.80%)        0.02=
 (  96.11%)        0.09 (  83.05%)        1.10 (-105.52%)        0.24 (  55=
.54%)        0.10 (  81.29%)        0.26 (  50.67%)
Stddev    elsp-8         0.82 (   0.00%)        0.25 (  69.66%)        0.28=
 (  65.58%)        0.27 (  66.75%)        0.30 (  63.64%)        0.07 (  92=
.05%)        0.09 (  88.92%)        0.19 (  77.18%)
Stddev    elsp-16        0.07 (   0.00%)        0.32 (-375.21%)        0.41=
 (-502.93%)        0.19 (-176.54%)        0.22 (-219.28%)        0.21 (-208=
.51%)        0.31 (-358.10%)        0.09 ( -32.49%)
                                       v                      v            =
         VM                     VM                     VM                  =
   VM                     VM                     VM
                                   VM-HT                VM-noHT            =
         HT                   noHT                 csc-HT        csc_stallf=
ix-HT             csc_tim-HT        csc_vruntime-HT
Amean     elsp-2       229.61 (   0.00%)      202.26 *  11.91%*      205.30=
 *  10.59%*      201.14 *  12.40%*      207.43 *   9.66%*      207.30 *   9=
.72%*      205.92 *  10.32%*      206.69 *   9.98%*
Amean     elsp-4       128.32 (   0.00%)      124.33 *   3.11%*      116.84=
 *   8.95%*      124.66 *   2.85%*      121.86 *   5.04%*      140.87 *  -9=
.78%*      118.28 *   7.83%*      122.58 *   4.48%*
Amean     elsp-8        87.33 (   0.00%)      118.45 * -35.63%*       85.52=
 (   2.07%)      118.61 * -35.81%*       96.92 * -10.98%*      110.31 * -26=
.31%*       88.69 (  -1.55%)       88.49 (  -1.32%)
Amean     elsp-16       87.00 (   0.00%)      116.17 * -33.52%*       86.41=
 (   0.68%)      116.43 * -33.82%*      103.24 * -18.67%*       90.77 *  -4=
.33%*       88.89 *  -2.17%*       89.35 *  -2.70%*
Stddev    elsp-2         0.24 (   0.00%)        1.90 (-702.44%)        0.39=
 ( -63.41%)        0.45 ( -91.41%)        1.78 (-650.49%)        1.31 (-454=
.67%)        0.22 (   8.97%)        1.09 (-362.56%)
Stddev    elsp-4         0.10 (   0.00%)        0.56 (-484.51%)        0.16=
 ( -63.75%)        0.60 (-524.50%)        0.47 (-392.73%)        2.53 (-255=
6.69%)        0.37 (-288.05%)        0.19 ( -96.77%)
Stddev    elsp-8         1.48 (   0.00%)        0.28 (  81.02%)        0.08=
 (  94.57%)        0.19 (  87.46%)        1.25 (  15.23%)        2.84 ( -92=
.18%)        1.23 (  16.49%)        0.58 (  60.60%)
Stddev    elsp-16        0.62 (   0.00%)        0.33 (  46.43%)        0.07=
 (  89.43%)        0.50 (  20.24%)        0.54 (  12.75%)        0.93 ( -49=
.52%)        0.44 (  29.54%)        0.29 (  53.95%)
                                      v                      v             =
        VM                     VM                     VM                   =
  VM                     VM                     VM
                               VM-v4-HT             VM-v4-noHT             =
     v4-HT                v4-noHT              v4-csc-HT     v4-csc_stallfi=
x-HT          v4-csc_tim-HT     v4-csc_vruntime-HT
Amean     elsp-2      227.42 (   0.00%)      202.75 *  10.85%*      201.44 =
*  11.42%*      201.05 *  11.60%*      207.88 *   8.59%*      210.35 *   7.=
51%*      204.07 *  10.27%*      204.16 *  10.23%*
Amean     elsp-4      124.46 (   0.00%)      128.74 *  -3.44%*      111.03 =
*  10.79%*      110.48 *  11.23%*      116.46 *   6.43%*      132.08 *  -6.=
13%*      112.10 *   9.93%*      112.44 *   9.66%*
Amean     elsp-8      127.12 (   0.00%)      114.00 *  10.32%*      113.37 =
*  10.82%*      112.50 *  11.50%*      118.62 *   6.69%*      135.04 *  -6.=
23%*      114.19 *  10.18%*      114.36 *  10.04%*
Stddev    elsp-2        0.16 (   0.00%)        0.05 (  68.44%)        0.23 =
( -45.93%)        0.32 (-101.53%)        0.89 (-471.21%)        0.86 (-452.=
61%)        0.13 (  18.49%)        0.08 (  51.98%)
Stddev    elsp-4        0.09 (   0.00%)        0.90 (-958.30%)        0.17 =
( -95.69%)        0.40 (-364.45%)        1.33 (-1462.83%)        0.61 (-621=
.84%)        0.20 (-134.86%)        0.06 (  28.48%)
Stddev    elsp-8        0.14 (   0.00%)        0.10 (  29.71%)        0.40 =
(-181.91%)        0.05 (  67.30%)        1.34 (-857.21%)        0.43 (-206.=
99%)        0.09 (  39.30%)        0.12 (  12.79%)
                                       v                      v            =
       VMx2                   VMx2                   VMx2                  =
 VMx2                   VMx2                   VMx2
                                 VMx2-HT              VMx2-noHT            =
         HT                   noHT                 csc-HT        csc_stallf=
ix-HT             csc_tim-HT        csc_vruntime-HT
Amean     elsp-2       206.25 (   0.00%)      338.78 * -64.26%*      296.38=
 * -43.70%*      335.66 * -62.75%*      327.38 * -58.73%*      443.46 *-115=
.01%*      317.41 * -53.90%*      295.89 * -43.47%*
Amean     elsp-4       117.69 (   0.00%)      267.38 *-127.19%*      174.91=
 * -48.62%*      263.22 *-123.66%*      201.69 * -71.37%*      317.24 *-169=
.56%*      193.92 * -64.77%*      193.04 * -64.02%*
Amean     elsp-8        85.93 (   0.00%)      225.41 *-162.31%*      146.21=
 * -70.14%*      221.96 *-158.29%*      188.12 *-118.91%*      203.79 *-137=
.15%*      154.66 * -79.98%*      162.26 * -88.82%*
Amean     elsp-16       86.82 (   0.00%)      221.32 *-154.92%*      141.53=
 * -63.02%*      217.27 *-150.27%*      180.06 *-107.41%*      190.36 *-119=
.27%*      143.76 * -65.59%*      156.84 * -80.65%*
Stddev    elsp-2         1.01 (   0.00%)        1.11 ( -10.37%)        2.24=
 (-121.88%)        1.36 ( -35.11%)       22.86 (-2164.27%)       24.78 (-23=
53.59%)        2.84 (-180.79%)        0.91 (  10.16%)
Stddev    elsp-4         0.18 (   0.00%)        4.55 (-2398.38%)        0.6=
2 (-239.73%)        3.15 (-1630.91%)        3.00 (-1551.21%)       10.85 (-=
5864.08%)        5.87 (-3124.85%)        3.79 (-1984.93%)
Stddev    elsp-8         0.42 (   0.00%)        1.13 (-167.05%)        0.44=
 (  -4.45%)        2.91 (-590.61%)        4.16 (-885.58%)        6.85 (-152=
4.29%)        0.78 ( -85.34%)        1.48 (-252.23%)
Stddev    elsp-16        0.41 (   0.00%)        2.40 (-478.92%)        2.21=
 (-432.16%)        3.27 (-688.15%)        9.50 (-2189.54%)        3.39 (-71=
7.66%)        2.00 (-383.08%)        0.48 ( -15.60%)


So, if only building kernels were the only thing that people do with
computers, we could say we're done, and go have beers! :-)

In fact, here, core scheduling is doing good on baremetal. E.g., look
at what happens, in the BM- group of measurements, when number of jobs
is higher than 8, which is how many CPUs we have.

It's actually doing quite fine in Virt too. Among the various variants
(sorry), plain v3, even with stallfix on, is the one performing worse.
Tim's patches seems to me to be the better looking set of numbers for
this workload.

Furthermore, there's basically no overhead --actually, there are
speedups-- until there is not virt-overcommitment. In fact, in the VMx2
group of measurements, even just applying the core scheduling v3
patches makes the VM

--=20
Dario Faggioli, Ph.D
http://about.me/dario.faggioli
Virtualization Software Engineer
SUSE Labs, SUSE https://www.suse.com/
-------------------------------------------------------------------
<<This happens because _I_ choose it to happen!>> (Raistlin Majere)


--=-d6+O5MDGW9DsW0uRNY0L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEES5ssOj3Vhr0WPnOLFkJ4iaW4c+4FAl24A34ACgkQFkJ4iaW4
c+6BGg/+LhmsCaXoqqbVqlLiWGofMU3LgyIa2JhzVp+QBUUj/ZATuvMUOCZB4/fK
J0tzt9judW0y8vnBt1m36Q5T3kL7SwUwI+/f/eIUSfuIkKiy/me+mehT9fmt9/rN
cf2fG/dGA3sWVY5VlcLVvhe4MRdV5vwDuQCjrW+SA7CoT8udE/B8hOB1ShCkwhJy
FzrD5NHR8lEqhEMe7kPOeRFTEtzKER15E/B4Hu5AL6lrgOTGUCFjBp/2u9Tqj4+t
5pWTUPHf5QYzvJbcfxsPu4oic3B1TkxKzLbp6SKplmuwb6kDtVXMqrf1/7nx95jZ
2/lP87SiLhejw9JSClQzU7hLbHQK6sZRU/ez6zIT0NOnmrCEJqN3bEV18JXMNY4e
5NpZY0NxudlMK+QnwWUNWhYPBUelTCzd8GaJJgwMYihVelnKYWrshOAb04oTTeXj
lil+NwIoza4FwT7F4YspLcRzGjvfdjj18sBnUfRx6oUhy6TC+zmYLv73nqb4xoOY
H3N5MYJjlDfpfGkncUbNGIgvDh8tKNdsD1pqCHaJRg9i6EMnPhs2G9xgZVU3Isci
ip2HRP+j/2dDXEg1nc17MTwkhN7L8sSQ+QE5HnoTSwzSonhwj4t2YfhyhLBDIl7Z
BXi1qlWBbjiwFmaFp4zBM0QUhMvvLXiMEmySCI5bznqUQNHgPE8=
=Sp7T
-----END PGP SIGNATURE-----

--=-d6+O5MDGW9DsW0uRNY0L--


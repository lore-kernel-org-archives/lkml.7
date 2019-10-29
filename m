Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52038CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F9AE20717
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731890AbfJ2JSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:18:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:40548 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730066AbfJ2JSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:18:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 40957B21E;
        Tue, 29 Oct 2019 09:18:06 +0000 (UTC)
Message-ID: <fd3ac6a6c1ff77c7b0c04eccd1da526e564f1b70.camel@suse.com>
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
Date:   Tue, 29 Oct 2019 10:18:04 +0100
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
        protocol="application/pgp-signature"; boundary="=-RwOX30FLRoOswSa3sgcf"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RwOX30FLRoOswSa3sgcf
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
SYSBENCHTHREAD
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

http://xenbits.xen.org/people/dariof/benchmarks/results/linux/core-sched/mm=
tests/boxes/wayrath/coresched-email-5_sysbenchthread.txt

                                  v                      v                 =
    BM                     BM                     BM                     BM=
                     BM                     BM
                              BM-HT                BM-noHT                 =
    HT                   noHT                 csc-HT        csc_stallfix-HT=
             csc_tim-HT        csc_vruntime-HT
Amean     1         1.12 (   0.00%)        1.11 (   0.38%)        1.14 *  -=
2.43%*        1.15 *  -2.81%*        8.49 *-659.72%*        8.43 *-654.99%*=
        8.42 *-653.96%*        8.38 *-649.74%*
Amean     3         1.11 (   0.00%)        1.11 (   0.00%)        1.14 *  -=
2.70%*        1.14 *  -2.96%*        8.35 *-651.29%*        8.42 *-657.20%*=
        8.34 *-650.77%*        8.41 *-656.56%*
Amean     5         1.11 (   0.00%)        1.11 (   0.00%)        1.14 *  -=
2.70%*        1.14 *  -2.82%*        8.34 *-649.81%*        8.41 *-655.46%*=
        8.32 *-647.75%*        8.34 *-649.42%*
Amean     7         1.12 (   0.00%)        1.11 (   0.38%)        1.14 *  -=
2.43%*        1.15 *  -2.69%*        8.31 *-643.48%*        8.40 *-652.05%*=
        8.41 *-653.20%*        8.33 *-645.65%*
Amean     12        1.12 (   0.00%)        1.12 (   0.00%)        1.14 *  -=
2.43%*        1.14 *  -2.56%*        8.38 *-651.34%*        8.41 *-654.16%*=
        8.32 *-645.71%*        8.38 *-651.09%*
Amean     16        1.11 (   0.00%)        1.11 (  -0.13%)        1.15 *  -=
3.08%*        1.14 *  -2.57%*        8.42 *-656.61%*        8.36 *-651.60%*=
        8.31 *-646.73%*        8.39 *-654.30%*
Stddev    1         0.01 (   0.00%)        0.01 (  49.47%)        0.01 (  6=
4.27%)        0.01 (  39.86%)        0.08 (-414.47%)        0.16 (-976.34%)=
        0.01 (  36.42%)        0.09 (-525.69%)
Stddev    3         0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   =
0.00%)        0.01 (-108.17%)        0.13 (-3211.60%)        0.10 (-2531.86=
%)        0.06 (-1515.55%)        0.10 (-2467.10%)
Stddev    5         0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   =
0.00%)        0.01 (  -9.54%)        0.12 (-2271.92%)        0.10 (-1917.42=
%)        0.09 (-1700.00%)        0.09 (-1725.38%)
Stddev    7         0.01 (   0.00%)        0.01 (  20.53%)        0.01 (  4=
3.80%)        0.01 (   0.00%)        0.13 (-1255.69%)        0.10 (-988.21%=
)        0.03 (-247.93%)        0.08 (-762.68%)
Stddev    12        0.01 (   0.00%)        0.01 ( -24.03%)        0.00 (  3=
7.98%)        0.01 (   0.00%)        0.13 (-1577.68%)        0.10 (-1210.31=
%)        0.10 (-1140.97%)        0.06 (-644.73%)
Stddev    16        0.00 (   0.00%)        0.01 (  -9.54%)        0.01 ( -5=
4.92%)        0.00 (  22.54%)        0.15 (-3032.73%)        0.12 (-2401.20=
%)        0.11 (-2206.51%)        0.07 (-1304.28%)
                                  v                      v                 =
    VM                     VM                     VM                     VM=
                     VM                     VM
                              VM-HT                VM-noHT                 =
    HT                   noHT                 csc-HT        csc_stallfix-HT=
             csc_tim-HT        csc_vruntime-HT
Amean     1         1.43 (   0.00%)        1.15 *  19.56%*        1.15 *  1=
9.36%*        1.19 *  16.67%*        1.16 *  19.16%*        1.17 *  18.46%*=
        1.16 *  18.66%*        1.16 *  18.86%*
Amean     3         1.43 (   0.00%)        1.16 *  19.16%*        1.16 *  1=
9.26%*        1.17 *  18.46%*        1.16 *  19.16%*        1.21 *  15.17%*=
        1.16 *  18.86%*        1.21 *  15.27%*
Amean     5         1.43 (   0.00%)        1.15 *  19.28%*        1.18 *  1=
7.78%*        1.17 *  18.08%*        1.16 *  19.18%*        1.17 *  18.18%*=
        1.16 *  19.08%*        1.18 *  17.58%*
Amean     7         1.43 (   0.00%)        1.16 *  19.26%*        1.16 *  1=
8.86%*        1.17 *  18.56%*        1.16 *  19.16%*        1.19 *  16.57%*=
        1.15 *  19.36%*        1.15 *  19.36%*
Amean     12        1.44 (   0.00%)        1.16 *  19.44%*        1.16 *  1=
9.44%*        1.17 *  18.75%*        1.16 *  19.25%*        1.18 *  18.06%*=
        1.16 *  19.15%*        1.16 *  19.44%*
Amean     16        1.46 (   0.00%)        1.16 *  20.37%*        1.16 *  2=
0.37%*        1.16 *  20.47%*        1.16 *  20.37%*        1.17 *  19.59%*=
        1.17 *  20.08%*        1.16 *  20.37%*
Stddev    1         0.00 (   0.00%)        0.00 (   0.00%)        0.01 ( -4=
1.42%)        0.05 (-1314.21%)        0.00 ( -29.10%)        0.00 ( -29.10%=
)        0.01 (-236.65%)        0.02 (-316.33%)
Stddev    3         0.00 (   0.00%)        0.00 ( -29.10%)        0.01 (-10=
8.17%)        0.03 (-773.69%)        0.01 (-100.00%)        0.09 (-2324.18%=
)        0.01 (-138.05%)        0.06 (-1378.74%)
Stddev    5         0.00 (   0.00%)        0.01 ( -99.00%)        0.05 ( -9=
9.00%)        0.02 ( -99.00%)        0.01 ( -99.00%)        0.01 ( -99.00%)=
        0.01 ( -99.00%)        0.04 ( -99.00%)
Stddev    7         0.00 (   0.00%)        0.01 ( -41.42%)        0.01 (-13=
8.05%)        0.02 (-468.62%)        0.01 (-100.00%)        0.06 (-1600.00%=
)        0.01 (-108.17%)        0.01 ( -41.42%)
Stddev    12        0.00 (   0.00%)        0.00 ( 100.00%)        0.00 ( 10=
0.00%)        0.03 (-11031521092846084.00%)        0.00 (-2034518927425100.=
00%)        0.01 (-4169523056347680.00%)        0.01 (-2228703820443891.00%=
)        0.00 ( 100.00%)
Stddev    16        0.05 (   0.00%)        0.00 (  92.31%)        0.00 (  9=
2.31%)        0.00 ( 100.00%)        0.00 (  92.31%)        0.01 (  80.64%)=
        0.01 (  89.12%)        0.00 (  92.31%)
                                 v                      v                  =
   VM                     VM                     VM                     VM =
                    VM                     VM
                          VM-v4-HT             VM-v4-noHT                  =
v4-HT                v4-noHT              v4-csc-HT     v4-csc_stallfix-HT =
         v4-csc_tim-HT     v4-csc_vruntime-HT
Amean     1        1.43 (   0.00%)        1.17 *  18.15%*        1.15 *  19=
.64%*        1.15 *  19.44%*        1.16 *  19.14%*        1.17 *  18.34%* =
       1.16 *  18.94%*        1.16 *  18.94%*
Amean     3        1.43 (   0.00%)        1.17 *  18.33%*        1.17 *  18=
.73%*        1.15 *  19.52%*        1.15 *  19.52%*        1.19 *  16.93%* =
       1.16 *  19.12%*        1.16 *  19.32%*
Amean     5        1.43 (   0.00%)        1.18 *  17.45%*        1.15 *  19=
.44%*        1.15 *  19.54%*        1.17 *  18.15%*        1.18 *  17.55%* =
       1.15 *  19.44%*        1.16 *  19.04%*
Amean     7        1.43 (   0.00%)        1.18 *  17.53%*        1.16 *  19=
.32%*        1.15 *  19.72%*        1.17 *  18.33%*        1.17 *  18.13%* =
       1.16 *  18.92%*        1.15 *  19.62%*
Amean     8        1.43 (   0.00%)        1.17 *  18.46%*        1.16 *  19=
.16%*        1.16 *  18.96%*        1.17 *  18.46%*        1.18 *  17.86%* =
       1.15 *  19.36%*        1.16 *  19.06%*
Stddev    1        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (  22=
.54%)        0.01 (  -9.54%)        0.01 (-119.09%)        0.01 ( -67.33%) =
       0.01 (-149.00%)        0.01 ( -84.39%)
Stddev    3        0.01 (   0.00%)        0.01 (  12.29%)        0.02 (-105=
.69%)        0.01 (   0.00%)        0.01 (   0.00%)        0.05 (-515.82%) =
       0.01 ( -27.10%)        0.01 ( -41.42%)
Stddev    5        0.00 (   0.00%)        0.04 (-700.00%)        0.01 ( -61=
.25%)        0.01 ( -54.92%)        0.04 (-717.31%)        0.01 ( -84.39%) =
       0.01 ( -61.25%)        0.01 ( -18.32%)
Stddev    7        0.01 (   0.00%)        0.04 (-390.68%)        0.01 (   3=
.92%)        0.00 (  51.96%)        0.04 (-366.58%)        0.01 (   0.00%) =
       0.02 (-151.15%)        0.01 (   3.92%)
Stddev    8        0.00 (   0.00%)        0.00 ( -29.10%)        0.01 (-151=
.66%)        0.02 (-383.05%)        0.05 (-1100.00%)        0.01 (-108.17%)=
        0.01 ( -41.42%)        0.01 (-138.05%)
                                  v                      v                 =
  VMx2                   VMx2                   VMx2                   VMx2=
                   VMx2                   VMx2
                            VMx2-HT              VMx2-noHT                 =
    HT                   noHT                 csc-HT        csc_stallfix-HT=
             csc_tim-HT        csc_vruntime-HT
Amean     1         1.16 (   0.00%)        1.22 *  -5.80%*        1.54 * -3=
2.84%*        1.22 *  -5.31%*        2.83 (-144.32%)        1.35 * -16.42%*=
        1.69 * -46.30%*        1.35 * -16.91%*
Amean     3         1.16 (   0.00%)        1.24 *  -6.90%*        1.56 * -3=
4.11%*        1.24 *  -6.53%*        1.89 * -63.05%*        1.95 * -68.35%*=
        1.67 * -43.84%*        1.33 * -14.41%*
Amean     5         1.17 (   0.00%)        1.21 *  -3.79%*        1.52 * -3=
0.48%*        1.23 *  -5.75%*        1.43 * -22.89%*        1.85 ( -58.51%)=
        1.71 * -46.88%*        1.35 * -15.91%*
Amean     7         1.15 (   0.00%)        1.23 *  -6.81%*        1.54 * -3=
3.29%*        1.24 *  -7.05%*        1.68 * -45.79%*        1.39 * -20.79%*=
        2.09 * -80.69%*        1.30 * -12.62%*
Amean     12        1.16 (   0.00%)        1.25 *  -7.25%*        1.69 * -4=
5.09%*        1.22 *  -5.28%*        1.72 * -47.54%*        1.52 * -31.08%*=
        2.08 * -78.87%*        1.32 * -13.14%*
Amean     16        1.16 (   0.00%)        1.23 *  -6.14%*        1.68 * -4=
4.23%*        1.22 *  -4.67%*        1.80 * -54.91%*        1.37 * -17.44%*=
        2.18 * -87.10%*        1.28 *  -9.95%*
Stddev    1         0.01 (   0.00%)        0.05 (-569.58%)        0.14 (-16=
93.97%)        0.02 (-169.26%)        3.19 (-42121.82%)        0.25 (-3271.=
57%)        0.26 (-3362.06%)        0.09 (-1072.60%)
Stddev    3         0.01 (   0.00%)        0.06 (-664.85%)        0.06 (-63=
0.95%)        0.03 (-259.56%)        0.84 (-10177.51%)        0.98 (-11852.=
56%)        0.45 (-5404.28%)        0.08 (-845.29%)
Stddev    5         0.00 (   0.00%)        0.02 (-393.96%)        0.17 (-33=
71.31%)        0.07 (-1423.81%)        0.32 (-6361.11%)        1.04 (-21129=
.08%)        0.22 (-4383.53%)        0.06 (-1033.14%)
Stddev    7         0.01 (   0.00%)        0.07 (-1234.79%)        0.20 (-3=
727.10%)        0.08 (-1483.25%)        0.57 (-10594.70%)        0.19 (-345=
5.98%)        0.30 (-5454.88%)        0.08 (-1400.56%)
Stddev    12        0.00 (   0.00%)        0.08 (-1641.84%)        0.16 (-3=
078.68%)        0.03 (-524.50%)        0.50 (-10161.87%)        0.08 (-1634=
.36%)        0.32 (-6423.80%)        0.07 (-1232.67%)
Stddev    16        0.00 (   0.00%)        0.05 (-996.36%)        0.20 (-39=
58.82%)        0.06 (-1045.43%)        0.60 (-12116.06%)        0.23 (-4642=
.99%)        0.23 (-4594.04%)        0.05 (-842.34%)

This is all quite bizarre. Judging from these numbers, the benchmark
seems to be no sensitive to HT at all (while, e.g., sysbenchcpu was),
when on baremetal. In VMs, at least in most cases, things are
significantly *faster* with HT off. Which I know is something that can
happen, I just was not expecting it from this workload.

Also, core scheduling is a total disaster on baremetal. And its
behavior in VM is an anti-pattern too.

So, I guess I'll go trying to see if I did something wrong when
configuring or running this particular benchmark. If that is not the
case, then core scheduling has a serious issue when dealing with
threads instead than with processes, I would say.

--=20
Dario Faggioli, Ph.D
http://about.me/dario.faggioli
Virtualization Software Engineer
SUSE Labs, SUSE https://www.suse.com/
-------------------------------------------------------------------
<<This happens because _I_ choose it to happen!>> (Raistlin Majere)


--=-RwOX30FLRoOswSa3sgcf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEES5ssOj3Vhr0WPnOLFkJ4iaW4c+4FAl24A8wACgkQFkJ4iaW4
c+6OEhAAjOuXmCdWnpoDKrqGSoAB/9GRpROpzbj+ec/Sb6zeb0PSr3JWoo5Lrx6H
O79chza8kEQl6PaxTOqBDBDUwhuqMQy45PEzztdvkWIIvX/3N6rZW+tOgMWsUCuU
6Oh5Xb9W2z1FrUkL/unRNGGyq5dZDfhAyvvx9xA5DZKthI1vd4N/GSMvwXU4i+mw
9LI8i5hJ7IMImM5dcK8gQ82G8+PmbBcmA2MvfJcahP4B6ZQDfND1lLIHJXI+w5M2
CofCPpG+0uZt4gdOVTQOhagP6JJk7Z5HFdckQ0KNL7ux4PwHVPRyRe1wnhj0Nc0B
Tal6En43nacDH97WcfoBn1Fy7q2Pj4ibXi2A8jWmRMTxayN4ImKLZnBvwmo+r6OM
C39VOi/nvJcUWLU8xnodky5qIreYq+5QwNGv37oyLmBTM4TgwbOQSfir8IHpI5Ue
/khnhtHM9RmIXGAcUgBGMGkHK7d+9JfC2DZV4DnvdSRNcTruCqcLkiGrlu6yzOaw
uUdMS39ab3DTGmfDDr7ZgtnXlQ07ABXJbtto22w6gX+Y2rIDhVi/5eMnO2+haiAn
3IwVSCyPmlsvkR91yDjK3NMupidF60mgFR+trddxvktBdRS1u5TaOaflEeGkdIfi
tPuzU1Dl7JxNfzXYjICtZnPmpba02mCTbOjozqZGiGrsfGeZbfE=
=ZX3Z
-----END PGP SIGNATURE-----

--=-RwOX30FLRoOswSa3sgcf--


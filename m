Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C2CCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C5B20717
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731827AbfJ2JRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:17:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:40260 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729951AbfJ2JRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:17:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B2397B1BB;
        Tue, 29 Oct 2019 09:17:27 +0000 (UTC)
Message-ID: <f6b227853c79d7acd2d5cc678c5b24fb631ae483.camel@suse.com>
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
Date:   Tue, 29 Oct 2019 10:17:26 +0100
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
        protocol="application/pgp-signature"; boundary="=-sND2/ii71iR1zNjoxOyf"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sND2/ii71iR1zNjoxOyf
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
SYSBENCHCPU
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

http://xenbits.xen.org/people/dariof/benchmarks/results/linux/core-sched/mm=
tests/boxes/wayrath/coresched-email-4_sysbenchcpu.txt

                                  v                      v                 =
    BM                     BM                     BM                     BM=
                     BM                     BM
                              BM-HT                BM-noHT                 =
    HT                   noHT                 csc-HT        csc_stallfix-HT=
             csc_tim-HT        csc_vruntime-HT
Amean     1        22.55 (   0.00%)       22.55 *  -0.03%*       22.55 (   =
0.00%)       22.55 (  -0.02%)       22.56 *  -0.04%*       22.56 *  -0.03%*=
       22.55 (   0.01%)       22.55 (  -0.03%)
Amean     3         7.68 (   0.00%)        7.69 *  -0.07%*        7.68 (  -=
0.02%)        7.69 *  -0.09%*        7.69 *  -0.07%*        7.68 (  -0.02%)=
        7.68 (  -0.02%)        7.68 (  -0.02%)
Amean     5         4.80 (   0.00%)        5.79 * -20.64%*        4.80 (   =
0.00%)        5.79 * -20.73%*        4.81 *  -0.24%*        4.80 *  -0.18%*=
        4.81 *  -0.24%*        4.81 *  -0.24%*
Amean     7         3.59 (   0.00%)        5.79 * -61.24%*        3.59 (   =
0.00%)        5.79 * -61.20%*        3.59 (  -0.08%)        3.60 *  -0.16%*=
        3.62 *  -0.92%*        3.61 *  -0.52%*
Amean     12        3.18 (   0.00%)        5.79 * -81.79%*        3.19 (  -=
0.13%)        5.79 * -81.92%*        3.20 (  -0.49%)        3.19 *  -0.27%*=
        3.27 *  -2.78%*        3.41 *  -7.04%*
Amean     16        3.19 (   0.00%)        5.79 * -81.29%*        3.20 (  -=
0.13%)        5.79 * -81.38%*        3.24 (  -1.52%)        3.20 (  -0.31%)=
        3.27 *  -2.51%*        3.40 *  -6.40%*
Stddev    1         0.00 (   0.00%)        0.01 ( -41.42%)        0.01 ( -8=
2.57%)        0.01 (-194.39%)        0.01 ( -82.57%)        0.01 ( -41.42%)=
        0.01 (-158.20%)        0.01 (-269.68%)
Stddev    3         0.00 (   0.00%)        0.01 ( -99.00%)        0.00 ( -9=
9.00%)        0.00 ( -99.00%)        0.01 ( -99.00%)        0.00 ( -99.00%)=
        0.00 ( -99.00%)        0.00 ( -99.00%)
Stddev    5         0.01 (   0.00%)        0.02 (-302.08%)        0.01 (   =
0.00%)        0.02 (-258.24%)        0.00 (   8.71%)        0.01 (  -0.00%)=
        0.01 ( -41.42%)        0.00 (   8.71%)
Stddev    7         0.00 (   0.00%)        0.02 ( -99.00%)        0.00 (   =
0.00%)        0.02 ( -99.00%)        0.00 ( -99.00%)        0.01 ( -99.00%)=
        0.01 ( -99.00%)        0.01 ( -99.00%)
Stddev    12        0.01 (   0.00%)        0.02 (-125.32%)        0.01 ( -5=
4.42%)        0.02 (-103.81%)        0.03 (-321.54%)        0.01 ( -20.89%)=
        0.03 (-300.00%)        0.03 (-330.56%)
Stddev    16        0.01 (   0.00%)        0.02 (  -3.28%)        0.01 (   =
4.55%)        0.02 ( -44.53%)        0.10 (-591.05%)        0.02 ( -21.11%)=
        0.02 ( -44.53%)        0.04 (-145.85%)
                                  v                      v                 =
    VM                     VM                     VM                     VM=
                     VM                     VM
                              VM-HT                VM-noHT                 =
    HT                   noHT                 csc-HT        csc_stallfix-HT=
             csc_tim-HT        csc_vruntime-HT
Amean     1        24.38 (   0.00%)       22.57 *   7.41%*       22.56 *   =
7.45%*       22.56 *   7.44%*       22.56 *   7.44%*       22.94 *   5.91%*=
       22.56 *   7.44%*       22.57 *   7.43%*
Amean     3         8.12 (   0.00%)        7.70 *   5.21%*        7.68 *   =
5.45%*        7.68 *   5.40%*        7.69 *   5.36%*        7.72 *   4.99%*=
        7.68 *   5.43%*        7.68 *   5.40%*
Amean     5         4.96 (   0.00%)        5.85 * -17.88%*        4.79 *   =
3.43%*        5.85 * -17.91%*        4.81 *   3.02%*        5.09 *  -2.68%*=
        4.82 *   2.94%*        4.80 *   3.25%*
Amean     7         3.62 (   0.00%)        5.85 * -61.72%*        3.59 *   =
0.91%*        5.87 * -62.04%*        3.69 (  -1.82%)        3.94 *  -8.76%*=
        3.62 (   0.12%)        3.60 *   0.59%*
Amean     12        3.18 (   0.00%)        5.89 * -84.93%*        3.19 (  -=
0.09%)        5.83 * -83.18%*        3.26 *  -2.51%*        3.40 *  -6.64%*=
        3.28 *  -3.10%*        3.31 *  -3.86%*
Amean     16        3.18 (   0.00%)        5.86 * -83.89%*        3.18 (   =
0.04%)        5.85 * -83.85%*        3.28 *  -3.10%*        3.45 *  -8.30%*=
        3.29 *  -3.28%*        3.31 *  -3.90%*
Stddev    1         0.02 (   0.00%)        0.01 (  47.21%)        0.01 (  6=
6.12%)        0.01 (  53.84%)        0.01 (  55.65%)        0.19 (-1012.08%=
)        0.01 (  53.84%)        0.01 (  53.84%)
Stddev    3         0.00 (   0.00%)        0.02 (-254.96%)        0.00 ( 10=
0.00%)        0.01 ( -61.25%)        0.00 (   0.00%)        0.06 (-1116.55%=
)        0.00 (  22.54%)        0.01 (  -9.54%)
Stddev    5         0.00 (   0.00%)        0.07 (-1637.81%)        0.00 (  =
-0.00%)        0.06 (-1587.21%)        0.01 (-255.90%)        0.18 (-4785.3=
5%)        0.01 (-236.65%)        0.01 ( -52.75%)
Stddev    7         0.00 (   0.00%)        0.10 (-20807867647333972.00%)   =
     0.01 (-1575931584692200.00%)        0.08 (-16887732666966734.00%)     =
   0.15 (-30988869061711636.00%)        0.12 (-24303774169159900.00%)      =
  0.01 (-1640281598669292.00%)        0.01 (-2228703820443910.00%)
Stddev    12        0.01 (   0.00%)        0.12 (-2069.49%)        0.01 ( -=
41.42%)        0.08 (-1441.64%)        0.08 (-1396.11%)        0.09 (-1516.=
07%)        0.03 (-458.27%)        0.03 (-403.32%)
Stddev    16        0.01 (   0.00%)        0.07 (-1295.23%)        0.00 (  =
 8.71%)        0.07 (-1235.42%)        0.11 (-1867.23%)        0.26 (-4790.=
98%)        0.04 (-711.38%)        0.05 (-800.00%)
                                 v                      v                  =
   VM                     VM                     VM                     VM =
                    VM                     VM
                          VM-v4-HT             VM-v4-noHT                  =
v4-HT                v4-noHT              v4-csc-HT     v4-csc_stallfix-HT =
         v4-csc_tim-HT     v4-csc_vruntime-HT
Amean     1       24.37 (   0.00%)       22.76 *   6.62%*       22.56 *   7=
.43%*       22.57 *   7.41%*       22.57 *   7.41%*       22.86 *   6.21%* =
      22.56 *   7.44%*       22.56 *   7.44%*
Amean     3        8.12 (   0.00%)        7.73 *   4.82%*        7.68 *   5=
.40%*        7.68 *   5.40%*        7.69 *   5.33%*        7.70 *   5.24%* =
       7.68 *   5.42%*        7.68 *   5.38%*
Amean     5        6.11 (   0.00%)        5.90 *   3.53%*        5.79 *   5=
.35%*        5.78 *   5.51%*        5.79 *   5.33%*        6.07 *   0.77%* =
       5.78 *   5.44%*        5.77 *   5.58%*
Amean     7        6.11 (   0.00%)        5.92 *   3.11%*        5.79 *   5=
.33%*        5.77 *   5.59%*        5.80 *   5.16%*        6.07 *   0.70%* =
       5.78 *   5.42%*        5.77 *   5.54%*
Amean     8        6.11 (   0.00%)        5.91 *   3.30%*        5.78 *   5=
.33%*        5.77 *   5.52%*        5.81 *   4.93%*        6.09 (   0.28%) =
       5.78 *   5.45%*        5.77 *   5.52%*
Stddev    1        0.01 (   0.00%)        0.01 (  27.45%)        0.01 (  27=
.45%)        0.01 (  17.28%)        0.01 ( -57.28%)        0.08 (-765.72%) =
       0.01 (  39.30%)        0.01 (  27.45%)
Stddev    3        0.00 (   0.00%)        0.03 (-616.47%)        0.00 ( -29=
.10%)        0.00 ( -29.10%)        0.01 (-138.05%)        0.01 (-108.17%) =
       0.00 (   0.00%)        0.01 ( -41.42%)
Stddev    5        0.01 (   0.00%)        0.03 (-336.77%)        0.02 (-128=
.71%)        0.01 ( -75.41%)        0.01 ( -70.97%)        0.02 (-128.71%) =
       0.01 ( -54.42%)        0.01 ( -59.33%)
Stddev    7        0.01 (   0.00%)        0.04 (-214.79%)        0.02 ( -82=
.57%)        0.01 (   3.08%)        0.01 ( -10.10%)        0.02 ( -52.75%) =
       0.01 (   3.08%)        0.01 (  -1.50%)
Stddev    8        0.01 (   0.00%)        0.04 (-329.84%)        0.02 (-122=
.54%)        0.01 ( -11.27%)        0.03 (-228.78%)        0.07 (-649.92%) =
       0.01 ( -38.01%)        0.01 ( -11.27%)
                                  v                      v                 =
  VMx2                   VMx2                   VMx2                   VMx2=
                   VMx2                   VMx2
                            VMx2-HT              VMx2-noHT                 =
    HT                   noHT                 csc-HT        csc_stallfix-HT=
             csc_tim-HT        csc_vruntime-HT
Amean     1        22.58 (   0.00%)       23.41 *  -3.67%*       25.22 * -1=
1.70%*       23.36 *  -3.48%*       31.57 * -39.84%*       29.30 * -29.78%*=
       31.82 * -40.93%*       25.60 * -13.38%*
Amean     3         7.69 (   0.00%)       11.03 * -43.47%*        8.81 * -1=
4.66%*       11.19 * -45.60%*        8.64 * -12.34%*       10.68 * -38.88%*=
       10.10 * -31.43%*        9.05 * -17.75%*
Amean     5         4.80 (   0.00%)       11.04 *-130.24%*        5.66 * -1=
7.96%*       11.35 *-136.61%*        6.66 * -38.81%*        7.92 * -65.18%*=
        6.27 * -30.65%*        6.61 * -37.83%*
Amean     7         3.58 (   0.00%)       10.94 *-205.34%*        5.44 * -5=
1.79%*       11.53 *-221.93%*        6.39 * -78.35%*        6.23 * -73.96%*=
        5.65 * -57.70%*        6.07 * -69.30%*
Amean     12        3.18 (   0.00%)       10.95 *-243.74%*        5.52 * -7=
3.44%*       11.31 *-255.09%*        7.19 *-125.93%*        9.43 *-196.05%*=
        5.62 * -76.54%*        6.09 * -91.16%*
Amean     16        3.18 (   0.00%)       11.10 *-248.65%*        5.43 * -7=
0.56%*       11.35 *-256.55%*        6.84 *-115.04%*        7.19 *-125.90%*=
        5.50 * -72.76%*        6.13 * -92.64%*
Stddev    1         0.01 (   0.00%)        0.14 (-1403.85%)        0.16 (-1=
575.99%)        0.09 (-866.82%)        1.41 (-14685.15%)        1.84 (-1927=
9.11%)        1.96 (-20463.33%)        0.38 (-3929.30%)
Stddev    3         0.00 (   0.00%)        0.51 (-10380.94%)        0.14 (-=
2749.21%)        0.68 (-13757.63%)        0.30 (-6133.94%)        0.80 (-16=
343.24%)        0.12 (-2332.69%)        0.16 (-3086.85%)
Stddev    5         0.01 (   0.00%)        0.30 (-5443.92%)        0.23 (-4=
280.45%)        0.58 (-10722.66%)        0.21 (-3888.73%)        2.41 (-450=
40.69%)        0.12 (-2113.22%)        0.16 (-2867.88%)
Stddev    7         0.00 (   0.00%)        0.40 (-8009.13%)        0.08 (-1=
480.51%)        0.47 (-9518.94%)        1.04 (-21241.56%)        0.51 (-104=
09.80%)        0.22 (-4319.28%)        0.25 (-5017.81%)
Stddev    12        0.01 (   0.00%)        0.53 (-9750.38%)        0.16 (-2=
879.09%)        0.66 (-12313.77%)        1.29 (-24020.36%)        3.97 (-74=
080.08%)        0.25 (-4570.12%)        0.32 (-5817.77%)
Stddev    16        0.00 (   0.00%)        0.46 (-9428.17%)        0.25 (-5=
124.17%)        0.75 (-15173.77%)        0.78 (-15851.43%)        1.38 (-28=
142.45%)        0.35 (-7094.72%)        0.21 (-4230.36%)

This is even better than kernbench! :-)

Basically, both on baremetal and in VMs, noHT causes some -81.29%. With
core scheduling, the worst we get is -6.40%.

And that's in the not Virt-overcommitted case. In such case, noHT
brings us down to -248.65% (i.e., we are ~250% slower, it's not that
we're going back in time :-P). Core scheduling contains the damage to
either -72.76% (Tim's patches) or -92.64% (vruntime). While plain v3
is, again, worse than both.

Overhead looks similar to other cases already discussed.

--=20
Dario Faggioli, Ph.D
http://about.me/dario.faggioli
Virtualization Software Engineer
SUSE Labs, SUSE https://www.suse.com/
-------------------------------------------------------------------
<<This happens because _I_ choose it to happen!>> (Raistlin Majere)


--=-sND2/ii71iR1zNjoxOyf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEES5ssOj3Vhr0WPnOLFkJ4iaW4c+4FAl24A6YACgkQFkJ4iaW4
c+6AEg//RNsSiiH1DYknn6Kd2syN4kxOw7tI9hJ+klnHk/Zpu2Zjpm7Ec2shdnU4
Gd51cHnD0MHJG6lZbn+2r/xounV0PvoF01yjYx//wF9TTZRFvT/48+vcKOpFEOL6
5Yy9HwGTrPyn3ZO+Xv9FFE5oGwTybUFlPvzNpcBDO7wniA62O20uj3L74+EbsN8m
Lqekt+8ofeo+Z5HQjzCBktz5o5u7LRP2HalMaHH1AkFMULIIMWFTLZH9958GdRk5
MnuJYjx1tn1zt87kdZHSMzICTN2R6+iS+B6xMJ57ZQjbu4k4qzrwRtTAt7Cu8kqY
6CXYQYJU69jzdrMPavo7RCeJE84EjZTz3rhiY7TaVP4UswCNi/cHBjkWP/MYafP6
iQxAL11VSH6p9wVU+Pkr/j6+azjx7FHdnhlgiMxHeK5B6dyXPIGxJJAagOcbc9xP
BcYd8LAMEAUn+z3k1Ntrh7TsKwz3TSbu6LyANCTRvLSPS2yAdyz5ckc3pqFrQuep
8JDKMOVQ+B+q9o/VQXi7uQC2/QaIZjR81im76RCreOEXdlRzlTnKBeLN2k1Tfcql
s6BPJnDsFZKWocYkVPKDAA3fyrGOIbo7Y92wJlJN37QP/MvguDox1jKBwlTKCrgj
UCnuwGeblPVqWOMyUgZZnObOkoCHTks20dvhyhAHG816KEDAndI=
=ZC8U
-----END PGP SIGNATURE-----

--=-sND2/ii71iR1zNjoxOyf--


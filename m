Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055F6CA9EC3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4F3020830
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732270AbfJ2JTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:19:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:41138 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732215AbfJ2JTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:19:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A38DAB31B;
        Tue, 29 Oct 2019 09:19:38 +0000 (UTC)
Message-ID: <4c4c002302dbbb736f9301a7eb43916ab7fbb288.camel@suse.com>
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
Date:   Tue, 29 Oct 2019 10:19:36 +0100
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
        protocol="application/pgp-signature"; boundary="=-QZ2Sx9AbyhnnxfJkgIdN"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QZ2Sx9AbyhnnxfJkgIdN
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
MEMCACHED/MUTILATE
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

http://xenbits.xen.org/people/dariof/benchmarks/results/linux/core-sched/mm=
tests/boxes/wayrath/coresched-email-7_mutilate.txt

                                 v                      v                  =
   BM                     BM                     BM                     BM =
                    BM                     BM
                             BM-HT                BM-noHT                  =
   HT                   noHT                 csc-HT        csc_stallfix-HT =
            csc_tim-HT        csc_vruntime-HT
Hmean     1    60672.24 (   0.00%)    60476.27 (  -0.32%)    61303.65 (   1=
.04%)    61353.05 (   1.12%)    57026.54 *  -6.01%*    56874.19 *  -6.26%* =
   56781.04 *  -6.41%*    56642.48 *  -6.64%*
Hmean     3   149695.40 (   0.00%)   131084.79 * -12.43%*   150802.12 (   0=
.74%)   131058.25 * -12.45%*   138260.22 *  -7.64%*   138002.31 *  -7.81%* =
  136907.04 *  -8.54%*   138317.36 *  -7.60%*
Hmean     5   198656.98 (   0.00%)   181719.88 *  -8.53%*   196429.59 (  -1=
.12%)   186468.57 *  -6.14%*   171612.43 * -13.61%*   176464.24 * -11.17%* =
  162578.64 * -18.16%*   170196.51 * -14.33%*
Hmean     7   180858.07 (   0.00%)   187088.17 *   3.44%*   181549.92 (   0=
.38%)   189813.97 *   4.95%*   166898.82 *  -7.72%*   164724.43 *  -8.92%* =
  143102.58 * -20.88%*   128900.19 * -28.73%*
Hmean     8   157176.91 (   0.00%)   190533.25 *  21.22%*   159795.04 (   1=
.67%)   188249.31 *  19.77%*   168399.58 *   7.14%*   169700.06 *   7.97%* =
  137152.66 * -12.74%*   123355.03 * -21.52%*
Stddev    1      551.36 (   0.00%)       52.18 (  90.54%)      306.31 (  44=
.44%)      385.01 (  30.17%)      353.37 (  35.91%)      350.76 (  36.38%) =
     476.56 (  13.57%)      279.80 (  49.25%)
Stddev    3     1206.26 (   0.00%)     2368.98 ( -96.39%)      652.07 (  45=
.94%)     1300.67 (  -7.83%)     1849.15 ( -53.30%)     2434.55 (-101.83%) =
    1063.43 (  11.84%)     1825.98 ( -51.38%)
Stddev    5     3843.30 (   0.00%)      122.92 (  96.80%)     2883.77 (  24=
.97%)      481.11 (  87.48%)     4099.56 (  -6.67%)     4424.91 ( -15.13%) =
     596.25 (  84.49%)     1345.78 (  64.98%)
Stddev    7     2990.97 (   0.00%)     1645.75 (  44.98%)     6567.23 (-119=
.57%)     5422.57 ( -81.30%)     3191.68 (  -6.71%)     2438.38 (  18.48%) =
    1211.94 (  59.48%)      705.34 (  76.42%)
Stddev    8     3637.12 (   0.00%)     1490.36 (  59.02%)     3386.42 (   6=
.89%)     2437.43 (  32.98%)     1056.02 (  70.97%)     1391.07 (  61.75%) =
    1488.57 (  59.07%)      774.85 (  78.70%)
                                 v                      v                  =
   VM                     VM                     VM                     VM =
                    VM                     VM
                             VM-HT                VM-noHT                  =
   HT                   noHT                 csc-HT        csc_stallfix-HT =
            csc_tim-HT        csc_vruntime-HT
Hmean     1    42580.67 (   0.00%)    53440.15 *  25.50%*    54293.03 *  27=
.51%*    52771.89 *  23.93%*    53689.85 *  26.09%*    53804.35 *  26.36%* =
   53730.74 *  26.19%*    53902.75 *  26.59%*
Hmean     3   115732.63 (   0.00%)    70651.66 * -38.95%*   125537.18 *   8=
.47%*    70738.43 * -38.88%*   126041.27 *   8.91%*   126387.30 *   9.21%* =
  127285.87 *   9.98%*   126816.33 *   9.58%*
Hmean     5   176633.72 (   0.00%)    22349.68 * -87.35%*   182113.02 *   3=
.10%*    19850.93 * -88.76%*   137910.40 * -21.92%*   180934.44 *   2.43%* =
  175009.60 (  -0.92%)   174758.21 (  -1.06%)
Hmean     7   182512.86 (   0.00%)    48728.14 * -73.30%*   186272.46 *   2=
.06%*    49015.69 * -73.14%*   157398.75 * -13.76%*   184989.00 (   1.36%) =
  172307.74 *  -5.59%*   173203.24 *  -5.10%*
Hmean     8   192244.37 (   0.00%)    65283.21 * -66.04%*   195435.08 (   1=
.66%)    63616.87 * -66.91%*   176288.98 *  -8.30%*   192413.50 (   0.09%) =
  188699.07 (  -1.84%)   185870.91 *  -3.32%*
Stddev    1      337.79 (   0.00%)      523.30 ( -54.92%)       22.90 (  93=
.22%)      353.55 (  -4.67%)      196.63 (  41.79%)      470.55 ( -39.30%) =
     414.86 ( -22.82%)      190.50 (  43.60%)
Stddev    3     1945.52 (   0.00%)      420.36 (  78.39%)     1365.07 (  29=
.84%)      954.82 (  50.92%)     1136.12 (  41.60%)     1674.98 (  13.91%) =
    1539.07 (  20.89%)     1129.09 (  41.96%)
Stddev    5      964.02 (   0.00%)     2121.27 (-120.05%)     3232.44 (-235=
.31%)     2284.37 (-136.96%)     8374.66 (-768.73%)     3156.06 (-227.39%) =
     948.17 (   1.64%)     2700.91 (-180.17%)
Stddev    7     1028.64 (   0.00%)     1740.95 ( -69.25%)     2860.04 (-178=
.04%)     3366.68 (-227.29%)     3360.79 (-226.72%)     4762.47 (-362.99%) =
    2968.56 (-188.59%)     1429.88 ( -39.01%)
Stddev    8     3794.15 (   0.00%)     1893.82 (  50.09%)      565.06 (  85=
.11%)      893.04 (  76.46%)     3201.43 (  15.62%)     1931.66 (  49.09%) =
     360.93 (  90.49%)     1945.37 (  48.73%)
                                 v                      v                  =
   VM                     VM                     VM                     VM =
                    VM                     VM
                          VM-v4-HT             VM-v4-noHT                  =
v4-HT                v4-noHT              v4-csc-HT     v4-csc_stallfix-HT =
         v4-csc_tim-HT     v4-csc_vruntime-HT
Hmean     1    44216.52 (   0.00%)    53968.94 *  22.06%*    54078.28 *  22=
.30%*    54290.57 *  22.78%*    53552.08 *  21.11%*    51342.78 *  16.12%* =
   53967.09 *  22.05%*    53790.48 *  21.65%*
Hmean     3   105120.19 (   0.00%)   120769.59 *  14.89%*   121460.04 *  15=
.54%*   117410.09 *  11.69%*   120296.87 *  14.44%*   109089.25 (   3.78%) =
  123133.70 *  17.14%*   123614.82 *  17.59%*
Hmean     4   144618.05 (   0.00%)   167039.86 *  15.50%*   178922.55 *  23=
.72%*   175641.36 *  21.45%*   185338.19 *  28.16%*   148152.02 (   2.44%) =
  179709.39 *  24.26%*   179754.74 *  24.30%*
Stddev    1      144.30 (   0.00%)      101.12 (  29.93%)      420.02 (-191=
.08%)      294.43 (-104.04%)      300.29 (-108.10%)      330.58 (-129.10%) =
     353.69 (-145.11%)      142.58 (   1.19%)
Stddev    3     3300.71 (   0.00%)      905.78 (  72.56%)     2537.34 (  23=
.13%)     3289.78 (   0.33%)     1113.35 (  66.27%)     2685.20 (  18.65%) =
    8425.99 (-155.28%)     2280.72 (  30.90%)
Stddev    4     1828.49 (   0.00%)     9851.42 (-438.77%)     2779.22 ( -52=
.00%)     3312.07 ( -81.14%)     7392.50 (-304.30%)     6090.54 (-233.09%) =
    3320.77 ( -81.61%)     4836.89 (-164.53%)
                                 v                      v                  =
 VMx2                   VMx2                   VMx2                   VMx2 =
                  VMx2                   VMx2
                           VMx2-HT              VMx2-noHT                  =
   HT                   noHT                 csc-HT        csc_stallfix-HT =
            csc_tim-HT        csc_vruntime-HT
Hmean     1    53045.85 (   0.00%)    35310.51 * -33.43%*    38949.82 * -26=
.57%*    35500.55 * -33.08%*    49350.06 *  -6.97%*    35372.44 * -33.32%* =
   40556.30 * -23.54%*    42238.57 * -20.37%*
Hmean     3   124865.12 (   0.00%)     7997.67 * -93.59%*    57204.70 * -54=
.19%*     8373.67 * -93.29%*    56781.47 * -54.53%*    38892.18 * -68.85%* =
   51207.79 * -58.99%*    46151.33 * -63.04%*
Hmean     5   178848.31 (   0.00%)     4984.40 * -97.21%*    31431.45 * -82=
.43%*     5101.29 * -97.15%*    41204.02 * -76.96%*    24592.26 * -86.25%* =
   33541.47 * -81.25%*    28762.54 * -83.92%*
Hmean     7   187708.49 (   0.00%)    12945.53 * -93.10%*    57937.51 * -69=
.13%*    12898.91 * -93.13%*    89180.74 * -52.49%*    48390.34 * -74.22%* =
   54198.33 * -71.13%*    50261.68 * -73.22%*
Hmean     8   199929.38 (   0.00%)    27516.10 * -86.24%*    77578.88 * -61=
.20%*    27608.20 * -86.19%*   117871.45 * -41.04%*    65719.85 * -67.13%* =
   76669.78 * -61.65%*    67983.03 * -66.00%*
Stddev    1      404.57 (   0.00%)      708.20 ( -75.05%)      102.16 (  74=
.75%)      258.18 (  36.19%)      132.11 (  67.35%)     1145.71 (-183.19%) =
     740.95 ( -83.14%)       91.67 (  77.34%)
Stddev    3     1867.11 (   0.00%)      729.15 (  60.95%)     2529.52 ( -35=
.48%)     1212.31 (  35.07%)     1765.46 (   5.44%)     2698.45 ( -44.53%) =
     376.23 (  79.85%)     2108.90 ( -12.95%)
Stddev    5     1556.91 (   0.00%)      193.16 (  87.59%)     3307.78 (-112=
.46%)      207.87 (  86.65%)     1401.20 (  10.00%)     1945.52 ( -24.96%) =
    1821.44 ( -16.99%)     2166.87 ( -39.18%)
Stddev    7     3622.13 (   0.00%)     1690.01 (  53.34%)     5268.81 ( -45=
.46%)      690.12 (  80.95%)     8337.77 (-130.19%)     3737.07 (  -3.17%) =
    1900.15 (  47.54%)     3388.45 (   6.45%)
Stddev    8     1913.74 (   0.00%)     1460.07 (  23.71%)     2068.35 (  -8=
.08%)     1750.51 (   8.53%)     4229.08 (-120.99%)     3477.66 ( -81.72%) =
    3318.68 ( -73.41%)     1338.76 (  30.04%)

Mutilate brings us back where core scheduling does bad on baremetal,
but fine in VMs. The benchmark seems to be much more sensitive to
HyperThreading when run inside virtual machines, and core scheduling
guarantees better results than disabling hyperthreading, in such cases.
Interestingly, this time the thing is more evedint in the *non*
overcommitted scenario.

In fact, with one 8 vCPUs VM, v-VM-noHT is -87.35% and VM-csc_vruntime-
HT is only -1.06%, which is really good. In the overcommitted case, v-
VMx2-noHT reaches -97.21% while VMx2-csc_vruntime-HT is -83.92%. So,
yeah, better, but not "as better" as before.

--=20
Dario Faggioli, Ph.D
http://about.me/dario.faggioli
Virtualization Software Engineer
SUSE Labs, SUSE https://www.suse.com/
-------------------------------------------------------------------
<<This happens because _I_ choose it to happen!>> (Raistlin Majere)


--=-QZ2Sx9AbyhnnxfJkgIdN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEES5ssOj3Vhr0WPnOLFkJ4iaW4c+4FAl24BCgACgkQFkJ4iaW4
c+6VOQ/9EgrOlgUgJuBR90ZKKHyOv1sHdw7cW5JwSgHngB9FhoZrw/cVI4bBLPgs
K6N8Rf1ne29cuiYUUPqXRVvyJ/kewNkMa6rs0xNNt6PZC58NgsyCwxYgpC+CxsXw
pgjSMf7azc6k2YB44T886I1W27wfSU8FGSTxb5Ihq8xkg6RRZsLj6Z6mBMoiRvg5
tY6odOMU/qhHQyeXRCxPDX48M8R7KbHxLyZ+uyYFfwQY5N4uh3zHhvE33w6ZfATj
9gZdGfYxu7s2D/MDNnbSaPVcws0Y9VRaZqI2E/ZLR5242NqgJd0rBnYqgPFlfqkm
LtV0GnjscRQJKLJMhbD9DRGlil9wIG3mu2OEQOtWAh5TsK+XbXQAjdrDWR6sZtD5
Bf97f0FACKPiPS/Vrl6hfdJxC8k9hl3IC4QRiq3lloZZsxzC+ESV/uu+VlVJW8RO
01SO0M8gd/bYrVuk/y+AJaduTK4yOKZDp3k1dno3z3I45y+8zx0OGO1q6+A4n5j/
K5Ku1j8qHipm4qr/hd7Cd4uPy6mjMFpiJwcZtL6uWN/L+eYV40IFV57Pl26Mj+G1
JxlG3YaMl6advnm+SEhKvn/JEUevc+rt84psUkU13lIQu0uOtKHVCwjnz3qSOlDD
xSn+jOthrd2C3fmC3gCYz1QyIMjEC9L4pye9ZML2bPkjhdLN+p4=
=5pf+
-----END PGP SIGNATURE-----

--=-QZ2Sx9AbyhnnxfJkgIdN--


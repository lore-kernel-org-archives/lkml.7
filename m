Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FA0CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3519020830
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731581AbfJ2JQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:16:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:39554 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729876AbfJ2JP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:15:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B3F7EAF6B;
        Tue, 29 Oct 2019 09:15:55 +0000 (UTC)
Message-ID: <f5db352d19a90a4ea08d5f8e4a73c96d35354b62.camel@suse.com>
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
Date:   Tue, 29 Oct 2019 10:15:53 +0100
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
        protocol="application/pgp-signature"; boundary="=-XbK6MDKfXOQ62Mn7nYyD"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XbK6MDKfXOQ62Mn7nYyD
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
HACKBENCH-PROCESS-PIPES
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

http://xenbits.xen.org/people/dariof/benchmarks/results/linux/core-sched/mm=
tests/boxes/wayrath/coresched-email-2_hackbench.txt

                                  v                      v                 =
    BM                     BM                     BM                     BM=
                     BM                     BM
                              BM-HT                BM-noHT                 =
    HT                   noHT                 csc-HT        csc_stallfix-HT=
             csc_tim-HT        csc_vruntime-HT
Amean     1       0.4372 (   0.00%)      0.6714 * -53.57%*      0.4242 (   =
2.97%)      0.6654 * -52.20%*      1.1748 *-168.71%*      1.1666 *-166.83%*=
      1.1496 *-162.95%*      1.3696 *-213.27%*
Amean     3       1.1466 (   0.00%)      2.0284 * -76.91%*      1.1700 (  -=
2.04%)      2.0320 * -77.22%*      6.8484 *-497.28%*      6.7128 *-485.45%*=
      6.8068 *-493.65%*      7.9702 *-595.12%*
Amean     5       2.0140 (   0.00%)      2.7834 * -38.20%*      2.0116 (   =
0.12%)      2.6688 * -32.51%*     11.9494 *-493.32%*     11.9450 *-493.10%*=
     12.0904 *-500.32%*     14.4190 *-615.94%*
Amean     7       2.5396 (   0.00%)      3.3064 * -30.19%*      2.6002 (  -=
2.39%)      2.9074 * -14.48%*     16.0142 *-530.58%*     16.3418 *-543.48%*=
     17.0896 *-572.92%*     20.2050 *-695.60%*
Amean     12      3.2930 (   0.00%)      2.9830 (   9.41%)      3.4226 (  -=
3.94%)      2.8522 (  13.39%)     28.1482 *-754.79%*     27.3916 *-731.81%*=
     28.5938 *-768.32%*     34.6184 *-951.27%*
Amean     18      3.9452 (   0.00%)      4.0806 (  -3.43%)      3.7950 (   =
3.81%)      3.8938 (   1.30%)     41.7120 *-957.28%*     42.1062 *-967.28%*=
     44.2136 *-1020.69%*     51.0200 *-1193.22%*
Amean     24      4.1618 (   0.00%)      4.8466 * -16.45%*      4.2258 (  -=
1.54%)      5.0720 * -21.87%*     56.8598 *-1266.23%*     57.3568 *-1278.17=
%*     61.2660 *-1372.10%*     68.2538 *-1540.01%*
Amean     30      4.7790 (   0.00%)      5.9726 * -24.98%*      4.8756 (  -=
2.02%)      5.9434 * -24.36%*     72.1602 *-1409.94%*     75.8036 *-1486.18=
%*     80.0066 *-1574.13%*     81.3768 *-1602.80%*
Amean     32      5.1680 (   0.00%)      6.6000 * -27.71%*      5.2004 (  -=
0.63%)      6.5490 * -26.72%*     78.1974 *-1413.11%*     82.9812 *-1505.67=
%*     87.7340 *-1597.64%*     85.6876 *-1558.04%*
Stddev    1       0.0173 (   0.00%)      0.0624 (-259.99%)      0.0129 (  2=
5.54%)      0.0451 (-160.36%)      0.0727 (-319.12%)      0.0954 (-450.05%)=
      0.0545 (-214.16%)      0.0960 (-453.74%)
Stddev    3       0.0471 (   0.00%)      0.3035 (-544.20%)      0.0547 ( -1=
6.12%)      0.2745 (-482.52%)      0.2029 (-330.60%)      0.1102 (-133.97%)=
      0.2391 (-407.38%)      0.1864 (-295.62%)
Stddev    5       0.1492 (   0.00%)      0.4178 (-180.05%)      0.1419 (   =
4.88%)      0.2569 ( -72.22%)      0.3878 (-159.96%)      0.2584 ( -73.22%)=
      0.4259 (-185.47%)      0.3340 (-123.89%)
Stddev    7       0.2077 (   0.00%)      0.2941 ( -41.59%)      0.2281 (  -=
9.85%)      0.2049 (   1.33%)      0.3922 ( -88.86%)      0.8178 (-293.78%)=
      0.4064 ( -95.67%)      0.6127 (-195.02%)
Stddev    12      0.5560 (   0.00%)      0.2038 (  63.34%)      0.2113 (  6=
2.00%)      0.2490 (  55.21%)      1.0797 ( -94.21%)      0.7564 ( -36.06%)=
      1.0225 ( -83.91%)      1.5233 (-174.01%)
Stddev    18      0.3556 (   0.00%)      0.3110 (  12.55%)      0.3054 (  1=
4.11%)      0.1265 (  64.43%)      1.0258 (-188.47%)      1.4386 (-304.53%)=
      1.1818 (-232.33%)      2.6710 (-651.08%)
Stddev    24      0.1844 (   0.00%)      0.1614 (  12.46%)      0.1135 (  3=
8.46%)      0.3679 ( -99.54%)      2.0997 (-1038.84%)      1.1493 (-523.36%=
)      0.5214 (-182.79%)      2.9229 (-1485.35%)
Stddev    30      0.1420 (   0.00%)      0.0875 (  38.37%)      0.1799 ( -2=
6.66%)      0.1076 (  24.26%)      4.5079 (-3073.51%)      1.5704 (-1005.58=
%)      1.4054 (-889.42%)      4.5743 (-3120.26%)
Stddev    32      0.2184 (   0.00%)      0.2427 ( -11.11%)      0.3143 ( -4=
3.92%)      0.3517 ( -61.01%)      3.7345 (-1609.81%)      1.3564 (-521.00%=
)      2.1822 (-899.11%)      4.0896 (-1772.40%)
                                  v                      v                 =
    VM                     VM                     VM                     VM=
                     VM                     VM
                              VM-HT                VM-noHT                 =
    HT                   noHT                 csc-HT        csc_stallfix-HT=
             csc_tim-HT        csc_vruntime-HT
Amean     1       0.6762 (   0.00%)      1.6824 *-148.80%*      0.6630 (   =
1.95%)      1.5706 *-132.27%*      0.6600 (   2.40%)      0.6514 (   3.67%)=
      0.6780 (  -0.27%)      0.6964 *  -2.99%*
Amean     3       1.7130 (   0.00%)      2.2806 * -33.13%*      1.8074 *  -=
5.51%*      2.1882 * -27.74%*      1.7992 (  -5.03%)      1.7896 *  -4.47%*=
      1.7760 (  -3.68%)      1.8264 *  -6.62%*
Amean     5       2.8688 (   0.00%)      2.8048 (   2.23%)      2.5880 *   =
9.79%*      2.8474 (   0.75%)      2.5486 *  11.16%*      2.7896 (   2.76%)=
      2.4402 *  14.94%*      2.6020 *   9.30%*
Amean     7       3.3432 (   0.00%)      3.3434 (  -0.01%)      3.4564 (  -=
3.39%)      3.4704 (  -3.80%)      3.2424 (   3.02%)      3.5620 (  -6.54%)=
      3.0352 (   9.21%)      3.0874 (   7.65%)
Amean     12      5.8936 (   0.00%)      4.9968 *  15.22%*      5.1560 *  1=
2.52%*      5.0670 *  14.03%*      4.2722 *  27.51%*      5.6570 (   4.01%)=
      4.8270 *  18.10%*      4.2514 *  27.86%*
Amean     18      6.3938 (   0.00%)      7.0542 ( -10.33%)      6.4900 (  -=
1.50%)      6.9682 (  -8.98%)      5.6478 (  11.67%)      7.4324 ( -16.24%)=
      6.3160 (   1.22%)      6.5124 (  -1.85%)
Amean     24      7.6278 (   0.00%)      9.5096 * -24.67%*      7.0062 *   =
8.15%*      9.0278 * -18.35%*      7.5650 (   0.82%)      8.2604 (  -8.29%)=
      8.5372 ( -11.92%)      7.7008 (  -0.96%)
Amean     30     10.5534 (   0.00%)     10.9456 (  -3.72%)     11.4470 (  -=
8.47%)     11.1330 (  -5.49%)      8.8486 (  16.15%)     10.8508 (  -2.82%)=
     12.6182 ( -19.57%)     10.5836 (  -0.29%)
Amean     32     11.6024 (   0.00%)     12.6052 (  -8.64%)     10.8236 (   =
6.71%)     11.2156 (   3.33%)      9.0654 *  21.87%*     11.5074 (   0.82%)=
     10.3592 (  10.72%)     11.7174 (  -0.99%)
Stddev    1       0.0143 (   0.00%)      0.3700 (-2480.08%)      0.0261 ( -=
82.29%)      0.1206 (-741.16%)      0.0444 (-209.74%)      0.0270 ( -88.42%=
)      0.0238 ( -65.73%)      0.0180 ( -25.17%)
Stddev    3       0.0473 (   0.00%)      0.1384 (-192.63%)      0.0739 ( -5=
6.38%)      0.0714 ( -51.01%)      0.0931 ( -96.94%)      0.0517 (  -9.28%)=
      0.0960 (-103.02%)      0.0553 ( -17.04%)
Stddev    5       0.1236 (   0.00%)      0.2251 ( -82.10%)      0.1607 ( -2=
9.98%)      0.1464 ( -18.41%)      0.1319 (  -6.69%)      0.1842 ( -48.96%)=
      0.0647 (  47.66%)      0.1977 ( -59.92%)
Stddev    7       0.3597 (   0.00%)      0.1105 (  69.27%)      0.2288 (  3=
6.38%)      0.1335 (  62.90%)      0.3131 (  12.94%)      0.2958 (  17.76%)=
      0.1581 (  56.05%)      0.2361 (  34.37%)
Stddev    12      0.4677 (   0.00%)      0.0846 (  81.91%)      0.6319 ( -3=
5.11%)      0.1526 (  67.37%)      0.3591 (  23.23%)      0.6898 ( -47.48%)=
      0.4853 (  -3.76%)      0.2963 (  36.64%)
Stddev    18      1.2289 (   0.00%)      0.1849 (  84.95%)      1.1160 (   =
9.18%)      0.2497 (  79.68%)      0.9843 (  19.90%)      0.9542 (  22.35%)=
      0.6621 (  46.12%)      0.7668 (  37.60%)
Stddev    24      0.5202 (   0.00%)      0.9344 ( -79.60%)      0.1940 (  6=
2.71%)      0.4706 (   9.53%)      0.8362 ( -60.73%)      1.0819 (-107.96%)=
      1.0229 ( -96.63%)      0.8881 ( -70.72%)
Stddev    30      2.1557 (   0.00%)      0.7984 (  62.96%)      1.2499 (  4=
2.02%)      0.9804 (  54.52%)      0.4846 (  77.52%)      1.2901 (  40.15%)=
      1.5532 (  27.95%)      1.2932 (  40.01%)
Stddev    32      2.2255 (   0.00%)      1.1321 (  49.13%)      2.2380 (  -=
0.56%)      0.2127 (  90.44%)      0.3654 (  83.58%)      1.5727 (  29.33%)=
      2.3291 (  -4.66%)      2.0936 (   5.93%)
                                  v                      v                 =
    VM                     VM                     VM                     VM=
                     VM                     VM
                           VM-v4-HT             VM-v4-noHT                 =
 v4-HT                v4-noHT              v4-csc-HT     v4-csc_stallfix-HT=
          v4-csc_tim-HT     v4-csc_vruntime-HT
Amean     1       1.2194 (   0.00%)      1.1974 (   1.80%)      1.0308 *  1=
5.47%*      1.1054 *   9.35%*      1.0522 *  13.71%*      1.2290 (  -0.79%)=
      1.1392 *   6.58%*      1.0524 *  13.70%*
Amean     3       2.2568 (   0.00%)      2.0588 (   8.77%)      2.0708 (   =
8.24%)      2.2352 (   0.96%)      2.1808 (   3.37%)      2.2820 (  -1.12%)=
      2.1682 (   3.93%)      2.2598 (  -0.13%)
Amean     5       2.9848 (   0.00%)      2.9912 (  -0.21%)      2.4938 *  1=
6.45%*      2.4634 *  17.47%*      2.6890 (   9.91%)      2.8908 (   3.15%)=
      2.8636 (   4.06%)      2.4158 *  19.06%*
Amean     7       3.4500 (   0.00%)      3.2538 (   5.69%)      3.3646 (   =
2.48%)      3.2666 (   5.32%)      3.0800 (  10.72%)      4.2206 ( -22.34%)=
      3.1016 (  10.10%)      3.2186 (   6.71%)
Amean     12      6.0414 (   0.00%)      5.0624 (  16.20%)      5.1276 (  1=
5.13%)      5.1066 (  15.47%)      4.7728 *  21.00%*      5.5068 (   8.85%)=
      4.7544 *  21.30%*      5.8920 (   2.47%)
Amean     16      7.5510 (   0.00%)      7.6888 (  -1.82%)      6.9732 (   =
7.65%)      5.9098 *  21.73%*      6.5542 *  13.20%*      6.9492 (   7.97%)=
      6.4372 *  14.75%*      6.1968 *  17.93%*
Stddev    1       0.0786 (   0.00%)      0.1166 ( -48.34%)      0.1762 (-12=
4.09%)      0.0712 (   9.45%)      0.1541 ( -95.99%)      0.0814 (  -3.55%)=
      0.0452 (  42.57%)      0.1817 (-131.05%)
Stddev    3       0.2220 (   0.00%)      0.1887 (  15.03%)      0.2174 (   =
2.07%)      0.1368 (  38.37%)      0.1928 (  13.17%)      0.4342 ( -95.57%)=
      0.2353 (  -5.97%)      0.1753 (  21.06%)
Stddev    5       0.4586 (   0.00%)      0.4689 (  -2.23%)      0.3202 (  3=
0.19%)      0.2666 (  41.88%)      0.3108 (  32.24%)      0.2876 (  37.29%)=
      0.4067 (  11.33%)      0.3010 (  34.37%)
Stddev    7       0.3769 (   0.00%)      0.5242 ( -39.09%)      0.2523 (  3=
3.06%)      0.2498 (  33.71%)      0.4527 ( -20.13%)      1.5089 (-300.36%)=
      0.3998 (  -6.09%)      0.4018 (  -6.62%)
Stddev    12      1.0604 (   0.00%)      0.5194 (  51.02%)      0.5646 (  4=
6.75%)      0.5255 (  50.45%)      0.4872 (  54.06%)      0.3447 (  67.49%)=
      0.5492 (  48.21%)      0.5487 (  48.26%)
Stddev    16      0.6245 (   0.00%)      0.5220 (  16.40%)      0.6914 ( -1=
0.71%)      0.6984 ( -11.83%)      0.3543 (  43.27%)      0.5137 (  17.74%)=
      0.5083 (  18.61%)      1.0744 ( -72.04%)
                                  v                      v                 =
  VMx2                   VMx2                   VMx2                   VMx2=
                   VMx2                   VMx2
                            VMx2-HT              VMx2-noHT                 =
    HT                   noHT                 csc-HT        csc_stallfix-HT=
             csc_tim-HT        csc_vruntime-HT
Amean     1       0.6780 (   0.00%)      2.1522 *-217.43%*      1.6790 *-14=
7.64%*      2.2440 *-230.97%*     15.6090 *-2202.21%*      9.1920 *-1255.75=
%*      2.0732 *-205.78%*      2.2390 *-230.24%*
Amean     3       1.8452 (   0.00%)      3.2456 * -75.89%*      2.5214 * -3=
6.65%*      3.3944 * -83.96%*     13.7258 *-643.87%*      9.7654 *-429.23%*=
      2.6668 * -44.53%*      2.9044 * -57.40%*
Amean     5       2.8564 (   0.00%)      4.2548 * -48.96%*      3.2500 * -1=
3.78%*      4.3958 * -53.89%*     11.6808 *-308.93%*      8.4724 *-196.61%*=
      3.4000 * -19.03%*      3.5298 * -23.58%*
Amean     7       3.3712 (   0.00%)      5.1056 * -51.45%*      4.1636 * -2=
3.50%*      4.9874 * -47.94%*     14.0516 (-316.81%)      9.1454 *-171.28%*=
      4.1396 * -22.79%*      4.3570 * -29.24%*
Amean     12      4.8134 (   0.00%)      7.4516 * -54.81%*      6.1254 * -2=
7.26%*      7.3488 * -52.67%*     13.7680 *-186.03%*     13.7400 *-185.45%*=
      6.0424 * -25.53%*      6.3404 * -31.72%*
Amean     18      6.1980 (   0.00%)     10.4126 * -68.00%*      8.5942 * -3=
8.66%*      9.7554 * -57.40%*     10.7234 * -73.01%*     13.5214 *-118.16%*=
      8.6628 * -39.77%*      8.5910 * -38.61%*
Amean     24      8.2116 (   0.00%)     12.7570 * -55.35%*     10.9386 * -3=
3.21%*     12.9032 * -57.13%*     17.8492 *-117.37%*     14.4432 * -75.89%*=
     10.7488 * -30.90%*     11.1930 * -36.31%*
Amean     30      9.3264 (   0.00%)     15.3704 * -64.81%*     13.6630 * -4=
6.50%*     15.4806 * -65.99%*     16.9272 * -81.50%*     18.4184 * -97.49%*=
     13.6174 * -46.01%*     13.5026 * -44.78%*
Amean     32     10.1954 (   0.00%)     16.5494 * -62.32%*     14.7450 * -4=
4.62%*     16.4650 * -61.49%*     13.9146 * -36.48%*     17.5790 * -72.42%*=
     14.6072 * -43.27%*     14.0346 * -37.66%*
Stddev    1       0.0129 (   0.00%)      0.2665 (-1959.36%)      0.2262 (-1=
647.54%)      0.0703 (-443.26%)      9.5450 (-73651.40%)      6.3226 (-4875=
2.57%)      0.1736 (-1241.41%)      0.3070 (-2272.09%)
Stddev    3       0.1156 (   0.00%)      0.3653 (-215.89%)      0.1388 ( -2=
0.00%)      0.2067 ( -78.77%)      3.3781 (-2821.39%)      3.2241 (-2688.20=
%)      0.0970 (  16.10%)      0.1247 (  -7.87%)
Stddev    5       0.0817 (   0.00%)      0.2968 (-263.19%)      0.0938 ( -1=
4.79%)      0.1367 ( -67.25%)      3.1273 (-3726.47%)      3.9175 (-4693.34=
%)      0.1155 ( -41.31%)      0.1864 (-128.10%)
Stddev    7       0.1190 (   0.00%)      0.1337 ( -12.31%)      0.3136 (-16=
3.48%)      0.2034 ( -70.91%)     17.1856 (-14336.96%)      2.8676 (-2308.9=
4%)      0.0794 (  33.32%)      0.1362 ( -14.42%)
Stddev    12      0.5237 (   0.00%)      0.2929 (  44.08%)      0.1386 (  7=
3.53%)      0.2330 (  55.51%)      7.1869 (-1272.26%)      8.0085 (-1429.13=
%)      0.2535 (  51.59%)      0.1441 (  72.49%)
Stddev    18      0.4791 (   0.00%)      0.1528 (  68.10%)      0.4254 (  1=
1.21%)      0.2953 (  38.37%)      2.8492 (-494.71%)      4.3767 (-813.54%)=
      0.3205 (  33.10%)      0.3094 (  35.43%)
Stddev    24      1.1591 (   0.00%)      0.2616 (  77.43%)      0.2446 (  7=
8.90%)      0.4363 (  62.36%)      5.3380 (-360.53%)      3.2433 (-179.81%)=
      0.2704 (  76.67%)      0.4402 (  62.02%)
Stddev    30      0.6561 (   0.00%)      0.4008 (  38.91%)      0.2670 (  5=
9.31%)      0.1451 (  77.88%)      4.5765 (-597.54%)      4.2380 (-545.95%)=
      0.4768 (  27.33%)      0.2693 (  58.96%)
Stddev    32      1.2197 (   0.00%)      0.4459 (  63.44%)      0.5496 (  5=
4.94%)      0.4179 (  65.74%)      1.3553 ( -11.12%)      4.3537 (-256.96%)=
      0.5602 (  54.07%)      0.5312 (  56.45%)

So, situation looks pretty *terrible* on baremetal. Well, something to
investigate, I guess.

In VMs, on the other hand, things don't look too bad. Although, it's a
bit weird that the benchmark seems to be sensitive to HT when run on
baremetal, but not so much when run in VMs. Among the various core
scheduling implementations/patches, plain v3 seems to have issues with
this workload, while Tim's and vruntime are better.

It is confirmed that, in virtualization scenario, under
overcommittment, core scheduling is more effective than disabling
HyperThreading, at least either with Tim's or with vruntime patches.

Overhead wise, it is an hard call. Numbers vary a lot, and I think each
group of measurements needs to be looked at carefully to come up with a
sensible analysis.

Overhead is there, that's for sure, in the baremetal case. Also, it
looks more severe when HT is disabled (e.g., comapre v-BM-noHT with BM-
noHT).

In virt cases, it's really an hard call. E.g., when a VM with 4 vCPUs
is used, core scheduling seems to be able to make the system
significantly faster! :-O
--=20
Dario Faggioli, Ph.D
http://about.me/dario.faggioli
Virtualization Software Engineer
SUSE Labs, SUSE https://www.suse.com/
-------------------------------------------------------------------
<<This happens because _I_ choose it to happen!>> (Raistlin Majere)


--=-XbK6MDKfXOQ62Mn7nYyD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEES5ssOj3Vhr0WPnOLFkJ4iaW4c+4FAl24A0kACgkQFkJ4iaW4
c+41WRAA1Fymi0jurt1HSRQrrZgabOco9bkFgt9M+BK0zWXf9yPFWJFPeecVF8P8
gf3lUy8NskSHxeY8ibRMnqqHBJyQ4feng+43YFhDTRnnGFg5wV5CUQvz4kZe+Nb9
OWtHFnLI4gBqsk8CGa6dUKnLWDi8CTj5NPZRs732cT6Ul+Bq6ohDpi1syo2xpn3+
lnoWyILRg2tvEvBHdszpL3NJsWFioA947TvJ7W98vVei6vpyFO9aTP2cjyX4YMx/
beyuSx3RxXvMFva3Bu0HgNo4FwBVjNFW3tQtPhlV1Q3KcGfuh3NSObas31AzJmV+
qZMN0iL4JY3A3FKHsWN5PMKSKZAoYSh9z03ZmDC2r0ZtHZ9TM4p+M0RQ9Luiv2L2
u71aFeXe9Ck+i4fTypg2Vrs+XEXF4gjhWFVlV2+EzKLye6lEXjYp84TUAxDbu8om
0Oqj5wJPcOR7CLgsxpTgEnds4FK9PTbPjWmWEGKr5gkGkq6kdZgeZnApkUnn0GO9
yoDHdCwvBBr2VjaTr0gTAYVuspb7liolpFTMwxspHUqCQ5hjMO81Lirs2iAEW8kv
anD8ih0O39M2/yIbTclIYY7y1+XuIT51+PZ/wCyiR0/v6+Y1tMTcRZ7fTeHm4v/q
ESdeVxle2VFLlvPJ6WldiN4yj1OznY51pOYKHDl8SGyIOlnaAJk=
=itAS
-----END PGP SIGNATURE-----

--=-XbK6MDKfXOQ62Mn7nYyD--


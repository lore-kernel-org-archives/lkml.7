Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AF1CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D21320830
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732008AbfJ2JSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:18:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:40764 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726803AbfJ2JSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:18:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5003BB283;
        Tue, 29 Oct 2019 09:18:50 +0000 (UTC)
Message-ID: <615958c46c850d284de76ffcf9f0dc35ad262066.camel@suse.com>
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
Date:   Tue, 29 Oct 2019 10:18:48 +0100
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
        protocol="application/pgp-signature"; boundary="=-vUJAtHRWv6ovXvFt0x+s"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vUJAtHRWv6ovXvFt0x+s
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
SYSBENCH
=3D=3D=3D=3D=3D=3D=3D=3D

http://xenbits.xen.org/people/dariof/benchmarks/results/linux/core-sched/mm=
tests/boxes/wayrath/coresched-email-6_sysbench.txt

                                 v                      v                  =
   BM                     BM                     BM                     BM =
                    BM                     BM
                             BM-HT                BM-noHT                  =
   HT                   noHT                 csc-HT        csc_stallfix-HT =
            csc_tim-HT        csc_vruntime-HT
Hmean     1      235.81 (   0.00%)      221.49 (  -6.07%)      245.28 (   4=
.01%)      230.53 (  -2.24%)      241.40 (   2.37%)      225.00 (  -4.58%) =
     225.50 (  -4.37%)      202.38 ( -14.18%)
Hmean     4      273.77 (   0.00%)      290.01 (   5.93%)      292.47 (   6=
.83%)      261.76 (  -4.39%)      287.58 (   5.04%)      281.30 (   2.75%) =
     274.21 (   0.16%)      271.91 (  -0.68%)
Hmean     7      346.60 (   0.00%)      315.58 (  -8.95%)      345.38 (  -0=
.35%)      349.29 (   0.78%)      363.76 (   4.95%)      349.09 (   0.72%) =
     355.69 (   2.62%)      336.69 (  -2.86%)
Hmean     8      343.17 (   0.00%)      353.73 (   3.08%)      409.04 (  19=
.19%)      411.31 (  19.86%)      406.77 (  18.53%)      306.33 ( -10.74%) =
     393.70 (  14.72%)      342.73 (  -0.13%)
Stddev    1       44.93 (   0.00%)       50.07 ( -11.44%)       25.05 (  44=
.24%)       39.22 (  12.71%)       26.27 (  41.54%)       42.77 (   4.81%) =
      43.63 (   2.90%)       62.88 ( -39.95%)
Stddev    4       16.03 (   0.00%)       23.37 ( -45.76%)       23.77 ( -48=
.25%)       22.40 ( -39.69%)       18.63 ( -16.19%)       14.37 (  10.35%) =
       9.34 (  41.72%)       25.21 ( -57.23%)
Stddev    7       22.88 (   0.00%)       37.54 ( -64.07%)       26.57 ( -16=
.16%)       38.50 ( -68.26%)       59.14 (-158.51%)       26.73 ( -16.83%) =
      24.58 (  -7.43%)       32.93 ( -43.94%)
Stddev    8       36.74 (   0.00%)       36.60 (   0.39%)      102.82 (-179=
.86%)       93.56 (-154.65%)       77.33 (-110.47%)       36.16 (   1.58%) =
      44.27 ( -20.50%)       35.15 (   4.33%)
                                 v                      v                  =
   VM                     VM                     VM                     VM =
                    VM                     VM
                             VM-HT                VM-noHT                  =
   HT                   noHT                 csc-HT        csc_stallfix-HT =
            csc_tim-HT        csc_vruntime-HT
Hmean     1      215.16 (   0.00%)      225.80 *   4.95%*      205.74 (  -4=
.38%)      200.61 (  -6.76%)      169.70 ( -21.13%)      168.84 ( -21.53%) =
     157.27 ( -26.91%)      162.94 ( -24.27%)
Hmean     4      163.44 (   0.00%)      189.82 *  16.14%*      164.54 (   0=
.67%)      148.47 (  -9.16%)       40.62 * -75.15%*       53.14 * -67.49%* =
     129.51 * -20.76%*      158.99 (  -2.72%)
Hmean     7      162.74 (   0.00%)      185.79 (  14.17%)      211.79 (  30=
.14%)      186.92 (  14.86%)       28.02 * -82.78%*       34.32 * -78.91%* =
     130.01 ( -20.11%)      145.47 ( -10.61%)
Hmean     8      240.19 (   0.00%)      192.24 ( -19.96%)      192.87 * -19=
.70%*      194.01 ( -19.23%)       16.92 * -92.95%*       30.55 * -87.28%* =
     150.51 * -37.34%*      147.67 * -38.52%*
Stddev    1        1.80 (   0.00%)        4.14 (-129.80%)        6.04 (-234=
.90%)       24.54 (-1261.18%)       61.54 (-3313.19%)       62.92 (-3389.48=
%)       55.91 (-3000.67%)       58.29 (-3132.75%)
Stddev    4        6.33 (   0.00%)       14.22 (-124.51%)        7.04 ( -11=
.07%)       13.77 (-117.30%)       13.23 (-108.83%)        5.07 (  19.92%) =
      15.73 (-148.38%)       14.04 (-121.61%)
Stddev    7       24.70 (   0.00%)       37.50 ( -51.78%)       35.59 ( -44=
.07%)       29.96 ( -21.26%)       20.07 (  18.77%)       21.06 (  14.74%) =
      24.97 (  -1.07%)       30.52 ( -23.52%)
Stddev    8       23.23 (   0.00%)       41.13 ( -77.03%)       27.30 ( -17=
.49%)       41.67 ( -79.35%)        3.75 (  83.88%)       12.62 (  45.68%) =
      55.87 (-140.49%)       37.12 ( -59.76%)
                                 v                      v                  =
   VM                     VM                     VM                     VM =
                    VM                     VM
                          VM-v4-HT             VM-v4-noHT                  =
v4-HT                v4-noHT              v4-csc-HT     v4-csc_stallfix-HT =
         v4-csc_tim-HT     v4-csc_vruntime-HT
Hmean     1      216.12 (   0.00%)      310.43 (  43.63%)      168.80 ( -21=
.90%)      196.04 (  -9.29%)      168.27 ( -22.14%)      188.53 ( -12.77%) =
     176.57 ( -18.30%)      180.12 ( -16.66%)
Hmean     3      161.91 (   0.00%)      160.80 (  -0.69%)      160.33 (  -0=
.97%)      175.36 (   8.31%)       51.27 * -68.34%*       52.18 * -67.77%* =
     137.95 ( -14.80%)      166.12 (   2.60%)
Hmean     4      156.44 (   0.00%)      196.25 *  25.45%*      165.19 (   5=
.60%)      199.78 *  27.71%*       50.67 * -67.61%*       40.42 * -74.16%* =
     175.03 (  11.88%)      172.66 *  10.37%*
Stddev    1        4.67 (   0.00%)      100.18 (-2043.42%)       50.61 (-98=
2.87%)      141.33 (-2923.68%)       69.08 (-1377.96%)       70.09 (-1399.5=
1%)       47.32 (-912.42%)       42.67 (-813.02%)
Stddev    3       12.62 (   0.00%)        8.76 (  30.60%)       13.18 (  -4=
.38%)        9.42 (  25.41%)        3.57 (  71.72%)       28.47 (-125.51%) =
      21.08 ( -67.00%)       19.37 ( -53.48%)
Stddev    4        8.52 (   0.00%)        8.54 (  -0.17%)        3.09 (  63=
.70%)       13.84 ( -62.42%)       24.33 (-185.50%)        9.30 (  -9.10%) =
      16.60 ( -94.73%)        9.64 ( -13.07%)
                                 v                      v                  =
 VMx2                   VMx2                   VMx2                   VMx2 =
                  VMx2                   VMx2
                           VMx2-HT              VMx2-noHT                  =
   HT                   noHT                 csc-HT        csc_stallfix-HT =
            csc_tim-HT        csc_vruntime-HT
Hmean     1      168.87 (   0.00%)      154.79 (  -8.34%)      190.28 (  12=
.68%)      151.18 ( -10.48%)      136.73 ( -19.03%)       36.63 * -78.31%* =
      83.21 ( -50.73%)      124.42 ( -26.32%)
Hmean     4      163.65 (   0.00%)       87.90 * -46.29%*      119.37 * -27=
.06%*       87.94 * -46.26%*       26.96 * -83.53%*       24.08 * -85.29%* =
      54.15 * -66.91%*       63.80 * -61.01%*
Hmean     7      181.60 (   0.00%)       89.10 * -50.93%*      148.16 ( -18=
.41%)       75.71 * -58.31%*       16.98 * -90.65%*       23.92 * -86.83%* =
      57.28 * -68.46%*       66.10 * -63.60%*
Hmean     8      198.98 (   0.00%)       94.24 * -52.64%*      141.96 ( -28=
.65%)       96.62 * -51.44%*       23.22 * -88.33%*       29.24 * -85.30%* =
      80.10 * -59.74%*       80.36 * -59.61%*
Stddev    1       61.59 (   0.00%)       44.71 (  27.41%)       52.14 (  15=
.33%)       44.61 (  27.56%)       90.12 ( -46.32%)       42.53 (  30.94%) =
      38.32 (  37.79%)       43.03 (  30.12%)
Stddev    4        8.65 (   0.00%)       21.74 (-151.41%)       21.18 (-144=
.98%)       22.51 (-160.27%)       19.72 (-128.07%)        4.38 (  49.38%) =
       2.68 (  68.95%)       14.40 ( -66.55%)
Stddev    7       17.94 (   0.00%)       15.14 (  15.62%)       29.94 ( -66=
.88%)       17.30 (   3.54%)       26.23 ( -46.20%)        5.17 (  71.17%) =
      15.98 (  10.95%)       18.43 (  -2.72%)
Stddev    8       38.45 (   0.00%)       19.68 (  48.82%)       44.14 ( -14=
.78%)       28.84 (  25.00%)       10.64 (  72.33%)       11.65 (  69.71%) =
      22.63 (  41.15%)       16.00 (  58.39%)

Core scheduling does not seem to be able to handle sysbench well, yet.
In this case, things are not to bad on baremtal (and the best
performing coresched variant is again the one with Tim's patches).

But things go bad when running the banchmark in VMs, where core
scheduling almost always loses against no HyperThreading, even in the
overcommitted case. For virt. cases, it's also not straightforward to
tell which set of patches are best, as some runs are in favours of
Tim's, some others of vruntime's.

--=20
Dario Faggioli, Ph.D
http://about.me/dario.faggioli
Virtualization Software Engineer
SUSE Labs, SUSE https://www.suse.com/
-------------------------------------------------------------------
<<This happens because _I_ choose it to happen!>> (Raistlin Majere)


--=-vUJAtHRWv6ovXvFt0x+s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEES5ssOj3Vhr0WPnOLFkJ4iaW4c+4FAl24A/gACgkQFkJ4iaW4
c+7bshAAyPnbrjHmeXxO5catKxzdwPUwXYeG4Vsu/EbJG8Ze3X/0ES5tPYrGCyfK
Zx9e5QY3cpCn/fCAebjwoMGtXK3l4FrSl3XlHokY+lGvTbZbKu/qHqkM4Ds0Ep99
729r+CPdAPQZve+2hcRSaHC7QinFu/9xLObaJiMpmWwDfx18nyGMwbxv0VaIknY4
gYK12V0+fpwkwE7as7BQbRX0fxzQPzC8OK32iNJfeQX6UZEODntr3SUxYiiqZ5vd
IsGVCOAtJyVJtCxU0dhcju04rf6gEXV+PtWkfR1Kb3Aq8J0V+G0kY56bwWcqydPd
7QnUYBuxt4hCGYM0WbqBXIrhjq8hUrVLsctp3m5DX7M1e5aZubmBeBsFwf4Tjrga
TmW7oNYG2NOm+MklBlnwKfLe7Y/q+0CCV74MH/jaVETNibD3lCMUEOxfw8ykqdem
x6qNg/iDXpYu8mAdSixPcTWhm2sQXhiqosdzmJoCyE4B5wR6N29Yre3WtydWSE3V
gfWVs6ILR1nGQZKhHDZRILbkwjwjIahHl6p0FXfKoLzr3SDJNV/KkUOoZkzXPUZi
xIo9FOak7As7mDCYeUg2Aj3bne6prPEH9ZB8G3YftQp8MpucMXP9y0kkf2br2hLw
7MRWDuXPHWwuaf7uHB+hHvJSC3W/IBoILTu9WodrKVAPK0z1Uk4=
=Z/4b
-----END PGP SIGNATURE-----

--=-vUJAtHRWv6ovXvFt0x+s--


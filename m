Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB54CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48EC320830
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732503AbfJ2JVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:21:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:41554 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727752AbfJ2JVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:21:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9E59FB335;
        Tue, 29 Oct 2019 09:20:59 +0000 (UTC)
Message-ID: <d30d343a8d9bf2c2e2977be7ac8370f26fd4df3d.camel@suse.com>
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
Date:   Tue, 29 Oct 2019 10:20:57 +0100
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
        protocol="application/pgp-signature"; boundary="=-qfha+dFNpu23ivIX+85m"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qfha+dFNpu23ivIX+85m
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
NETPERF-UNIX
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

http://xenbits.xen.org/people/dariof/benchmarks/results/linux/core-sched/mm=
tests/boxes/wayrath/coresched-email-7_mutilate.txt

                                    v                      v               =
      BM                     BM                     BM                     =
BM                     BM                     BM
                                BM-HT                BM-noHT               =
      HT                   noHT                 csc-HT        csc_stallfix-=
HT             csc_tim-HT        csc_vruntime-HT
Hmean     64        984.93 (   0.00%)     1011.24 (   2.67%)     1000.82 ( =
  1.61%)     1001.98 (   1.73%)      947.61 (  -3.79%)      823.10 * -16.43=
%*      789.89 * -19.80%*      928.11 *  -5.77%*
Hmean     256      3683.78 (   0.00%)     3763.52 (   2.16%)     3788.96 ( =
  2.86%)     3725.17 (   1.12%)     1254.25 * -65.95%*     1261.92 * -65.74=
%*     1264.02 * -65.69%*     1260.30 * -65.79%*
Hmean     2048     7928.28 (   0.00%)     7845.97 (  -1.04%)     7911.88 ( =
 -0.21%)     7809.11 *  -1.50%*     5334.65 * -32.71%*     5340.97 * -32.63=
%*     5337.93 * -32.67%*     5394.57 * -31.96%*
Hmean     8192     8134.23 (   0.00%)     8096.88 (  -0.46%)     8258.84 ( =
  1.53%)     8076.36 (  -0.71%)     5374.33 * -33.93%*     5394.12 * -33.69=
%*     5504.00 * -32.34%*     5447.92 * -33.02%*
Stddev    64         30.46 (   0.00%)       31.07 (  -2.00%)       15.36 ( =
 49.58%)       41.51 ( -36.26%)       54.71 ( -79.62%)      121.84 (-299.98=
%)       81.75 (-168.35%)       33.75 ( -10.79%)
Stddev    256       102.26 (   0.00%)      104.86 (  -2.55%)      107.90 ( =
 -5.52%)      116.17 ( -13.61%)        3.32 (  96.75%)        5.79 (  94.34=
%)       14.69 (  85.63%)       19.37 (  81.06%)
Stddev    2048       94.73 (   0.00%)       48.12 (  49.21%)      137.50 ( =
-45.15%)       43.30 (  54.29%)       58.65 (  38.08%)       50.97 (  46.20=
%)       57.43 (  39.38%)       36.39 (  61.58%)
Stddev    8192      172.77 (   0.00%)       48.68 (  71.83%)      261.65 ( =
-51.45%)       76.30 (  55.83%)       40.65 (  76.47%)       27.61 (  84.02=
%)       65.26 (  62.23%)       31.66 (  81.68%)
                                    v                      v               =
      VM                     VM                     VM                     =
VM                     VM                     VM
                                VM-HT                VM-noHT               =
      HT                   noHT                 csc-HT        csc_stallfix-=
HT             csc_tim-HT        csc_vruntime-HT
Hmean     64        516.67 (   0.00%)      585.50 (  13.32%)      592.54 ( =
 14.68%)      582.70 (  12.78%)      591.32 (  14.45%)      546.68 (   5.81=
%)      602.58 (  16.63%)      729.10 *  41.12%*
Hmean     256      1070.01 (   0.00%)     1306.95 *  22.14%*     1193.89 * =
 11.58%*     1271.17 *  18.80%*     1362.78 *  27.36%*     1171.49 (   9.48=
%)     1335.98 *  24.86%*     1248.79 *  16.71%*
Hmean     2048     5002.14 (   0.00%)     6865.72 *  37.26%*     5569.42 ( =
 11.34%)     5074.48 (   1.45%)     5849.11 (  16.93%)     4745.97 (  -5.12=
%)     6330.87 (  26.56%)     6418.51 (  28.32%)
Hmean     8192     5116.24 (   0.00%)     7494.15 *  46.48%*     6960.17 * =
 36.04%*     6009.31 (  17.46%)     6114.30 (  19.51%)     5226.13 (   2.15=
%)     6316.40 (  23.46%)     7924.66 *  54.89%*
Stddev    64         81.30 (   0.00%)      139.96 ( -72.15%)      162.38 ( =
-99.72%)      113.29 ( -39.35%)      150.34 ( -84.91%)      162.05 ( -99.32=
%)      163.74 (-101.39%)       47.94 (  41.04%)
Stddev    256        64.89 (   0.00%)      130.57 (-101.20%)      115.02 ( =
-77.23%)      120.49 ( -85.68%)      106.63 ( -64.31%)      140.18 (-116.01=
%)      118.29 ( -82.28%)      133.66 (-105.96%)
Stddev    2048      779.45 (   0.00%)      767.31 (   1.56%)     1869.81 (-=
139.89%)     1265.84 ( -62.40%)     1249.59 ( -60.32%)      506.63 (  35.00=
%)     1427.22 ( -83.11%)     2296.29 (-194.60%)
Stddev    8192      942.88 (   0.00%)     2559.80 (-171.49%)     1207.26 ( =
-28.04%)     1776.59 ( -88.42%)     1405.17 ( -49.03%)     1379.48 ( -46.30=
%)     2565.86 (-172.13%)     1066.06 ( -13.06%)
                                    v                      v               =
      VM                     VM                     VM                     =
VM                     VM                     VM
                             VM-v4-HT             VM-v4-noHT               =
   v4-HT                v4-noHT              v4-csc-HT     v4-csc_stallfix-=
HT          v4-csc_tim-HT     v4-csc_vruntime-HT
Hmean     64        626.51 (   0.00%)      535.18 ( -14.58%)      610.07 ( =
 -2.62%)      509.04 ( -18.75%)      552.16 ( -11.87%)      471.44 * -24.75=
%*      484.50 * -22.67%*      488.32 * -22.06%*
Hmean     256       999.57 (   0.00%)     1159.65 *  16.02%*     1209.25 * =
 20.98%*     1217.94 *  21.85%*     1196.13 *  19.66%*     1286.01 *  28.66=
%*     1154.57 *  15.51%*     1238.40 *  23.89%*
Hmean     2048     3882.52 (   0.00%)     4483.92 (  15.49%)     4969.62 * =
 28.00%*     4910.98 *  26.49%*     4646.33 *  19.67%*     5247.76 *  35.16=
%*     4515.47 *  16.30%*     5096.38 *  31.26%*
Hmean     8192     4086.48 (   0.00%)     4935.20 (  20.77%)     4711.62 * =
 15.30%*     5067.04 (  24.00%)     5887.99 *  44.08%*     5360.18 *  31.17=
%*     5847.04 *  43.08%*     5990.50 *  46.59%*
Stddev    64        134.26 (   0.00%)      117.95 (  12.15%)       67.29 ( =
 49.88%)       88.91 (  33.78%)       78.73 (  41.36%)       22.34 (  83.36=
%)       45.36 (  66.22%)       64.62 (  51.87%)
Stddev    256        36.69 (   0.00%)       32.94 (  10.22%)       93.79 (-=
155.60%)       52.76 ( -43.79%)       72.03 ( -96.31%)       94.69 (-158.06=
%)       32.05 (  12.65%)       62.31 ( -69.82%)
Stddev    2048       64.82 (   0.00%)      785.16 (-1111.23%)     1086.67 (=
-1576.36%)      863.76 (-1232.48%)      552.05 (-751.62%)      597.66 (-821=
.99%)      300.86 (-364.12%)     1057.90 (-1531.98%)
Stddev    8192      248.29 (   0.00%)     1345.78 (-442.02%)      636.92 (-=
156.53%)     1497.43 (-503.10%)     1528.17 (-515.48%)      204.43 (  17.66=
%)      788.65 (-217.63%)     1380.18 (-455.88%)
                                    v                      v               =
    VMx2                   VMx2                   VMx2                   VM=
x2                   VMx2                   VMx2
                              VMx2-HT              VMx2-noHT               =
      HT                   noHT                 csc-HT        csc_stallfix-=
HT             csc_tim-HT        csc_vruntime-HT
Hmean     64        575.39 (   0.00%)      230.57 * -59.93%*      525.97 ( =
 -8.59%)      241.09 * -58.10%*      671.83 (  16.76%)      574.64 (  -0.13=
%)      676.93 (  17.65%)      713.81 (  24.06%)
Hmean     256      1243.12 (   0.00%)      679.95 * -45.30%*     1262.76 ( =
  1.58%)      646.82 * -47.97%*     1607.80 *  29.34%*     1297.86 (   4.40=
%)     1573.09 *  26.54%*     1244.30 (   0.09%)
Hmean     2048     4448.89 (   0.00%)     3020.71 * -32.10%*     4460.65 ( =
  0.26%)     3342.89 * -24.86%*     7086.92 *  59.30%*     4544.81 (   2.16=
%)     4209.05 (  -5.39%)     4346.58 (  -2.30%)
Hmean     8192     5539.82 (   0.00%)     3118.35 * -43.71%*     4003.50 * =
-27.73%*     2931.43 * -47.08%*     6069.77 (   9.57%)     5571.91 (   0.58=
%)     5143.26 (  -7.16%)     4245.56 * -23.36%*
Stddev    64        128.48 (   0.00%)       33.63 (  73.82%)      111.27 ( =
 13.39%)       64.39 (  49.89%)       79.47 (  38.14%)      189.98 ( -47.87=
%)       89.67 (  30.20%)      135.17 (  -5.21%)
Stddev    256       191.78 (   0.00%)      252.00 ( -31.40%)      225.33 ( =
-17.49%)      123.00 (  35.86%)      183.12 (   4.52%)      231.23 ( -20.57=
%)      161.13 (  15.98%)       66.95 (  65.09%)
Stddev    2048      463.85 (   0.00%)     1364.71 (-194.21%)     1390.20 (-=
199.71%)      382.49 (  17.54%)     1271.89 (-174.20%)     1058.81 (-128.27=
%)      602.49 ( -29.89%)      595.07 ( -28.29%)
Stddev    8192     1230.77 (   0.00%)     2402.19 ( -95.18%)      567.52 ( =
 53.89%)      511.30 (  58.46%)     2551.77 (-107.33%)     1065.61 (  13.42=
%)     1070.69 (  13.01%)      512.77 (  58.34%)

As many other instances: baremetal is suffering with core scheduling.
VMs are doing reasonably good, especially when there is overcommit.

---

Ok, that's it for now... Any comment, discussion, feedback, etc, more
than welcome.

Thanks and Regards
--=20
Dario Faggioli, Ph.D
http://about.me/dario.faggioli
Virtualization Software Engineer
SUSE Labs, SUSE https://www.suse.com/
-------------------------------------------------------------------
<<This happens because _I_ choose it to happen!>> (Raistlin Majere)


--=-qfha+dFNpu23ivIX+85m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEES5ssOj3Vhr0WPnOLFkJ4iaW4c+4FAl24BHoACgkQFkJ4iaW4
c+5IGA//RrVX/t0wlLtAojTpnbd8xgZDFgDJB4YaoS7gP8LiaRE7KTmtKpjFRORp
Rr6bgeRhQnzMmHkVzl0OebZ7zCDKppLoGDg/C02Ku0JgOOcakyMzbbLx2MsOgxPW
hj+uoG4qTmuyoa4o8e0e+6LLhzH093QOm8wUTxITGtQOX1JLfBjYxwGm3GIHcgxx
gqe0KlehsA/4+/zEepFNEWVeGE3Tw8PIjVMLi8CnJJuGlVhpM7KKNcsVtsqwzHxj
6244LGvOg16jB3TmTj3K1xR/Z/yDhVDRjSKGeq1Pae8yzGEqvnnJXWWhm6vKZGKw
kViZ1uZCVDFjFEP4Fz2nAAX2SyjSIWOwK1tUBHupCIJJDKkzm7Ul9UGjiPHDHM7i
qKZjL39VPxq/+ZtopOL6bK7vw6aWK6g/wyPRYodUmLytwMWwrC8Rdhv+mYtkA9Z1
ioCRC74LjkNdSMz/mc3zkv/2GjZbVFPKstLLv65zwrOBsOjSU6C6hYxPLC5zTiAT
F0Fgfvn2ap+DeIfF9FvMxyJnFq47Y6tRNg+yJsZ1a3ovBjdpIMNjPGKJxlsIdDgk
PgfgCPBAvj7JnS84Z8KE7X+30LKFJpLwH8ULi5WpTgHS0bpIAlIgwr41MPQqyMgO
Ux0QBy2PcAh5FSKsl+Wo7jcte7YTYOF7nfSdCLrHHhrKhNyjFLo=
=ZVJD
-----END PGP SIGNATURE-----

--=-qfha+dFNpu23ivIX+85m--


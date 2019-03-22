Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC3FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDAD320685
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391040AbfCVM2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:28:02 -0400
Received: from mga14.intel.com ([192.55.52.115]:28632 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731371AbfCVM2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:28:00 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 05:27:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="asc'?scan'208";a="133815242"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by fmsmga008.fm.intel.com with ESMTP; 22 Mar 2019 05:27:58 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Linux USB <linux-usb@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Chunyan Zhang <zhang.chunyan@linaro.org>
Subject: Re: [PATCH] usb: gadget: functions: add ftrace export over USB
In-Reply-To: <20190322082252.2d239fbc@gandalf.local.home>
References: <20170609061327.17899-1-felipe.balbi@linux.intel.com> <87ftrg8t3j.fsf@linux.intel.com> <20190321123715.027e9369@gandalf.local.home> <87va0bdt7g.fsf@linux.intel.com> <20190322082252.2d239fbc@gandalf.local.home>
Date:   Fri, 22 Mar 2019 14:27:54 +0200
Message-ID: <87r2azdrg5.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Steven Rostedt <rostedt@goodmis.org> writes:

> On Fri, 22 Mar 2019 13:49:55 +0200
> Felipe Balbi <felipe.balbi@linux.intel.com> wrote:
>
>> > Can you post the latest to the list one more time. At least to make
>> > sure you got the naming correct ;-)
>> >
>> >   Not FTrace or f_trace.=20=20
>>=20
>> The reason for the name was discussed already. See [1] and [2]
>>=20
>> [1] https://marc.info/?i=3D878tl1qmrj.fsf@linux.intel.com
>> [2] https://marc.info/?i=3D20170609110717.3304f6b9@gandalf.local.home
>
> Ah, I forgot (was two years ago) But not doing FTrace still stands!

Replaced with ftrace everywhere now. I'll wait a little before a resend
(see [1] for some questions I have)

[1] https://marc.info/?i=3D87h8bvffth.fsf@linux.intel.com

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlyU1MoACgkQzL64meEa
mQbeBBAAsVWugMh6zQgEOg+UgE467BtXrz2NhN1w/t/CZUHikev6bs/pCLIqGRLA
DSgl5pyPbr2hENcBhI/5Kj+SIXtWtvsNfdQdIkwspJBNpI8TO1ymQB4/NRlM0Qwq
EevMD2+OnCJIuHhpLAmkgVQSs52/i0IoYQmccvnvdE67/zX9GZk/wRo6ib4pa1ST
76qpN4GE5mfGk/a+3g77rNtLf5ezeIGZpMR+Rt6Oo2a46aK035CKoYc/kVeGfYYC
k+OQ2Y7qiTN35j8b6rV67HX1htRW77oLqLYXHYw83lMK2hddIE6iAstrHiiuL1cX
map4ELhT0bD1YU1uMQ3suE1LONBQPxkb/e74q55NfExNgsCaNrUhD+M7c9/kXVyP
1Bsr2JkBnkKcdPGg37mG5kuQxx0/ZGstUMfq6XMavbG5jsgEb0RNQ558KB+E/pB7
B7ZJf1vT33hcqhXqudOiUZ+kC6JTqxguopoprLv18MZrzXr8rsUCOKINmsFWctmC
wUsorf2UkjrGN62sgXmHRmryuz5EPBaDdpxDRlemOn2yEMrjQLUkHIUiCC5JaZqJ
EvK/JGynJM7+cDZ5SmX7DxSRm30qYEW2YYM7BfpgggR21FPOkSA8paMr2diuh+pQ
AMBOoRG/lI2F/EjtW42unigifE7+M4MRzQqXidRK86B7Pa7sr84=
=98ft
-----END PGP SIGNATURE-----
--=-=-=--

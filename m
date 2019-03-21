Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE41C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E417C218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbfCUJjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:39:03 -0400
Received: from mga11.intel.com ([192.55.52.93]:22492 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727946AbfCUJjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 05:39:03 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 02:39:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,252,1549958400"; 
   d="asc'?scan'208";a="142573572"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Mar 2019 02:39:00 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Linux USB <linux-usb@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Chunyan Zhang <zhang.chunyan@linaro.org>
Subject: Re: [PATCH] usb: gadget: functions: add ftrace export over USB
In-Reply-To: <20170609061327.17899-1-felipe.balbi@linux.intel.com>
References: <20170609061327.17899-1-felipe.balbi@linux.intel.com>
Date:   Thu, 21 Mar 2019 11:38:56 +0200
Message-ID: <87ftrg8t3j.fsf@linux.intel.com>
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


Hi,

Felipe Balbi <felipe.balbi@linux.intel.com> writes:
> Allow for ftrace data to be exported over a USB Gadget
> Controller. With this, we have a potentially very fast pipe for
> transmitting ftrace data to a Host PC for further analysis.
>
> Note that in order to decode the data, one needs access to kernel
> symbols in order to convert binary data into function names and what
> not.
>
> Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> ---
>
> I wanted to take this through the gadget tree, but there is a
> dependency with a previous patch of mine adding and extra argument to
> the ->write() function. Hoping someone else will take it.

This is still not upstream, I'll take it through my tree this time around.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlyTW7AACgkQzL64meEa
mQYr8A//XKk81spjbBLdh4ILwPtSNFPBlJcGgVMcLGJC39msBz/6tXqDq4uje1g2
UbtS5E3Ripg1fIlxXSz2wULCHuyhi71716I+yxXGUhXS7L3yiWhp2dDukin/HXE9
x9lmPWWaJ4m9RXzSlRHZc3Ryk54UaTwaqLRjTg7IluMVKbj/sRy0fJedrWafLIlL
V8e135fC6rGNQ7qfu9U2g+lv6b6iQdw0YXD+NyasSy8wmCvnF+QpR5ZKoqZPH1x/
GyB9Ta5WMfH/yypRAuEtrPg8vazlhEH8szJaeG3qnW4ToFjMMMpvm8dt268Ti0hZ
j3x2Cp6GnlWqPwIvioyX4KB6hr+ygBm2hlczXEEQOHO7r/MxHUx8dX6VrfkSZ30P
wgqSEHWz3pkScTwz1Ft0XZ0CSoFXyteNRxPiNFj1CpzwvuXMSGxckZ6AyLjZssaQ
2Kt8rYCua1kRMd8K55WgomId22YRn/mhtYXfc0reKZBwchWD5m3ZiNPUa6qXSe7v
r3Ugm5kt0e/JoxpVYiK1W4CybBD1Q1hEIbm/cocaPrQ4XPfvDPZ8n3jZmRw0/8dy
jTWunHzuQLec9YqgE28km24grCyazn9mLpq/iUCZkVd/AVut2m0EWQGHSi5w+cvA
8eBekf86vlXNOPbPG2RFpyV50M03LIo4LfN7fAqmv+7GfRKhoik=
=XlXA
-----END PGP SIGNATURE-----
--=-=-=--

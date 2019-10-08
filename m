Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA6EECE58E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 127EA20673
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731095AbfJHM7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:59:05 -0400
Received: from mga02.intel.com ([134.134.136.20]:33053 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730705AbfJHM7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:59:05 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2019 05:59:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,270,1566889200"; 
   d="asc'?scan'208";a="192568244"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by fmsmga008.fm.intel.com with ESMTP; 08 Oct 2019 05:59:01 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Peter Chen <peter.chen@nxp.com>,
        Pawel Laszczak <pawell@cadence.com>
Cc:     "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "rogerq\@ti.com" <rogerq@ti.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel\@ti.com" <jbergsagel@ti.com>,
        "nsekhar\@ti.com" <nsekhar@ti.com>, "nm\@ti.com" <nm@ti.com>,
        "sureshp\@cadence.com" <sureshp@cadence.com>,
        "kurahul\@cadence.com" <kurahul@cadence.com>
Subject: Re: [PATCH] usb:cdns3: Fix for CV CH9 running with g_zero driver.
In-Reply-To: <20191008065619.GE5670@b29397-desktop>
References: <1570430355-26118-1-git-send-email-pawell@cadence.com> <20191008065619.GE5670@b29397-desktop>
Date:   Tue, 08 Oct 2019 15:58:57 +0300
Message-ID: <87a7abv1f2.fsf@gmail.com>
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

Peter Chen <peter.chen@nxp.com> writes:
> On 19-10-07 07:39:11, Pawel Laszczak wrote:
>> Patch fixes issue with Halt Endnpoint Test observed
>
> %s/Endnpoint/Endpoint
>
>>
>> during using g_zero
>> driver as DUT. Bug occurred only on some testing board.
>
> g_zero is legacy, please use configfs function source_sink or loopback
> instead.

We still want fixes for those ;-)

>> Endpoint can defer transition to Halted state if endpoint has pending
>> requests.
>
> The implementation of halt handling is a little complicated, you may
> consider return -EAGAIN for functional stall through usb_ep_set_halt
> from function driver if the requests are pending, it doesn't need to
> defer such kinds of functional stall.

=2DEAGAIN, IIRC is only supposed to be used for IN endpoint stalls.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl2ciBEACgkQzL64meEa
mQbb8hAAomfKJn0CSDdwf7TlgIBVDMs499S0HgMYnKdya2wxFewm2Fmp5b8pVaEO
sdNweEVC9C8G/+iOdCXrJC4Yix6O7CjK34qxcMT52Hh1I4Ay0WZTYoiHenA8rzos
AxPXLtZG2iY0gvbdjS6l8rZcYi/T7Hv2aesLv8UJ4OT17Wt8Zb2IZU7gdphUOOme
XJFy/42lpLaQSf8tfW8yqgnZFqCwNeDgLXA40YVtzDZJnB9Mvfklr+jxlSCqI+Lf
2m3Es+JgAyg7W8ATaj3ehmjA/bJlVczYy69wgd4bCWiPW6xsofZu+dMsTvgoy8xu
sxCqsCfCWgoOrtttOQzwf4oV4Bv0a3ykvN3zRmRuRIEqgnikF1PJN6IYpmI7QDpu
ytzUFzoVhago1LJczNJs1bb1oNfUWspTetaU7KaauJbZemyOHz1qMfK50i7QJOKU
tzNrujMIVrC9U+4H80bQUj3imtA07YoY3XlLmUdwsfuB8M5H9B4+qs4vynJT9TXA
tUeITszbLGoYavxA4xqjAUqswdmp7G1Kj8lXqjqe8KJV02FuA7v4zpy5uf8/RKFZ
AXlofJI9vyG0YGCkZr7IVG6R5ttoZ42nn4vWNTCaRB6dEpEO85fGzGGWbjx+SbEN
9YlTiWeNAnd84DpTWIbP1cXE254bO5n7IJr16caefX/ta0t/QPA=
=IlzZ
-----END PGP SIGNATURE-----
--=-=-=--

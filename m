Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA54C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC4420868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfDPGMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 02:12:41 -0400
Received: from mga17.intel.com ([192.55.52.151]:53117 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbfDPGMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 02:12:41 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Apr 2019 23:12:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,355,1549958400"; 
   d="asc'?scan'208";a="337984849"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by fmsmga005.fm.intel.com with ESMTP; 15 Apr 2019 23:12:36 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 36/57] docs: usb: convert documents to ReST
In-Reply-To: <eaafc5741ccfe3b96ab2a9ef799c537c49ab20e5.1555382110.git.mchehab+samsung@kernel.org>
References: <cover.1555382110.git.mchehab+samsung@kernel.org> <eaafc5741ccfe3b96ab2a9ef799c537c49ab20e5.1555382110.git.mchehab+samsung@kernel.org>
Date:   Tue, 16 Apr 2019 09:12:32 +0300
Message-ID: <874l6ya373.fsf@linux.intel.com>
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

Mauro Carvalho Chehab <mchehab+samsung@kernel.org> writes:

> Convert USB documents to ReST, in order to prepare for adding it
> to the kernel API book, as most of the stuff there are driver or
> subsystem-related.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/usb/WUSB-Design-overview.txt |  56 +-
>  Documentation/usb/acm.txt                  | 156 +++---
>  Documentation/usb/authorization.txt        |  75 +--
>  Documentation/usb/chipidea.txt             | 101 ++--
>  Documentation/usb/dwc3.txt                 |  12 +-
>  Documentation/usb/ehci.txt                 |  42 +-
>  Documentation/usb/functionfs.txt           |  17 +-
>  Documentation/usb/gadget-testing.txt       | 609 ++++++++++++---------
>  Documentation/usb/gadget_configfs.txt      | 302 +++++-----
>  Documentation/usb/gadget_hid.txt           | 175 +++---
>  Documentation/usb/gadget_multi.txt         |  43 +-
>  Documentation/usb/gadget_printer.txt       | 155 +++---
>  Documentation/usb/gadget_serial.txt        |  73 +--
>  Documentation/usb/iuu_phoenix.txt          |  34 +-
>  Documentation/usb/mass-storage.txt         |  19 +-
>  Documentation/usb/misc_usbsevseg.txt       |   9 +-
>  Documentation/usb/mtouchusb.txt            |  42 +-
>  Documentation/usb/ohci.txt                 |   5 +-
>  Documentation/usb/rio.txt                  |  83 +--
>  Documentation/usb/usb-help.txt             |  21 +-
>  Documentation/usb/usb-serial.txt           | 203 ++++---
>  Documentation/usb/usbip_protocol.txt       | 552 ++++++++++---------
>  Documentation/usb/usbmon.txt               | 100 ++--

should you change extension to .rst while at that?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAly1clAACgkQzL64meEa
mQZclRAAsO2oVxl96DdUAvZjTv2Uf+xu3KuObyLT1OjUdxMAWiZg9xBv1N65SJTh
Tz6nDfmsYdTZPAizvKvkbNhhG4/AJ/KyGjW1dpihdmBLueibL0Yb+Q0a0hVuTFDT
SA7peREFIlD/fyBmg8bJDpXXGlSbfQQEBxs5Mt/h1S6Bpw3P7WlkHpgAewRWSCQK
ZNou2ty79bJEp7tRxPFDjSAIfK60tzxmOUGxkYctF2csKTWq/QF2nOgM0lh6Vcgg
aJy8+fGTNjWvvN1oc/EJeAV0zrsaHWEn2dX/Q/adRknTAZbtLf0hvaDxDW8gzZKk
P9NFc4T+ukPGqpehf8I5aXkRzbqCIxIoIwh14Ts49dwc+chmdfIQnc2MjxFt/rKw
pDDYI1BSVOEFCwosnHgiK0NAn6uSZWzOv3UHartW7Jl9wfhWhL2na1tPQ66OGbA1
MSgtuAd7pqU1N7bZ+j4l9mpPiPP/splksEvwX82iBjx/Wfn3OHWrTX44aiOIbpTX
rB0YI6/3MslyWs4YgsyhM8FIsDIygWxKzw9dG1SvKYmSfqbpYlmwfJ135YZ/iybW
CnqfVCP9SozE0s1e1EKCF1H/RAm828Iiooh3I09sHBNiKJhJZCrbJECi8+vcatC3
CV1D21KnJ8sUfo+C35NK5q4YsCWIlSmUj4A5Z0P8yddcd55e/SU=
=e70b
-----END PGP SIGNATURE-----
--=-=-=--

Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204D5C606AC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 11:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF91D20665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 11:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbfGHL70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 07:59:26 -0400
Received: from mga17.intel.com ([192.55.52.151]:17038 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727189AbfGHL70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 07:59:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jul 2019 04:59:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,466,1557212400"; 
   d="asc'?scan'208";a="167106436"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by fmsmga007.fm.intel.com with ESMTP; 08 Jul 2019 04:59:21 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Pawel Laszczak <pawell@cadence.com>,
        "devicetree\@vger.kernel.org" <devicetree@vger.kernel.org>
Cc:     "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "hdegoede\@redhat.com" <hdegoede@redhat.com>,
        "heikki.krogerus\@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "robh+dt\@kernel.org" <robh+dt@kernel.org>,
        "rogerq\@ti.com" <rogerq@ti.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel\@ti.com" <jbergsagel@ti.com>,
        "nsekhar\@ti.com" <nsekhar@ti.com>, "nm\@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen\@nxp.com" <peter.chen@nxp.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v9 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
In-Reply-To: <BYAPR07MB47097C3C2A2BBA2AA63C65DEDDF60@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1562324238-16655-1-git-send-email-pawell@cadence.com> <1562324238-16655-6-git-send-email-pawell@cadence.com> <87r274lmqk.fsf@linux.intel.com> <BYAPR07MB4709EF3753AC0B87606B1182DDF70@BYAPR07MB4709.namprd07.prod.outlook.com> <87a7dpm442.fsf@linux.intel.com> <BYAPR07MB4709E5BA041BBDDB70E69F62DDF60@BYAPR07MB4709.namprd07.prod.outlook.com> <874l3wn5ep.fsf@linux.intel.com> <BYAPR07MB47097C3C2A2BBA2AA63C65DEDDF60@BYAPR07MB4709.namprd07.prod.outlook.com>
Date:   Mon, 08 Jul 2019 14:59:11 +0300
Message-ID: <874l3whh4g.fsf@linux.intel.com>
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


(please send it as a formal patch from now on)

Hi,

Pawel Laszczak <pawell@cadence.com> writes:
> The prototype was added , but not all text was past. Sorry for that.=20=20
>
> Fixed version:  with your changes.
>
> ///// v2 corrected=20
> commit 4553d48dd0500085d90c8280e28714072279c3dd (HEAD)
> Author: Pawel Laszczak <pawell@cadence.com>
> Date:   Mon Jul 8 12:53:47 2019 +0200
>
>     usb: common: Add usb_get_dr_mode_from_string and usb_dr_mode_to_strin=
g.
>
>     Patch introduces new function usb_dr_mode_to_string for converting du=
al role
>     mod to string and removes static from usb_dr_mode_to_string definitio=
n.
>
>     Both changes have made to avoid duplication of code by cdns3 driver.

missing Signed-off-by

> diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
> index 69f1b6328532..c156817672c4 100644
> --- a/include/linux/usb/otg.h
> +++ b/include/linux/usb/otg.h
> @@ -129,4 +129,20 @@ enum usb_dr_mode {
>   */
>  extern enum usb_dr_mode usb_get_dr_mode(struct device *dev);
>
> +/**
> + * usb_get_dr_mode_from_string - Convert string to dual role mode.
> + * @str: Pointer to the given string
> + *
> + * The function gets string and returns the correspondig enum usb_dr_mod=
e.
> + */

why duplicate the documentation? Perhaps put it only in the header,
otherwise we will need to update two locations whenever these functions
change.

> +extern enum usb_dr_mode usb_get_dr_mode_from_string(const char *str);
> +
> +/**
> + * usb_dr_mode_to_string - Convert dual role mode to string.
> + * @dr_mode: Pointer to the given dual role mode
> + *
> + * The function gets enum usb_dr_mode, and returns the correspondig stri=
ng.
> + */
> +extern const char *usb_dr_mode_to_string(const enum usb_dr_mode dr_mode);

Don't you need a stub for builds when CONFIG_USB_COMMON=3Dn?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl0jMA8ACgkQzL64meEa
mQaUFg//QWlWyc/qxvrzfDBRMXPr5QDNjbUZHa9wXB+i7lbjwfD6zeSDQ/+lBsKD
9acBMn7YWt/2yFkosxGcKfC9f+hsUG+6guZip1R/PzZhewlGN5Sp5U1ewwudX6ou
UjBKHgejELNxQw0pt0L++ZKtdFZVVU3RMtqSVtVWV1dDAYjqFX1oc3xD1a4Y8tyC
Zi5pp4OelMEAKJ0sFAMxsbGia5NVm9svKw+sNJHusfQebGQ9rFuLT3MVY0+0WQFH
2JeSLT0ov0z5xOYEYTg0yK41VnhCzmCnXjAnYsmq54xrrtguZJu1tI85Fo+G1TsX
zMuFy7jjdDjVB6xCpORokR5Z64ZzuIAa2Vp8KxXkc6kCzsKQtx9EFuMXewMqdKHe
6tIUbXJm+/syBd8AXKrChLPmycs6rXyD1UB3Y5Du+546nGMK1RnJXWf4BKCG6tYS
KyMJy0ZPTOBV0RaJ+3VgMyoWD4wo5PHIcuGu/laBfUyoigbaLwOOQwkIEHh3LJA2
0Do23Glk5n9HxeB70/dvi3TUbaTdbDsI1rKlLnbKrBbSlXS+F5mnp+7yRkA6kGIc
zh+f3CIVxSTRSeG+NGI0CfGGPFwP/BkjyvCja+jhzSvFl0wl+wIK0JNOx/x49NdS
8yzttpCKWZQuKruRQKTUJ/Hwlo54Mry/y+Kt5Rj0tXEK+zBthF0=
=cRnm
-----END PGP SIGNATURE-----
--=-=-=--

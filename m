Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED32C606AC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 11:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16C1520665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 11:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730408AbfGHLPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 07:15:51 -0400
Received: from mga05.intel.com ([192.55.52.43]:36048 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727671AbfGHLPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 07:15:51 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jul 2019 04:15:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,466,1557212400"; 
   d="asc'?scan'208";a="170258470"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by orsmga006.jf.intel.com with ESMTP; 08 Jul 2019 04:15:46 -0700
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
In-Reply-To: <BYAPR07MB4709E5BA041BBDDB70E69F62DDF60@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1562324238-16655-1-git-send-email-pawell@cadence.com> <1562324238-16655-6-git-send-email-pawell@cadence.com> <87r274lmqk.fsf@linux.intel.com> <BYAPR07MB4709EF3753AC0B87606B1182DDF70@BYAPR07MB4709.namprd07.prod.outlook.com> <87a7dpm442.fsf@linux.intel.com> <BYAPR07MB4709E5BA041BBDDB70E69F62DDF60@BYAPR07MB4709.namprd07.prod.outlook.com>
Date:   Mon, 08 Jul 2019 14:15:42 +0300
Message-ID: <874l3wn5ep.fsf@linux.intel.com>
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

Pawel Laszczak <pawell@cadence.com> writes:
> Please look at the changes in drivers/usb/common/common.c file.=20
> I'm going to add it as next patch to next version.
>=20=20
>
>>Pawel Laszczak <pawell@cadence.com> writes:
>>>>> +void cdns3_role_stop(struct cdns3 *cdns)
>>
>>>>> +static const char *const cdns3_mode[] =3D {
>>>>> +	[USB_DR_MODE_UNKNOWN]		=3D "unknown",
>>>>> +	[USB_DR_MODE_OTG]		=3D "otg",
>>>>> +	[USB_DR_MODE_HOST]		=3D "host",
>>>>> +	[USB_DR_MODE_PERIPHERAL]	=3D "device",
>>>>> +};
>>>>
>>>>don't we have a generic version of this under usb/common ?
>>>>
>>> Yes, there is a similar array, but it is defined also as static
>>> and there is no function for converting value to string.
>>> There is only function for converting string to value.
>>
>>right. You can add the missing interface generically instead of
>>duplicating the enumeration.
>>
>>> There is also:
>>> [USB_DR_MODE_UNKNOWN]		=3D "",
>>> Instead of:
>>> [USB_DR_MODE_UNKNOWN]		=3D "unknown",
>>>
>>> So, for USB_DR_MODE_UNKNOWN user will not see anything information.
>>
>>But that's what "unknown" means :-) We don't know the information.
>>
>
> ////// start
> commit 607754c60fabc43408f4f2de82d3560c72870787 (HEAD)
> Author: Pawel Laszczak <pawell@cadence.com>
> Date:   Mon Jul 8 12:53:47 2019 +0200
>
>     usb:common  Added usb_get_dr_mode_from_string and usb_dr_mode_to_stri=
ng.

This would read better as:

      usb: common: Add usb_get_dr_mode_from_string and usb_dr_mode_to_strin=
g.

>
>     Patch introduces new function usb_dr_mode_to_string for converting du=
al role
>     mod to string and removes static from usb_dr_mode_to_string definitio=
n.
>
>     Both changes have made to avoid duplication of code by cdns3 driver.
>
> diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
> index 18f5dcf58b0d..ab59954deff8 100644
> --- a/drivers/usb/common/common.c
> +++ b/drivers/usb/common/common.c
> @@ -118,13 +118,20 @@ static const char *const usb_dr_modes[] =3D {
>         [USB_DR_MODE_OTG]               =3D "otg",
>  };
>
> -static enum usb_dr_mode usb_get_dr_mode_from_string(const char *str)
> +/**
> + * usb_get_dr_mode_from_string - Convert string to dual role mode.
> + * @str: Pointer to the given string
> + *
> + * The function gets string and returns the correspondig enum usb_dr_mod=
e.
> + */
> +enum usb_dr_mode usb_get_dr_mode_from_string(const char *str)
>  {
>         int ret;
>
>         ret =3D match_string(usb_dr_modes, ARRAY_SIZE(usb_dr_modes), str);
>         return (ret < 0) ? USB_DR_MODE_UNKNOWN : ret;
>  }
> +EXPORT_SYMBOL_GPL(usb_get_dr_mode_from_string);
>
>  enum usb_dr_mode usb_get_dr_mode(struct device *dev)
>  {
> @@ -139,6 +146,21 @@ enum usb_dr_mode usb_get_dr_mode(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(usb_get_dr_mode);
>
> +/**
> + * usb_dr_mode_to_string - Convert dual role mode to stringi.

s/stringi/string

> + * @dr_mode: Pointer to the given dual role mode
> + *
> + * The function gets enum usb_dr_mode, and returns the correspondig stri=
ng.
> + */
> +const *char usb_dr_mode_to_string(const enum usb_dr_mode dr_mode)
> +{
> +       if (dr_mode > USB_DR_MODE_UNKNOWN || dr_mode <=3D USB_DR_MODE_PER=
IPHERAL)
> +               return usb_dr_modes[dr_mode];
> +
> +       return usb_dr_modes[USB_DR_MODE_UNKNOWN];
> +}
> +EXPORT_SYMBOL_GPL(usb_dr_mode_to_string);

missing prototype in a header file.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl0jJd4ACgkQzL64meEa
mQb97A/9Hr4c2WZCaadxHiinggvMFi2lLiT1SA8SJHF0rmBdR2bcFHuzEI+TfiAG
Mj+gtOn30UcnuFrbUcx/3fuca98a/5qsAxBaZK2EIEjx/+9nLt4myJhtYxVy+2eE
MDtAED95JbLTTUiG79QsnuzJMx0FvxwOXiurZM3wsQ6+lQgBl4Y3Blhaj0IL9H6L
AojjsFeRzeb2hjZnAESGWPDb3I0CW71Niei3IPh4zpijtNNNllcA2TZRSDIr9PZI
8LhUtsuCPn1kopHVyf91wO3+uAIGpw4NjxIl76shwT+cmAFnfU9KiWGiz7JPe0Z0
wxwEcYFwTisfe2/8uIg3iuExi2bg6NMAI8w/VG/sbx6RiYg9nSRpIf2vZwwNWMHo
Ezr1U/jfsnJ/o5NNbHRg04r/cdSmQrLfD72IjAwZfI5z+QJlXOX0FmtuQbOqu3ba
NM1a65Viae2/DQRwO9wd9WNGOFg6PgP0B7ZFXAd0XdC+tOuw/pSwN9tQJwrDliLJ
rKf5qwxc3C7KLSttcf7wxpir5CxOd5LFereBR7KZdTbWXkq/aHP0LSOBc2fLO31N
0ZgoyPPXApzm8jayvYYZ9qSph3I+7Iu5XvenMi90HrFuZCuTRxAVPWaM3nkKEbRf
QqvLPB/9qqiaIB0lXMb0fC8uzXDg4+UoP6lRqLRxVPvrVVyHiJc=
=xS1w
-----END PGP SIGNATURE-----
--=-=-=--

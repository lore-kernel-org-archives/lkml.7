Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93269CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64EFD20830
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572341155;
	bh=QAXUs3VR9lZQY99NGtAiluxQ6rvIvoP288KOOJtt+/Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=fWdWcAJIzEfu95Leu8/ojOsfagEB3cDc+W+zyd6ftvJ3y3/7pzo2/xMmUW8iWod0o
	 qApqwygE7WGx50nSZiZrMCBnyyfLEpM7PfJuiDsifHQ3RBEIiQ51DVn84spfH6vC+K
	 mRAeNBK4lkFGCl+vpr2uYZLIU0M1AiOCLoUruaTw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732592AbfJ2JZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:25:54 -0400
Received: from mga04.intel.com ([192.55.52.120]:30668 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730793AbfJ2JZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:25:54 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 02:25:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; 
   d="asc'?scan'208";a="202786714"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by orsmga003.jf.intel.com with ESMTP; 29 Oct 2019 02:25:47 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Yu Chen <chenyu56@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jack Pham <jackp@codeaurora.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 9/9] usb: dwc3: Add host-mode as default support
In-Reply-To: <20191028215919.83697-10-john.stultz@linaro.org>
References: <20191028215919.83697-1-john.stultz@linaro.org> <20191028215919.83697-10-john.stultz@linaro.org>
Date:   Tue, 29 Oct 2019 11:25:43 +0200
Message-ID: <878sp3j42w.fsf@gmail.com>
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

John Stultz <john.stultz@linaro.org> writes:
> Support configuring the default role the controller assumes as
> host mode when the usb role is USB_ROLE_NONE
>
> This patch was split out from a larger patch originally by
> Yu Chen <chenyu56@huawei.com>
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> CC: ShuFan Lee <shufan_lee@richtek.com>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Cc: Yu Chen <chenyu56@huawei.com>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Jun Li <lijun.kernel@gmail.com>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Jack Pham <jackp@codeaurora.org>
> Cc: linux-usb@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
> v3: Split this patch out from addition of usb-role-switch
>     handling
> ---
>  drivers/usb/dwc3/core.h |  3 +++
>  drivers/usb/dwc3/drd.c  | 20 ++++++++++++++++----
>  2 files changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 6f19e9891767..3c879c9ab1aa 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -953,6 +953,8 @@ struct dwc3_scratchpad_array {
>   *		- USBPHY_INTERFACE_MODE_UTMI
>   *		- USBPHY_INTERFACE_MODE_UTMIW
>   * @role_sw: usb_role_switch handle
> + * @role_switch_default_mode: default operation mode of controller while
> + *			usb role is USB_ROLE_NONE.
>   * @usb2_phy: pointer to USB2 PHY
>   * @usb3_phy: pointer to USB3 PHY
>   * @usb2_generic_phy: pointer to USB2 PHY
> @@ -1087,6 +1089,7 @@ struct dwc3 {
>  	struct notifier_block	edev_nb;
>  	enum usb_phy_interface	hsphy_mode;
>  	struct usb_role_switch	*role_sw;
> +	enum usb_dr_mode	role_switch_default_mode;
>=20=20
>  	u32			fladj;
>  	u32			irq_gadget;
> diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
> index 61d4fd8aead4..0e3466fe5ac4 100644
> --- a/drivers/usb/dwc3/drd.c
> +++ b/drivers/usb/dwc3/drd.c
> @@ -489,7 +489,10 @@ static int dwc3_usb_role_switch_set(struct device *d=
ev, enum usb_role role)
>  		mode =3D DWC3_GCTL_PRTCAP_DEVICE;
>  		break;
>  	default:
> -		mode =3D DWC3_GCTL_PRTCAP_DEVICE;
> +		if (dwc->role_switch_default_mode =3D=3D USB_DR_MODE_HOST)
> +			mode =3D DWC3_GCTL_PRTCAP_HOST;
> +		else
> +			mode =3D DWC3_GCTL_PRTCAP_DEVICE;
>  		break;
>  	}
>=20=20
> @@ -515,7 +518,10 @@ static enum usb_role dwc3_usb_role_switch_get(struct=
 device *dev)
>  		role =3D dwc->current_otg_role;
>  		break;
>  	default:
> -		role =3D USB_ROLE_DEVICE;
> +		if (dwc->role_switch_default_mode =3D=3D USB_DR_MODE_HOST)
> +			role =3D USB_ROLE_HOST;

look at this, we now have 3 different encodings for role which DWC3
needs to understand. One is its own PRTCAP_DIR, then there USB_DR_MODE_*
and now USB_ROLE_*, can we make it so that we only have one private
encoding and one generic encoding?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl24BZcACgkQzL64meEa
mQYHkw//VOw1jqK4AnBJDOHCIzWSFS8jyfQBZHVKuUB7cq6u6e+FFwxkIdlOR1YN
cIg7lL/gk3bR+eHiuqrTE2A9gp7ocGge/aJvZfsE5d+zVIau8OlKIrnz8X25xTRf
uG9M7+GiyU2HHoC7EiOalqnP0576os4lyHmEFfomuHiax71frZiyl7DN+phJijgK
IHmEkMtd1sEA/pGi8G8b/lwGKH5nkGAR4YcvP4kx588301buiT+/kn0RZnOMPoeu
y1VMO2xP90WiVfVvqW1S5SzbaXSWxqFu7XWQGlBr9XJ678npgxk89GmPMNX3hGXh
jDlyVp5ctWedJU8fufBMAS7TMLDASZIMPtarWPWwXO+8UomuUOkOj2rUiVkDpIVQ
FCq5ldfW9Aei4f2+5mtgpQTvqYA5/uJxFxijUAFEncfQqC1h5uIf9gDgUV8p2D/8
poS2nJwimP5VYox0PV72C5gV8ZGm5WM5HdOEX67JraqrPIXWTS5omXBd86XZzDIo
gQx5LdiBgxR13WAGLFesbSC3L+Kd0/1fJYFXSMCJjIdkx0bDEgHCxG3FImokDgoK
qGlFoyxqLHnOSFYMhroMqE7AX1rHZcnQbHZhsI91a+b89plbDagvlWYbrJ7PH/MT
OOIyQZejlu6BJsmnNPfRUYS5dmDKGVkZCTdwAV42pNA84DA/+bc=
=HE73
-----END PGP SIGNATURE-----
--=-=-=--

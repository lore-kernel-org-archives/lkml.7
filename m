Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A53CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF1620717
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572340920;
	bh=Q/GVmUqtA+ZyrS1TnX8i1GwC/kcocJgrlO53nm3yVzc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=gyn30+SwgHKcUTkznZMXe/iZP7E7GNz0sklKxjhARTUnDyj/HVdnUWW9G8gk2r1xk
	 bH839r3bFVedxTXRxQ1g34PZPHTXKZ+4EFI9vOENtvJAuwaw7eCSsiRM1uOEVVEmcE
	 W/ZfBLrLxJSILf2EkRmVU/tXmvm/qDebykGOBjkc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732556AbfJ2JV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:21:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:23405 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727257AbfJ2JV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:21:58 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 02:21:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; 
   d="asc'?scan'208";a="229993798"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by fmsmga002.fm.intel.com with ESMTP; 29 Oct 2019 02:21:53 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     Yu Chen <chenyu56@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jack Pham <jackp@codeaurora.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH v4 7/9] usb: dwc3: Registering a role switch in the DRD code.
In-Reply-To: <20191028215919.83697-8-john.stultz@linaro.org>
References: <20191028215919.83697-1-john.stultz@linaro.org> <20191028215919.83697-8-john.stultz@linaro.org>
Date:   Tue, 29 Oct 2019 11:21:49 +0200
Message-ID: <87eeyvj49e.fsf@gmail.com>
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
> From: Yu Chen <chenyu56@huawei.com>
>
> The Type-C drivers use USB role switch API to inform the
> system about the negotiated data role, so registering a role
> switch in the DRD code in order to support platforms with
> USB Type-C connectors.
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
> Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Yu Chen <chenyu56@huawei.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
> v2: Fix role_sw and role_switch_default_mode descriptions as
>     reported by kbuild test robot <lkp@intel.com>
>
> v3: Split out the role-switch-default-host logic into its own
>     patch
> ---
>  drivers/usb/dwc3/Kconfig |  1 +
>  drivers/usb/dwc3/core.h  |  3 ++
>  drivers/usb/dwc3/drd.c   | 66 +++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 69 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
> index 89abc6078703..1104745c41a9 100644
> --- a/drivers/usb/dwc3/Kconfig
> +++ b/drivers/usb/dwc3/Kconfig
> @@ -44,6 +44,7 @@ config USB_DWC3_DUAL_ROLE
>  	bool "Dual Role mode"
>  	depends on ((USB=3Dy || USB=3DUSB_DWC3) && (USB_GADGET=3Dy || USB_GADGE=
T=3DUSB_DWC3))
>  	depends on (EXTCON=3Dy || EXTCON=3DUSB_DWC3)
> +	select USB_ROLE_SWITCH

so even those using DWC3 as a peripheral-only or host-only driver will
need role switch?

> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 1c8b349379af..6f19e9891767 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -25,6 +25,7 @@
>  #include <linux/usb/ch9.h>
>  #include <linux/usb/gadget.h>
>  #include <linux/usb/otg.h>
> +#include <linux/usb/role.h>
>  #include <linux/ulpi/interface.h>
>=20=20
>  #include <linux/phy/phy.h>
> @@ -951,6 +952,7 @@ struct dwc3_scratchpad_array {
>   * @hsphy_mode: UTMI phy mode, one of following:
>   *		- USBPHY_INTERFACE_MODE_UTMI
>   *		- USBPHY_INTERFACE_MODE_UTMIW
> + * @role_sw: usb_role_switch handle
>   * @usb2_phy: pointer to USB2 PHY
>   * @usb3_phy: pointer to USB3 PHY
>   * @usb2_generic_phy: pointer to USB2 PHY
> @@ -1084,6 +1086,7 @@ struct dwc3 {
>  	struct extcon_dev	*edev;
>  	struct notifier_block	edev_nb;
>  	enum usb_phy_interface	hsphy_mode;
> +	struct usb_role_switch	*role_sw;
>=20=20
>  	u32			fladj;
>  	u32			irq_gadget;
> diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
> index c946d64142ad..61d4fd8aead4 100644
> --- a/drivers/usb/dwc3/drd.c
> +++ b/drivers/usb/dwc3/drd.c
> @@ -476,6 +476,52 @@ static struct extcon_dev *dwc3_get_extcon(struct dwc=
3 *dwc)
>  	return edev;
>  }
>=20=20
> +static int dwc3_usb_role_switch_set(struct device *dev, enum usb_role ro=
le)
> +{
> +	struct dwc3 *dwc =3D dev_get_drvdata(dev);
> +	u32 mode;
> +
> +	switch (role) {
> +	case USB_ROLE_HOST:
> +		mode =3D DWC3_GCTL_PRTCAP_HOST;
> +		break;
> +	case USB_ROLE_DEVICE:
> +		mode =3D DWC3_GCTL_PRTCAP_DEVICE;
> +		break;
> +	default:
> +		mode =3D DWC3_GCTL_PRTCAP_DEVICE;
> +		break;
> +	}
> +
> +	dwc3_set_mode(dwc, mode);
> +	return 0;
> +}

role switching is starting to get way too complicated in DWC3. We now
have a function that queues a work on the system_freezable_wq that will
configure PHY and change PRTCAP. Is there a way we can simplify some of
this a little?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl24BK0ACgkQzL64meEa
mQY9/w/8Dif+Ozfqt8XOrrwyG/De+CLq3qGVGmgTDMdjdKzDVTMi3jd2IMxrVpW5
oniCtQG26Hqn5+a+UdvAnSsxvaKpMtFrM5mWHkpbNOWRD/VQBO2c4NhjrhgJdk+G
v+8sMCAp99sGSuoxmHds7MDWRF0TXZB+r8wCDeegsbcoKq5KHsWmYjlT/Svgosbc
+8C1GGsRM9ryFJohV90Mq8IlWRzyY+OdRhiEavPZIuoMDCZg2vv5fVkqPrKOw3e7
vjtRwmupFK0mKAvJfeHR4ToQuJxCqsltHIe6WrLuxXPB3tCRE1gKowX50ngWrVbs
LorqGk48ZOawe+8c5WmlzILqWuo5Kaa08cQTIJiewP2ZKnMt6YhpZvnrq3WD9vb1
ULQNuhqdWn6fVozm7LMKjssnwZhCkJ5uYrXuX+3aKZ9IBvNLw7HH/WlLOdLhjrIp
b1jHyTZ6jg74ONTEJX+sTdPx0lIq68OP58aC75fF4j8ehVCvK2HN0JTyt1Lu7I0z
zOv1F0bWhg9YK2YKryWToeVZzVrpIPBvxe1crEnaXPyEAthb8b8g3/h9ARO92s9y
OA00DY7JLuJ6Gb54ojyaNHICeq6ARTBhEXoJwAF6l/z67RmJSu6MOqaLPjHTyOds
4xytyZRTp2GKsjzXBCH4JzanI7TASvCmWZ8+xz35WlJOC/YkMxs=
=ReFr
-----END PGP SIGNATURE-----
--=-=-=--

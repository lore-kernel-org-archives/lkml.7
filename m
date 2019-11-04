Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D022DCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 10:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0EB3217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 10:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ljq41sxt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbfKDKEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 05:04:24 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8553 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfKDKEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 05:04:24 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dbff7a30000>; Mon, 04 Nov 2019 02:04:19 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 04 Nov 2019 02:04:13 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 04 Nov 2019 02:04:13 -0800
Received: from localhost (10.124.1.5) by HQMAIL107.nvidia.com (172.20.187.13)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 Nov 2019 10:04:12
 +0000
Date:   Mon, 4 Nov 2019 11:04:10 +0100
From:   Thierry Reding <treding@nvidia.com>
To:     Mao Wenan <maowenan@huawei.com>
CC:     <felipe.balbi@linux.intel.com>, <gregkh@linuxfoundation.org>,
        <nkristam@nvidia.com>, <arnd@arndb.de>, <johan@kernel.org>,
        <krzk@kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH -next] usb: gadget: Add dependency for USB_TEGRA_XUDC
Message-ID: <20191104100410.GB996639@ulmo>
References: <20191104025945.172620-1-maowenan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20191104025945.172620-1-maowenan@huawei.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Content-Disposition: inline
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1572861859; bh=pCb+z06L0ETuNYTJDOm+4rg79psSuPgK4MhE+W8WrEE=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:In-Reply-To:X-NVConfidentiality:User-Agent:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Disposition;
        b=ljq41sxtB1oQypuQA3YWd9sQ1Rq9QatqdydOfgWSZVfbjQlQD12696ANzadS5IWNa
         wyFsmhpXPCgPUYWi92fBwUKfeZXhByL9FIMJuVw/Q8Rqe/TA0lyWiMQ/W7OiZnMKcb
         SSiDU2MRlicblBz8J+jo7OPwdo1IyE6P30O5ovQA7KOmLrILHoQjMFCF2BB1btWJTU
         NfJe8uEeQMwXfsQ9t79nZyFM4Pvomc8YN0kRu+GKqWLaswVjx9Xo/yYOkG3iLjFz8R
         Ev03r50HBwhvC9y0n4waibelATTyHWXMCKJeOWengoUOmkXmnvOR7zwkZ2+74jP7Vk
         Zbc5w/bx8mtgg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 04, 2019 at 10:59:45AM +0800, Mao Wenan wrote:
> If CONFIG_USB_TEGRA_XUDC=3Dy and CONFIG_USB_ROLE_SWITCH=3Dm,
> below erros can be seen:
> drivers/usb/gadget/udc/tegra-xudc.o: In function `tegra_xudc_remove':
> tegra-xudc.c:(.text+0x6b0): undefined reference to `usb_role_switch_unreg=
ister'
> drivers/usb/gadget/udc/tegra-xudc.o: In function `tegra_xudc_probe':
> tegra-xudc.c:(.text+0x1b88): undefined reference to `usb_role_switch_regi=
ster'
> drivers/usb/gadget/udc/tegra-xudc.o: In function `tegra_xudc_usb_role_sw_=
work':
> tegra-xudc.c:(.text+0x5ecc): undefined reference to `usb_role_switch_get_=
role'
>=20
> This patch add dependency USB_ROLE_SWITCH for UDC driver.
>=20
> Fixes: 49db427232fe ("usb: gadget: Add UDC driver for tegra XUSB device m=
ode controller")
> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> ---
>  drivers/usb/gadget/udc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kcon=
fig
> index acaec3a..d103154 100644
> --- a/drivers/usb/gadget/udc/Kconfig
> +++ b/drivers/usb/gadget/udc/Kconfig
> @@ -445,6 +445,7 @@ config USB_TEGRA_XUDC
>  	tristate "NVIDIA Tegra Superspeed USB 3.0 Device Controller"
>  	depends on ARCH_TEGRA || COMPILE_TEST
>  	depends on PHY_TEGRA_XUSB
> +	depends on USB_ROLE_SWITCH

It looks like most other drivers that use the USB role switch class do
"select" here. Now, that's suboptimal because USB_ROLE_SWITCH is a user-
visible symbol, which can lead to conflicts, so it should be avoided. I
think that in this case it might make sense to hide USB_ROLE_SWITCH and
then convert all "depends on USB_ROLE_SWITCH" occurrences to "select
USB_ROLE_SWITCH". The USB role switch class is, after all, not useful by
itself. It always needs a host and/or gadget driver to make use of it.

Thierry

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2/95oACgkQ3SOs138+
s6G6Hw/+MwXbPl4Nl23tpV771SIh5i78tZMTS7HWFmkz2bqKh2QCt+zZErVhAOFy
Uzp/fshw7u2de/UTR8K6tVXTLCBcAaTVkhJavegV1JrP6kIRRlxY1eZFbm+xZNl2
yggSDJ306dOO5MWft0+D7G0n44bQ9b8Lp8sqkmOzBdkWkMfXJ1AhZb8qmr4wHa+R
oUImWgRQrR6l3hel8VPclnMA8iiNATOtO9MTpV4zpzfPYAVPr2KCg0eAjpy5WGrq
KYoyBXJ6+TnpjXP1yw9LfyJe9cNrOK1Y1D7OHb6UEGEh4WPVtuoeaZZcmesJ4mAx
e6/ihG69puadQ0GDeJl2G6BJQDlfv4cLyWHHjWgqaVxu6Ey+wFYJ/V/bBMJOoIoE
sH8CUK3XmvtQ3o0sXdRZQnkn4c++VsLmNesQStUKpwBXHVASi6CJns+6TxkFbmeG
JDYiPQ1Ehk5QmCFPUf3rsb3bUxxgKgmV84ZsRer+gecz+1zaYZu06XJWxVdhxNVK
BmE2yZr6GFAXJfB5EJpN3xV1uhDW++3EQrFaM4GsGscZyEsO2v59YE3S9/9oWf/2
rkpAPzMTIHbWX/reXoFIgMoN3G8kaO7JN8Pam+0xMmzKovTKrY1mvSow1NuUof9p
LGVJjBVRG+cFPcDCpewSO99+cl7MENXYMnF08rE/G5gc53/62P8=
=WqfB
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--

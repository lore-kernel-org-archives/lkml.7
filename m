Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13B1CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F6E21D71
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="hZg7xhcV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbfKDNxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 08:53:17 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:1353 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728613AbfKDNxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 08:53:17 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dc02d510000>; Mon, 04 Nov 2019 05:53:21 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 04 Nov 2019 05:53:15 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 04 Nov 2019 05:53:15 -0800
Received: from localhost (10.124.1.5) by HQMAIL107.nvidia.com (172.20.187.13)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 Nov 2019 13:53:14
 +0000
Date:   Mon, 4 Nov 2019 14:53:12 +0100
From:   Thierry Reding <treding@nvidia.com>
To:     maowenan <maowenan@huawei.com>
CC:     <felipe.balbi@linux.intel.com>, <gregkh@linuxfoundation.org>,
        <nkristam@nvidia.com>, <arnd@arndb.de>, <johan@kernel.org>,
        <krzk@kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH -next] usb: gadget: Add dependency for USB_TEGRA_XUDC
Message-ID: <20191104135312.GD996639@ulmo>
References: <20191104025945.172620-1-maowenan@huawei.com>
 <20191104100410.GB996639@ulmo>
 <51315499-99d0-eca3-a7df-b8dd84628bbd@huawei.com>
MIME-Version: 1.0
In-Reply-To: <51315499-99d0-eca3-a7df-b8dd84628bbd@huawei.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AkbCVLjbJ9qUtAXD"
Content-Disposition: inline
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1572875601; bh=qmstqNnitagwe9Gh3+JKuCR7mgFkmxx17qK8U75Cw6s=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:In-Reply-To:X-NVConfidentiality:User-Agent:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Disposition;
        b=hZg7xhcVOmG4AYhhyiltf3vBKHI/Y7BGPX1wpRMSIWXGJp2JSp/5awrLBSarCOEGc
         w1bsMGT3rnepKLZ6FPlsMUApnBX5A43zzAUBmj1wPjRiPP7/yuwWox3xkqQcl9cMY6
         N8eApCjGvtMwaWkZ1R6BLG4sMVnVRrAdd74cezt26QlB3Z4fvTIx58JPx1HEGu5lot
         nuU69NJKVP8kCstn8D98wV7gfXDZSbQRO4GPS6fy7equnhSHYw9ynJp38s4BVW3esZ
         Clo8UI2ueAo+92oMRYah4Jwxl81mNvkvoXvritY2Ja5cjs6RnxMaIMFEgt2tfuJFGM
         JKKefOA0RkPtw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--AkbCVLjbJ9qUtAXD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 04, 2019 at 06:50:01PM +0800, maowenan wrote:
>=20
>=20
> On 2019/11/4 18:04, Thierry Reding wrote:
> > On Mon, Nov 04, 2019 at 10:59:45AM +0800, Mao Wenan wrote:
> >> If CONFIG_USB_TEGRA_XUDC=3Dy and CONFIG_USB_ROLE_SWITCH=3Dm,
> >> below erros can be seen:
> >> drivers/usb/gadget/udc/tegra-xudc.o: In function `tegra_xudc_remove':
> >> tegra-xudc.c:(.text+0x6b0): undefined reference to `usb_role_switch_un=
register'
> >> drivers/usb/gadget/udc/tegra-xudc.o: In function `tegra_xudc_probe':
> >> tegra-xudc.c:(.text+0x1b88): undefined reference to `usb_role_switch_r=
egister'
> >> drivers/usb/gadget/udc/tegra-xudc.o: In function `tegra_xudc_usb_role_=
sw_work':
> >> tegra-xudc.c:(.text+0x5ecc): undefined reference to `usb_role_switch_g=
et_role'
> >>
> >> This patch add dependency USB_ROLE_SWITCH for UDC driver.
> >>
> >> Fixes: 49db427232fe ("usb: gadget: Add UDC driver for tegra XUSB devic=
e mode controller")
> >> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> >> ---
> >>  drivers/usb/gadget/udc/Kconfig | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/K=
config
> >> index acaec3a..d103154 100644
> >> --- a/drivers/usb/gadget/udc/Kconfig
> >> +++ b/drivers/usb/gadget/udc/Kconfig
> >> @@ -445,6 +445,7 @@ config USB_TEGRA_XUDC
> >>  	tristate "NVIDIA Tegra Superspeed USB 3.0 Device Controller"
> >>  	depends on ARCH_TEGRA || COMPILE_TEST
> >>  	depends on PHY_TEGRA_XUSB
> >> +	depends on USB_ROLE_SWITCH
> >=20
> > It looks like most other drivers that use the USB role switch class do
> > "select" here. Now, that's suboptimal because USB_ROLE_SWITCH is a user-
> > visible symbol, which can lead to conflicts, so it should be avoided. I
> > think that in this case it might make sense to hide USB_ROLE_SWITCH and
> > then convert all "depends on USB_ROLE_SWITCH" occurrences to "select
> > USB_ROLE_SWITCH". The USB role switch class is, after all, not useful by
> > itself. It always needs a host and/or gadget driver to make use of it.
> >=20
>=20
> Thanks, I send v2 and change 'depends on' to 'select' for this patch.

Great, can you also follow up with a patch to hide the USB_ROLE_SWITCH
option so that we can avoid any of the pitfalls associated with user-
visible symbols and "select"?

Thierry

--AkbCVLjbJ9qUtAXD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl3ALUgACgkQ3SOs138+
s6FPmxAAiLkvZmH6WxxECfBraeXgrnYbOZ57nQ8la5FefdC72v96CbsGbHZkiEwU
HWT4vwaX6QEXHypUWQ86McqO4UNaGtohXcNlhn9X867z/aH1LzYhhLMYAgQpmhVs
a8HZ4q36s6BIIgrrvF2cvM5ax78SlNxVheWWDj+cyXdKa25ykwUGAdRvDcCzz7VL
rk/iJhyoNIZLIKtwP+QrEIjVYCfqN7od2nBIP6WewhPKzQA/DtRu1mC0bmr90Fgk
ApzrC8+iXabXh+RIiyG2+8XTHdQo0Sui5V35KClrWelhokF8AKPejuyTdGOd3O/J
m7cFSJhPWed9el5rWyY1UcURL9jzCSQ3Cv9ZVUQdhMSXKAf24wirP2OXgMjrq1Sg
VD6v2BuZer4wY92iPhQ3zRXy/YLxclv94Kn7t4L8aXH6fc0QE09njcGFq/kazmS/
2HoGlBeRIQRNtwWVlEI+U1fbi4HIbhhgLxfcU/OIfQuVFqWB1hzBY38aXLDvF/2w
RKZE1CdrxfbM/xGzhhx75LuPfPKnyUUu/MdcNBqwpNpJ9TpTnymqIth9BYSmTGIb
0rFc14nxRD+KVrinSOWLvPjs5acQXGUEQ8YmcVEqK1i1Q121aQNqWdAK++ls84UU
z5S5G58ui0C2jyBdvY0utpnaILNB4f9gg7z6wehixGdqUUHReks=
=vxGA
-----END PGP SIGNATURE-----

--AkbCVLjbJ9qUtAXD--

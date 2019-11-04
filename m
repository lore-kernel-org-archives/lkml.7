Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E651ACA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6FBF21850
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="RNb0D6uZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbfKDNwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 08:52:10 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17872 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbfKDNwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 08:52:10 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dc02d100000>; Mon, 04 Nov 2019 05:52:16 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 04 Nov 2019 05:52:09 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 04 Nov 2019 05:52:09 -0800
Received: from localhost (10.124.1.5) by HQMAIL107.nvidia.com (172.20.187.13)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 Nov 2019 13:52:08
 +0000
Date:   Mon, 4 Nov 2019 14:52:06 +0100
From:   Thierry Reding <treding@nvidia.com>
To:     Mao Wenan <maowenan@huawei.com>
CC:     <felipe.balbi@linux.intel.com>, <gregkh@linuxfoundation.org>,
        <nkristam@nvidia.com>, <arnd@arndb.de>, <johan@kernel.org>,
        <krzk@kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH v2 -next] usb: gadget: Add dependency for USB_TEGRA_XUDC
Message-ID: <20191104135206.GC996639@ulmo>
References: <51315499-99d0-eca3-a7df-b8dd84628bbd@huawei.com>
 <20191104112104.195329-1-maowenan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20191104112104.195329-1-maowenan@huawei.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ghzN8eJ9Qlbqn3iT"
Content-Disposition: inline
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1572875536; bh=EMPoEOElUsmMuC+l1ro0kDFU0scdlmObTBa4bPNcgXg=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:In-Reply-To:X-NVConfidentiality:User-Agent:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Disposition;
        b=RNb0D6uZoBCc3vEMuhigkLSfCpse19eP7ynLRH6a34qzJmZnot+rOo0TnCgUC9IOq
         RCg7FMtLp3kq8qQxBMr83X3U52KSXFtQBAdYzZHQH1HCceDn3b6qxsp4ayLQbpORsQ
         NSauELLs5S5dEHvRg1rSOK0M8LHVmlQGWaXgDlhDwKbE2y9/DVkmSFnhcFHzFOcx+Q
         Gg2mExEeDaJ48w4PL92SCxNKjy/qDs8wy2qN8mR/H9jx0ms2z1DMU0LHAzkQKb6lX8
         1J8D1scj0grLnMsIOOMDCOt/wQ/TDNedsr5+m5dRRBrJtf81zLBVX7bsJu1pSbRkWz
         z/+TtCyz1C+tw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--ghzN8eJ9Qlbqn3iT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 04, 2019 at 07:21:04PM +0800, Mao Wenan wrote:
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
> It should select USB_ROLE_SWITCH for UDC driver.
>=20
> Fixes: 49db427232fe ("usb: gadget: Add UDC driver for tegra XUSB device m=
ode controller")
> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> ---
>  v2: change 'depends on' to 'select'.
>  drivers/usb/gadget/udc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--ghzN8eJ9Qlbqn3iT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl3ALQIACgkQ3SOs138+
s6H4mg/+JHWEkuLTNigJyfp1Fjx7x2mGnheiPjW550oNaDoo3GpF7pINZlHqjtc9
hJxkSAdR65ftvqZTUqK/f/GkvPd2BaRVybDYPqrdTMkhGyRx4miIZSP1TYAlQBZM
57PQOwSvsiVQKViu/VAppUsWE36f+7io6SsaLr0ZHdg5G6Xjk8UOmtRyVDF2mX/e
X4+vY/PDf3wZZEKkS7qdmlaKAPsaeIFBmkkTxeTqc1tTuW54vlxAKjQ3EQBpvqGO
wFKUArJbdV9To+Yda+lN37QRyCJoBwJlnYgTlGemL9HnP0BzHBMCxQjZmBKVC0k8
pas1KFhNsen8mvuW3/MMSOP5ZZtCliBs4jxl3x5wd4g5/B+x68w3j9Mpd8JPB0Cg
uiO0qf5op2XdTKDlaQT1I1pDRvoO73qIvoMUG9ndfSJKXekERTuudQsvXoJsmSvW
L2lLIjPpGvNrVKU0L1GvdbYPL7moMGfVmlHZ+V2JtjukWClvr62j51AcfuPk5ipZ
TKosiVA9exPqVFfVvUCurgd71zi4j28gDskjD+DiZmQGuBh54FMX6iSoh3G+ysoa
suMYYtS29TtZxLywcv4SO7Fp2IPVvozI02V6phPfTiM+jMwQZMSjvptkvIxzkUdH
Wxg2KML8agl7DtsrbENTnSt/cvwUyvK6w1I+uenWB1Ki1VgbnAQ=
=3NDW
-----END PGP SIGNATURE-----

--ghzN8eJ9Qlbqn3iT--

Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B733C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F7F721916
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfCUVmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 17:42:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:59218 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725999AbfCUVmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 17:42:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 899E0AEC6;
        Thu, 21 Mar 2019 21:42:49 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     benniciemanuel78@gmail.com, linux-kernel@vger.kernel.org
Date:   Fri, 22 Mar 2019 08:42:39 +1100
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Joe Perches <joe@perches.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Mamta Shukla <mamtashukla555@gmail.com>
Subject: Re: [PATCH] staging: mt7621-pci: Add spaces to Macros in pci-mt7621.c
In-Reply-To: <20190321202301.806-1-benniciemanuel78@gmail.com>
References: <20190321202301.806-1-benniciemanuel78@gmail.com>
Message-ID: <87h8bv7vlc.fsf@notabene.neil.brown.name>
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

On Thu, Mar 21 2019, Emanuel Bennici wrote:

> Apply Kernel Coding Style to pci-mt7621.c by adding Tabs

which part of Coding Style are you applying here?
All these macros already are perfectly lined up with Tabs.
You are adding an extra Tab to each line - why?

Thanks,
NeilBrown

>
> Signed-off-by: Emanuel Bennici <benniciemanuel78@gmail.com>
> ---
>  drivers/staging/mt7621-pci/pci-mt7621.c | 70 ++++++++++++-------------
>  1 file changed, 35 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt=
7621-pci/pci-mt7621.c
> index 379ae780c691..c5d9b7204aef 100644
> --- a/drivers/staging/mt7621-pci/pci-mt7621.c
> +++ b/drivers/staging/mt7621-pci/pci-mt7621.c
> @@ -34,16 +34,16 @@
>  #include "../../pci/pci.h"
>=20=20
>  /* sysctl */
> -#define MT7621_CHIP_REV_ID		0x0c
> -#define CHIP_REV_MT7621_E2		0x0101
> +#define MT7621_CHIP_REV_ID			0x0c
> +#define CHIP_REV_MT7621_E2			0x0101
>=20=20
>  /* MediaTek specific configuration registers */
> -#define PCIE_FTS_NUM			0x70c
> -#define PCIE_FTS_NUM_MASK		GENMASK(15, 8)
> -#define PCIE_FTS_NUM_L0(x)		((x) & 0xff << 8)
> +#define PCIE_FTS_NUM				0x70c
> +#define PCIE_FTS_NUM_MASK			GENMASK(15, 8)
> +#define PCIE_FTS_NUM_L0(x)			((x) & 0xff << 8)
>=20=20
>  /* rt_sysc_membase relative registers */
> -#define RALINK_PCIE_CLK_GEN		0x7c
> +#define RALINK_PCIE_CLK_GEN			0x7c
>  #define RALINK_PCIE_CLK_GEN1		0x80
>=20=20
>  /* Host-PCI bridge registers */
> @@ -51,44 +51,44 @@
>  #define RALINK_PCI_PCIMSK_ADDR		0x000C
>  #define RALINK_PCI_CONFIG_ADDR		0x0020
>  #define RALINK_PCI_CONFIG_DATA		0x0024
> -#define RALINK_PCI_MEMBASE		0x0028
> -#define RALINK_PCI_IOBASE		0x002C
> +#define RALINK_PCI_MEMBASE			0x0028
> +#define RALINK_PCI_IOBASE			0x002C
>=20=20
>  /* PCICFG virtual bridges */
> -#define MT7621_BR0_MASK			GENMASK(19, 16)
> -#define MT7621_BR1_MASK			GENMASK(23, 20)
> -#define MT7621_BR2_MASK			GENMASK(27, 24)
> -#define MT7621_BR_ALL_MASK		GENMASK(27, 16)
> -#define MT7621_BR0_SHIFT		16
> -#define MT7621_BR1_SHIFT		20
> -#define MT7621_BR2_SHIFT		24
> +#define MT7621_BR0_MASK				GENMASK(19, 16)
> +#define MT7621_BR1_MASK				GENMASK(23, 20)
> +#define MT7621_BR2_MASK				GENMASK(27, 24)
> +#define MT7621_BR_ALL_MASK			GENMASK(27, 16)
> +#define MT7621_BR0_SHIFT			16
> +#define MT7621_BR1_SHIFT			20
> +#define MT7621_BR2_SHIFT			24
>=20=20
>  /* PCIe RC control registers */
> -#define MT7621_PCIE_OFFSET		0x2000
> -#define MT7621_NEXT_PORT		0x1000
> +#define MT7621_PCIE_OFFSET			0x2000
> +#define MT7621_NEXT_PORT			0x1000
>=20=20
>  #define RALINK_PCI_BAR0SETUP_ADDR	0x0010
>  #define RALINK_PCI_IMBASEBAR0_ADDR	0x0018
> -#define RALINK_PCI_ID			0x0030
> -#define RALINK_PCI_CLASS		0x0034
> -#define RALINK_PCI_SUBID		0x0038
> -#define RALINK_PCI_STATUS		0x0050
> +#define RALINK_PCI_ID				0x0030
> +#define RALINK_PCI_CLASS			0x0034
> +#define RALINK_PCI_SUBID			0x0038
> +#define RALINK_PCI_STATUS			0x0050
>=20=20
>  /* Some definition values */
> -#define PCIE_REVISION_ID		BIT(0)
> -#define PCIE_CLASS_CODE			(0x60400 << 8)
> -#define PCIE_BAR_MAP_MAX		GENMASK(30, 16)
> -#define PCIE_BAR_ENABLE			BIT(0)
> -#define PCIE_PORT_INT_EN(x)		BIT(20 + (x))
> -#define PCIE_PORT_CLK_EN(x)		BIT(24 + (x))
> -#define PCIE_PORT_PERST(x)		BIT(1 + (x))
> -#define PCIE_PORT_LINKUP		BIT(0)
> -
> -#define PCIE_CLK_GEN_EN			BIT(31)
> -#define PCIE_CLK_GEN_DIS		0
> -#define PCIE_CLK_GEN1_DIS		GENMASK(30, 24)
> -#define PCIE_CLK_GEN1_EN		(BIT(27) | BIT(25))
> -#define MEMORY_BASE			0x0
> +#define PCIE_REVISION_ID			BIT(0)
> +#define PCIE_CLASS_CODE				(0x60400 << 8)
> +#define PCIE_BAR_MAP_MAX			GENMASK(30, 16)
> +#define PCIE_BAR_ENABLE				BIT(0)
> +#define PCIE_PORT_INT_EN(x)			BIT(20 + (x))
> +#define PCIE_PORT_CLK_EN(x)			BIT(24 + (x))
> +#define PCIE_PORT_PERST(x)			BIT(1 + (x))
> +#define PCIE_PORT_LINKUP			BIT(0)
> +
> +#define PCIE_CLK_GEN_EN				BIT(31)
> +#define PCIE_CLK_GEN_DIS			0
> +#define PCIE_CLK_GEN1_DIS			GENMASK(30, 24)
> +#define PCIE_CLK_GEN1_EN			(BIT(27) | BIT(25))
> +#define MEMORY_BASE					0x0
>=20=20
>  /**
>   * struct mt7621_pcie_port - PCIe port information
> --=20
> 2.19.1

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlyUBU8ACgkQOeye3VZi
gbm0Mg//XAIJpd0a25L0R/08vcgWK55+7VzyBe46wlzaZToXb1f8dwEsduk5GUzz
kSE3NMIfxghSzmLCLiYpUmNR3SbPvBSMZbkFCi1+qpJq2UBLMajt33a48KXP220M
Zwz7aCso/D+da3KjsUGaFNCLkknyf4obq4BJq2UrRHHNKC7dd7lnHfRc18jyMRlN
dLFdI1Lc8jJmMmbgelb00iuJj3ayDVZ24ifMhiyvbrpnFGNSeH9Y30fE0WRgPnem
5yxmtx7+3cSlJgnbwzhth+AtH22A1c/lKSDJ3EykghMTBBMJDZxAEgiSuRkClA8j
sP0NZRvwrQ+BDUxeAF4q4ywbVb8VAcLYjXBWojYFOi44euKAglvork+vbr+HA5t/
m9HmIkKFTLiBst7gU+uxuQAUhEWZE2ntqWFgJHH6eI8GXjkpl6jbIw6qw6lq63B8
M7mw44upUCSUpRvRubFPkzQHwZcH7GIk0Ue9t/kz77B288jkvR+76sCOmRJHPI2l
ovyZmmv3QS/l2paTkkb0KlDjlj5AKm4QbLoIjeC47dxkSh8B6U1U6qBRm0kZOcUI
bJBq/TBvfaSBTBVso4ijIKZhvnYQtk84VtMeZAtUktac+lg+h07wuMycPYfj62qu
y/UkYFLmngNblJvYec8wJSzACd6/06/KITHouNhKMJodVoPNeTE=
=xS/I
-----END PGP SIGNATURE-----
--=-=-=--

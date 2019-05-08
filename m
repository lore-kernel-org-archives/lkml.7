Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBF4C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 05:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09BB021479
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 05:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MbZldME4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfEHFBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 01:01:49 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:37863 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfEHFBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 01:01:48 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44zPTP4n8fz9s3q;
        Wed,  8 May 2019 15:01:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557291706;
        bh=2wFeY+1zSkdLN8J5QkMn2NTFMPwSkJhfzJkMsHGAhg8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MbZldME4VSRQhUqOX8H1vyFMArsZRiympEmfZR5JqeMMEXzsiXvq9MSSq1WgWBsIQ
         zI9/uu/XaUqPUfj3Hbv7yn2GhYcBZF/LJB5K/g1/5ECu/cnkCl3JpqV1Il45GHRB8L
         6Hlo3ZYwUm3OW2xCPitzbDIBZxBiw7l/t7eY6Ko+jFciFpRKELnzaOh+mCLObtnT+D
         ZKZODQfmJA3Eualj/DayCgY6lcZICFFaFPmjkAZJQtSdPWSyAAB6Bm7hlIjz7QdU0r
         dyFYCQegn90xOdYS147MXhdMk0YHHBIt4VbsvITsoZMKXSj+YI/c5rfM5gox18Ua3s
         3qUOAzrGKOcrA==
Date:   Wed, 8 May 2019 15:01:44 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Greg KH <greg@kroah.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Patrick Venture <venture@google.com>
Subject: Re: linux-next: manual merge of the char-misc tree with the arm-soc
 tree
Message-ID: <20190508150144.76426cfd@canb.auug.org.au>
In-Reply-To: <20190430174051.038c77c8@canb.auug.org.au>
References: <20190430174051.038c77c8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/8cPpKA4fRiq1UK1fHbuMCvQ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8cPpKA4fRiq1UK1fHbuMCvQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 30 Apr 2019 17:40:51 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the char-misc tree got conflicts in:
>=20
>   drivers/misc/Kconfig
>   drivers/misc/Makefile
>=20
> between commit:
>=20
>   524feb799408 ("soc: add aspeed folder and misc drivers")
>=20
> from the arm-soc tree and commit:
>=20
>   01c60dcea9f7 ("drivers/misc: Add Aspeed P2A control driver")
>=20
> from the char-misc tree.
>=20
> I fixed it up (see below - though the additions probably want to be
> moved as in the arm-soc commit) and can carry the fix as necessary.
> This is now fixed as far as linux-next is concerned, but any non
> trivial conflicts should be mentioned to your upstream maintainer when
> your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc drivers/misc/Kconfig
> index b80cb6af0cb4,3209ee020b15..000000000000
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@@ -496,6 -496,30 +496,14 @@@ config VEXPRESS_SYSCF
>   	  bus. System Configuration interface is one of the possible means
>   	  of generating transactions on this bus.
>  =20
> + config ASPEED_P2A_CTRL
> + 	depends on (ARCH_ASPEED || COMPILE_TEST) && REGMAP && MFD_SYSCON
> + 	tristate "Aspeed ast2400/2500 HOST P2A VGA MMIO to BMC bridge control"
> + 	help
> + 	  Control Aspeed ast2400/2500 HOST P2A VGA MMIO to BMC mappings through
> + 	  ioctl()s, the driver also provides an interface for userspace mappin=
gs to
> + 	  a pre-defined region.
> +=20
>  -config ASPEED_LPC_CTRL
>  -	depends on (ARCH_ASPEED || COMPILE_TEST) && REGMAP && MFD_SYSCON
>  -	tristate "Aspeed ast2400/2500 HOST LPC to BMC bridge control"
>  -	---help---
>  -	  Control Aspeed ast2400/2500 HOST LPC to BMC mappings through
>  -	  ioctl()s, the driver also provides a read/write interface to a BMC r=
am
>  -	  region where the host LPC read/write region can be buffered.
>  -
>  -config ASPEED_LPC_SNOOP
>  -	tristate "Aspeed ast2500 HOST LPC snoop support"
>  -	depends on (ARCH_ASPEED || COMPILE_TEST) && REGMAP && MFD_SYSCON
>  -	help
>  -	  Provides a driver to control the LPC snoop interface which
>  -	  allows the BMC to listen on and save the data written by
>  -	  the host to an arbitrary LPC I/O port.
>  -
>   config PCI_ENDPOINT_TEST
>   	depends on PCI
>   	select CRC32
> diff --cc drivers/misc/Makefile
> index b9affcdaa3d6,c36239573a5c..000000000000
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@@ -54,6 -54,9 +54,7 @@@ obj-$(CONFIG_GENWQE)		+=3D genwqe
>   obj-$(CONFIG_ECHO)		+=3D echo/
>   obj-$(CONFIG_VEXPRESS_SYSCFG)	+=3D vexpress-syscfg.o
>   obj-$(CONFIG_CXL_BASE)		+=3D cxl/
>  -obj-$(CONFIG_ASPEED_LPC_CTRL)	+=3D aspeed-lpc-ctrl.o
>  -obj-$(CONFIG_ASPEED_LPC_SNOOP)	+=3D aspeed-lpc-snoop.o
> + obj-$(CONFIG_ASPEED_P2A_CTRL)	+=3D aspeed-p2a-ctrl.o
>   obj-$(CONFIG_PCI_ENDPOINT_TEST)	+=3D pci_endpoint_test.o
>   obj-$(CONFIG_OCXL)		+=3D ocxl/
>   obj-y				+=3D cardreader/

This is now a conflict between the arm-soc tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/8cPpKA4fRiq1UK1fHbuMCvQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzSYrgACgkQAVBC80lX
0GxcaQf/cAZtLueodL+eLkGlJ1HPgreyNpVRFcXvPPG43uF6ReydrQ10G+3wr5Kx
wE0lN7G+HXU0IUCTNAHTL0ygsl5RfAaMdxjQpDRfkcb88e/ynTLUtMjU5dDEQUaE
4TR2M48ZAz3rWAeqQSikGztYKfpXY47CLOlQHpKL8qPo2+baV1ThpzveIjiRH5rG
TBhLOqvFCp9wOsT/TJRPscEAtCUVjg/23YfuR60tkDydyNdkA8n3Ai5z1MhR3fgs
9uZBDrj2OTXCViIUajZItgKiFhZqFZr2fWgbLfRQaTP4UYSDqPIOgg3lWk+8CCeS
v5lVoUssXIA1HnhBCWQIN0hvxhECuQ==
=WsjF
-----END PGP SIGNATURE-----

--Sig_/8cPpKA4fRiq1UK1fHbuMCvQ--

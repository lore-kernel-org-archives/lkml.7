Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64ACC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0740214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfCLIn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 04:43:57 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42862 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfCLIn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 04:43:56 -0400
Received: from [5.158.153.52] (helo=ares.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <volker.haspel@linutronix.de>)
        id 1h3d0q-0003uF-Mi; Tue, 12 Mar 2019 09:43:53 +0100
Date:   Tue, 12 Mar 2019 09:43:48 +0100
From:   Volker Haspel <volker.haspel@linutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Han Xu <han.xu@nxp.com>, john.ogness@linutronix.de
Subject: Re: [PATCH] spi: spi-fsl-qspi: call spi_unregister_controller
Message-ID: <20190312094348.177c5dd2@ares.tec.linutronix.de>
In-Reply-To: <20190311170334.GA14368@sirena.org.uk>
References: <20190307103008.19841-1-volker.haspel@linutronix.de>
        <20190311170334.GA14368@sirena.org.uk>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/DpBpi6KJDq6E4j_vbdsovl."; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DpBpi6KJDq6E4j_vbdsovl.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Mar 2019 17:03:34 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Thu, Mar 07, 2019 at 11:30:08AM +0100, Volker Haspel wrote:
> > The driver does not clearly unregister the spi controller.
> > Therefore calling an unbind and bind again will end up in a
> > Kernel crash.
> > Each driver who calls spi_register_controller() in the probe function
> > has to call spi_unregister_controller() too. =20
>=20
> Why not change it to use devm?

Hi Mark,

I agree, this is a much nicer solution! I will test it and send a v2.

Thanks

--Sig_/DpBpi6KJDq6E4j_vbdsovl.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEu6ObeCfmxsAHs47wMVbdr+4FyroFAlyHcUQACgkQMVbdr+4F
yrr4Aw/9EJaqrDWEpEQ6sFxo+K1cHC8kHEjxdwI7hzH4z3HiaG6+jNz0CN++cpOB
4MLzMc9gN0TumYHs9ryAxu7CjHLA84MDal8yknzmcg7ejH42NDM+3ZWbPY9QBeMZ
n7R3VXRy1mPzsYFQLaM0vnulau80Sn86AyCOnCCunU1k5swPdISGSqpwnxp880Y8
RzNR7tDepbUnslAPwxGJDOs160ZqbLvDlGlFWDrueS9s4Lw/jO5T6Dq70I1DsauZ
qSvpryTdhkQSLBdc21lmBtNAePrDpgn/n4GTWKqVSjQRbSN86PhfYo1OEb2yCftK
Z9wrptc7WklrVPPs57q/SOhNe0AsbQ44InSL6qa0J588YSuEfjxkkE0R76LvJPmU
FfUs9iV7lgDpzAv7E0oUpFKKF7K62kCObhGZAPPibk1l5tAHhJmaYC74Uljy+z9o
QvDO6NXqfS21Klqvb8Ut8UeVzkkjHBpwIvmRIqFyNI5XCxlyANSmxOTt23IW6iDX
SCiT5CCi2DsL7FW0W6Qux6zwuKDZy3K2XmZGjbTo2IDiuO3k/zcuuMLXfcNePptp
/QmgQ3Krmd4kYcaMEeO8uIfg3m+6HPfPIfPYa2CYM/UKTWY6NpSW2Ub9+x77gA41
n2DGLvRdPSHXH4z9Cj47n9q6lWuhyyxy+LEu+pFZwHd91sRHIRQ=
=CNXW
-----END PGP SIGNATURE-----

--Sig_/DpBpi6KJDq6E4j_vbdsovl.--

Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BC7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B345A20857
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554105134;
	bh=zv5TUv8WJFX8fnlubsLXjXRzhfQQobOfvHozLtN2Hpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YObmpLcCEh1HOdQZwLq0xv9Roa40FTYP76oNMZ5uXnY+FZ9HqjgPYXZ64uRsBIdR3
	 v/VFmjQ9Xa6Rxs/FlIAbdZ2j/bagZFI6ubv8vXuBBDFlfXVLAPpK/lwi/jCpbBv5zo
	 oistSwiN8mXJ7YX7GjBr17VRjKdoOCFqGY1enPDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732018AbfDAHwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:52:13 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41482 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731943AbfDAHwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 03:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zv5TUv8WJFX8fnlubsLXjXRzhfQQobOfvHozLtN2Hpc=; b=ZzrcfVAkKf9VNxDp5LQcyMR8v
        urujuNCGR4zCsHcQ/YG+tYuDjVd+VqC5XxlofbVkgpo8ZKqHaCqsrvht6lHekO6paxpfzJalOisxr
        Zd/h8wI4eUBO2/1liyAuSjvlyfi3cSGkiE3bs4mPxtWSt/tgVm0lMBDLSK2/waArHxhGY=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hArj8-00089e-QW; Mon, 01 Apr 2019 07:51:31 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 7FC02440082; Mon,  1 Apr 2019 08:51:27 +0100 (BST)
Date:   Mon, 1 Apr 2019 14:51:27 +0700
From:   Mark Brown <broonie@kernel.org>
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, bbrezillon@kernel.org,
        dwmw2@infradead.org, lee.jones@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, computersforpeace@gmal.com,
        paul.burton@mips.com, stefan@agner.ch, christophe.kerello@st.com,
        liang.yang@amlogic.com, geert@linux-m68k.org,
        devicetree@vger.kernel.org, marcel.ziswiler@toradex.com,
        linux-mtd@lists.infradead.org, richard@nod.at,
        miquel.raynal@bootlin.com, juliensu@mxic.com.tw,
        zhengxunli@mxic.com.tw
Subject: Re: [PATCH 3/7] spi: Patch Macronix MX25F0A SPI controller driver
Message-ID: <20190401075127.GM2059@sirena.org.uk>
References: <1553768318-23149-1-git-send-email-masonccyang@mxic.com.tw>
 <1553768318-23149-4-git-send-email-masonccyang@mxic.com.tw>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xtx0sNU5lZ46KfgK"
Content-Disposition: inline
In-Reply-To: <1553768318-23149-4-git-send-email-masonccyang@mxic.com.tw>
X-Cookie: Use extra care when cleaning on stairs.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xtx0sNU5lZ46KfgK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2019 at 06:18:34PM +0800, Mason Yang wrote:
> Patch a MFD driver for Macronix MX25F0A SPI controller.
>=20
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>

I can't tell what this commit is supposed to do based on this commit
message which makes it hard to review :(

--xtx0sNU5lZ46KfgK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyhwv4ACgkQJNaLcl1U
h9DLegf+I4q4dklppx9CBbUDzY7TJuYMR9fUaHEJ+PERL25QB7175CTrJAMJwNUT
VYMvdLaDFLhYbL5W340U3TsnndEAr5Ad+8UyN6UKyLnDEJ9St1a+mF+s3bGIDh/y
9eoAmlwLizsthxqUJvBRh7ZhvKvwhSqfJ4AsiNFhXfq1BnPeYks5pHRtzAa2Y4Qn
2y6UJEi9pKVrl2Dd8Uer91pO51KSbeT8ScjjbDd8/mD1kTNTxejhvJyzrT2jiqnh
Zqhjwv1kZB6Nx4IvOiLD5SeRi0QPV987Z95qpDgo2EBeY81zRHEt4wcACe95mGcf
6+BzLYW9fOms8zU/qBIE5kPY923RZw==
=IEo0
-----END PGP SIGNATURE-----

--xtx0sNU5lZ46KfgK--

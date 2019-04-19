Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EC0C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9127B222CC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555698108;
	bh=XHIcc+InZcMRKE/iIosd/4j5YhM4T1flX/WIoiVT5kQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cTWWSuEUWrKz8k/CJdDTx0oV9EZjv/81KRB6/WzSPWaa4HkGSqW1sfgBKkST05Dq/
	 sf0UxWBcljwa5HWfS8s8l3KVPRgkepRuFvi/M7yJ24Nbh1LuRgY5JE3X/ZUN1yAY/8
	 Nh1cJk3duFuVkrErUmNVblAYl4eCWcWVwsscF8mw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfDSSVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:21:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38528 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbfDSSVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XHIcc+InZcMRKE/iIosd/4j5YhM4T1flX/WIoiVT5kQ=; b=KYsVljjpmQLPfwAl3i8h0MGM/
        kYFRCn8aLa0ZgoIV4aH7RKbNzPN0+Lj2IonLHA6nwqh6fmOSx8Uts3BWEp+9vi2GjcxmtY+eF4a2F
        d+y+YJm3qZxW7IliBL4eAbhD4P1ipr4kOWr+kKhGXdl9Ymdu0gskTQuwk0ebSjhjXmsbg=;
Received: from 188.29.164.213.threembb.co.uk ([188.29.164.213] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hHUqf-0008Au-6g; Fri, 19 Apr 2019 14:50:41 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id AF634441D3B; Fri, 19 Apr 2019 15:41:25 +0100 (BST)
Date:   Fri, 19 Apr 2019 15:41:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     arnd@arndb.de, robh+dt@kernel.org, mark.rutland@arm.com,
        orsonzhai@gmail.com, zhang.lyra@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] soc: sprd: Add Spreadtrum multi-channel data
 transfer support
Message-ID: <20190419144125.GQ2803@sirena.org.uk>
References: <f7edc4078b2d6f44ed5ad47c14dd58da5cc50f21.1555670768.git.baolin.wang@linaro.org>
 <64ca5af0373c35590d8ac9f2b62e3c9fa46e3551.1555670768.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KHqYxKoy+XnO4RVf"
Content-Disposition: inline
In-Reply-To: <64ca5af0373c35590d8ac9f2b62e3c9fa46e3551.1555670768.git.baolin.wang@linaro.org>
X-Cookie: Shah, shah!  Ayatollah you so!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KHqYxKoy+XnO4RVf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2019 at 06:54:32PM +0800, Baolin Wang wrote:
> On Spreadtrum platform, the audio subsystem will use the multi-channel
> data transfer controller to transfer sound stream between audio subsystem
> and other AP/CP subsystem.
>=20
> It can support 10 DAC channel and 10 ADC channel, and each channel has
> 512 bytes depth data fifo. Moreover each channel can be used DMA mode
> or interrupt mode to transfer data.

Acked-by: Mark Brown <broonie@kernel.org>

However if there's no non-audio users of this DSP then it's probably
better to just move the driver into sound/soc.

--KHqYxKoy+XnO4RVf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAly53hQACgkQJNaLcl1U
h9CrfAgAgKhtRYO2+kmMmBkcuQ/s8uuZSLrUMumTD7DYz2Vtma0W2005NnVL4HmS
VlRKRuE2DMY+czRQDuAoCZ8sAupwNKTaNFJoxdxoU10BB9j7Uf9FcWCyBM/wq+1y
WXJi9FnDo+80YMci4EJnmWihO0CBcoRle1mJKgktTn0J0XFvVdLFxh0pTYrIA4KM
rNFkryGnXfwUqRwG0+px1d8nETvQyn4TR+noq5TQZXUQvOuJTMi9aGU8/arwwt2F
bgep8AhfF77ekw2szZKHtAxjSjUfRppqzTV+rIW+Nh9ud5jks92sUlqVZVS/J8Yq
fUwNiz8qRuE2qxDpqZb1Y7wjVsluhA==
=dgnu
-----END PGP SIGNATURE-----

--KHqYxKoy+XnO4RVf--

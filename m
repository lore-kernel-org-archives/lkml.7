Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B0ECA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 19:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824C421A4C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 19:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571945553;
	bh=/qY/Kqp1YHQFdjrrH7cY66RBGGbDJJ8wiBdfBCxy0II=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KyuoCrhP5QRBpSAjyTczGplI5hiA6P+T+E/Ebzp6c58X5htvdm/kvtDk2BKW/UBtR
	 FPHk7yk0rioXHrCCVd4xqTRb0gJ6D/WaXiQnLpHlbYeMG14epAbZ3F5LYxvMotwxMY
	 OrcYPX5ayVcc2kTwMlaZmSEXn1nneLECDSBPymwc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405644AbfJXTb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 15:31:57 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54354 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732494AbfJXTb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 15:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lTuul7TgwXeA9Ghbz5R/7bfDVQxiZGtF3PKzuNptlLQ=; b=gECSwfOZ7/f2ONTAalZGsPJpT
        RH0nFXIJbGATQ4dHCHdhS1N6yGiS0Wdu4rR9VqvC4F6ApYi+dcn56+c9lXhCQEOKFRkgtFHWrq/uy
        04Aqni5w/hpDDRPZch3UxLbXnpYtaHPllUlnq7Ca0EAKbGklZ6Od8BNQWvQZmWqrf0rdI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iNipu-0003ze-Cx; Thu, 24 Oct 2019 19:31:54 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id D6BFA274293C; Thu, 24 Oct 2019 20:31:53 +0100 (BST)
Date:   Thu, 24 Oct 2019 20:31:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pascal Paillet <p.paillet@st.com>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 0/1] Enable stm32_pwr regulator driver for stm32mp157
Message-ID: <20191024193153.GL46373@sirena.co.uk>
References: <20191024154121.8503-1-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FxavXfDenm+F7xE/"
Content-Disposition: inline
In-Reply-To: <20191024154121.8503-1-p.paillet@st.com>
X-Cookie: Filmed before a live audience.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FxavXfDenm+F7xE/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2019 at 05:41:20PM +0200, Pascal Paillet wrote:

> Enable the STM32 PWR regulator driver for stm32mp157 machine.

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--FxavXfDenm+F7xE/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2x/CkACgkQJNaLcl1U
h9BxkQf/WRgcuq2/+kReBuvdqevH/9DkhUJYjZIbFkXlaaWYqaUrYdDfbDAY+nYa
P2vzQh6utFbrvk4h3oC3QEOJlNSm0JKBcvTQF9t3/G3MurCCEYD/49i1OSJCdl0p
GcnyWnaheaO6jlSfYf92tGsRTetAFiUBxyMKvYRoKSu1i6701KtV1/CdUaOceNFS
1SKDUbeq/Y9ZfrzIUePmiM/syu1T/trfsOaH9scEiWAaHBEdxF7lddMPe2OOju+k
8AGCyrZ9y1ibX9fY4zMA3SYN3hm93kYI9/B1etslWK4D9u6cYDzdY3mrUaJPKZCa
MeCMSEjq/i9zEuKLAY31BLEGVift9Q==
=bSjw
-----END PGP SIGNATURE-----

--FxavXfDenm+F7xE/--

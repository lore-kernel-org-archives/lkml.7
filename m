Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4523DC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E6AF20883
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559050002;
	bh=MaqgcW6nL9RipUjfYMmDV89IlHXx7ZoyjtJFiqTck/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yU65fhhLyZ1M+xl7XFxdpFKHhS4g43ZyEbpnLtOJ8jZFVAFFtODgZyVGL0xCbtZox
	 b6icSQFDhTUqiD4mujEEI2HJuFv7a1sRImE1Sqj/DIaFdzwH0eSSR1iDzWqWZAAAOT
	 j/15P2yRnRK6ZPSl8PBb4jhmGX8NdIqMmAqWIkCY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfE1N0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 09:26:41 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43462 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfE1N0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 09:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=v+Z1R+Iyc3P0HugccnvG8WNIqOUHRpGpClXvCccCpcQ=; b=jzo5SZZBqDaLIZNrP1iMNepJv
        nQwqeGdVBggb9XPerGWoJuIcs2PnLAJxDWApUrS93wtxO7gILMbhNFV3B4Dj/1ZQCPIKDSDaPkdAg
        rzwDjCDIPVSWg7eFVkfSh/h6rS9e8JSUADmKxmYSdBtKqwLN/uW60iriNXuMfQfIUi39s=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hVc7c-0002VH-UU; Tue, 28 May 2019 13:26:32 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 22EBF440046; Tue, 28 May 2019 14:26:32 +0100 (BST)
Date:   Tue, 28 May 2019 14:26:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Duan <fugang.duan@nxp.com>
Cc:     "david@lechnology.com" <david@lechnology.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        Robby Cai <robby.cai@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Issue: regmap: use debugfs even when no device
Message-ID: <20190528132632.GJ2456@sirena.org.uk>
References: <VI1PR0402MB3600F0FB1A031BE502588C93FF1E0@VI1PR0402MB3600.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BOmey7/79ja+7F5w"
Content-Disposition: inline
In-Reply-To: <VI1PR0402MB3600F0FB1A031BE502588C93FF1E0@VI1PR0402MB3600.eurprd04.prod.outlook.com>
X-Cookie: The other line moves faster.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BOmey7/79ja+7F5w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 28, 2019 at 02:20:15AM +0000, Andy Duan wrote:

> So on i.MX8MM/8QM/8QXP platforms, we catch the issue that user dump regmap registers without
> power cause system hang.
> Maybe revert the patch is more reasonable ?

This is an issue with or without a device - you can have the same issue
with devices that are powered off.  Typically where power is dynamic the
driver will use a register cache so the registers are always available.

--BOmey7/79ja+7F5w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlztNwcACgkQJNaLcl1U
h9D4nQf/Qm5/cL/GsDQzCdntAZ69L9JspITibd0eQuycfxNMcg5OWjoretBkbrPr
h2HZjvd7xvjmj2TXPwQXAAffgUk5h68YBCCRjnGG93/ITIcJ4d89hMX9vllQdgYW
kb9s2kBBX9NcSuLb6n9+IG1q90Bvs8CvImKOuBUKVJPcZ+cs4bvS0Q8CqrXrtiqt
8VZ3+u+PNNbzTzbwJy1T5lJJ/vnUC7lOq7sB5EkMDwQhF6FOJsBmOI5NQbZIdD6u
h2Vkmg+ayW5N8IPcizLLyKchFHtq4ueeaQEF6d7DOoh06vGz2kLx5D/7lIcb967v
QUvH7iI69CD3ctWFAyQmswJFDI/aJQ==
=+B0c
-----END PGP SIGNATURE-----

--BOmey7/79ja+7F5w--

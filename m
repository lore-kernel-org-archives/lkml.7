Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904C7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC992084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554104409;
	bh=0muazu+nRNW2D8fXQ6pJLQDrJbap9T0gCbQ5KwZiuJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=po4x4UpKFL93PRHdeJDEWsc05mXMNTHGJ1HgQtqugPrTPYJagyAAhW4z+U/RhCCgi
	 /Einil5VKwMs6u4Rg0/KcpFD52DARsEAzKJTHZfoZDs2VzHDqHrHivgZ9M0xP3SRNe
	 syebftRviCmGTx8OhDQULu4959cy1On58k7EzHtA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732019AbfDAHkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:40:08 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49364 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731833AbfDAHkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 03:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0muazu+nRNW2D8fXQ6pJLQDrJbap9T0gCbQ5KwZiuJk=; b=VZGZyN+CeiAJtfSXL+7ZVVUxh
        8LyONqCHfRZMhGTLbLz8RktWlgVTWWSVsdKF4IPYn5LOwNrnlcjNOlyUI0aZd2va0aMUvIkFRwEoJ
        oTM2G9wjwk7OVFR/INvp0M9TZ3hLbVWUKs4U1CIdWgOzbl7xZlRmwuHzjmcz/k33Z1HIA=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hArY1-00087o-F9; Mon, 01 Apr 2019 07:40:01 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 3E6B1440082; Mon,  1 Apr 2019 08:39:58 +0100 (BST)
Date:   Mon, 1 Apr 2019 14:39:58 +0700
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, talho@nvidia.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kyarlagadda@nvidia.com,
        ldewangan@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V1 09/26] spi: tegra114: dump SPI registers during timeout
Message-ID: <20190401073958.GJ2059@sirena.org.uk>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
 <1553666207-11414-9-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mFHiwr52TKrxpkjc"
Content-Disposition: inline
In-Reply-To: <1553666207-11414-9-git-send-email-skomatineni@nvidia.com>
X-Cookie: Use extra care when cleaning on stairs.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mFHiwr52TKrxpkjc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 26, 2019 at 10:56:30PM -0700, Sowjanya Komatineni wrote:
> This patch dumps SPI registers on DMA or transfer timeout for debug
> purpose.

This is another non-bugfix patch which should be after the bugfixes.

--mFHiwr52TKrxpkjc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyhwE0ACgkQJNaLcl1U
h9AVFQf/d16Dknk5nchZgdinfRmqX2qop7KAFn4NZjfrdCCCFC2Me03rw4qkiVlK
jbOdswTT6UH2uG7PBn5EmSA8SFNl2ggsJUM7DuYODcZ0QRlXh+Kew5lmjcPmj6Ff
tu8eXz4kkhJ0+zk9VKQkMy77ojeqhrs/gsZfJCqOnh4axHuB7hyHHyKNuyR36Y8i
hicRY6UyyMS1fYExK49osxllpkKWbvbHL/RMuXIYVx1wGtcxBU5yjkYTcFy40Nwy
7rKpNE3MjDIzqnqmuojyuRb8+mCpkEieVsREf5eVlFL27uhdVJVrUbzT7PMq75A8
uP5uTaBXwFJCqff97ZsUrl75tzYapA==
=f+WJ
-----END PGP SIGNATURE-----

--mFHiwr52TKrxpkjc--

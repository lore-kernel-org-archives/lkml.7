Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A33C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 09:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EBB521835
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 09:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577957447;
	bh=elsGuMFot+33Av4FGSNOajGfxnc8N4DN5vUSx+tOYSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mZHbN9ArobBAj9RAiT6kko5eunLhw6Eg+Zb1gU0FhifjNJPJYbUbirFWoHdkT6M+f
	 co1cCCIY7wnhuJClMw4hF11Z/8sEG0Wv+DOh5a/BAyK0BhbBHYpCxzrgcbJ47lUHO7
	 R5vH6uoAebMEg4Yh4AcK3cBkoiImqI1hGcCsWfSY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgABJaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 04:30:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:56096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbgABJaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 04:30:46 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 433F7217F4;
        Thu,  2 Jan 2020 09:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577957445;
        bh=elsGuMFot+33Av4FGSNOajGfxnc8N4DN5vUSx+tOYSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jwVoClvRVKseM3M0tfQSJuj82PWp7sxKT4AvgdaYkdQven5XJQHeeArupeJvjrs+e
         v1yzZEqg13F4KrmLs10PK4PEgy/VlNavLoQPR71yIy9nho4xnZzIxuOPyTYWU9Zyh1
         PonelYCTAQe+imirBrqBo0fSRyWc9Ehlg/l+JTR0=
Date:   Thu, 2 Jan 2020 10:30:43 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>
Subject: Re: [PATCH] arm64: defconfig: Enable DRM_SUN6I_DSI
Message-ID: <20200102093043.v3apgtbex3xo76cu@gilmour.lan>
References: <20191231065508.12649-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="apso4hjgcko6pumn"
Content-Disposition: inline
In-Reply-To: <20191231065508.12649-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--apso4hjgcko6pumn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 31, 2019 at 12:25:08PM +0530, Jagan Teki wrote:
> Now, Allwiner MIPI-DSI support is available for ARM64
> Allwinner SoC like A64. So, let's build it as a module.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Applied, thanks!
Maxime

--apso4hjgcko6pumn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXg24QwAKCRDj7w1vZxhR
xQ78AQD5XsHB4uXdgbX0OqVKJf80XBy5yljIptaMn2mt0qeewAD/Vi5Nc2D2zYaZ
xY+pPlx1L9e1Hr8cg7l2kkav57Ku3gs=
=v0GZ
-----END PGP SIGNATURE-----

--apso4hjgcko6pumn--

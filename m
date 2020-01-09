Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C724C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 21:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0EBD2080D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 21:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578605326;
	bh=HaRHoMAuFPzbqrBfJM75MovgnC0zCPxs4nzZrE0upHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JcVik7T5+ccuR45W6zLwIqCh8gd50mTeiKsKD3pFdi6MQ+Pkkx/dmJl7Pv+LRvvkC
	 /7FMmAkLFPZXZvyDbGfDpulwmi2GVq715//TDNophosNp3uyajgdjM/Pa3IWoLiCti
	 CYfeHV5b61hq51b0iO34zd0lLd0OeLlotYGpm7qY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbgAIV2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 16:28:45 -0500
Received: from foss.arm.com ([217.140.110.172]:36910 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbgAIV2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 16:28:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4802A31B;
        Thu,  9 Jan 2020 13:28:44 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C301F3F534;
        Thu,  9 Jan 2020 13:28:43 -0800 (PST)
Date:   Thu, 9 Jan 2020 21:28:42 +0000
From:   Mark Brown <broonie@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     marek.vasut@gmail.com, tudor.ambarus@microchip.com,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        xuejiancheng@hisilicon.com, fengsheng5@huawei.com,
        chenxiang66@hisilicon.com
Subject: Re: [PATCH v2 2/3] spi: Add HiSilicon v3xx SPI NOR flash controller
 driver
Message-ID: <20200109212842.GK3702@sirena.org.uk>
References: <1575900490-74467-1-git-send-email-john.garry@huawei.com>
 <1575900490-74467-3-git-send-email-john.garry@huawei.com>
 <0dc5cb2e-b765-9e13-b05e-9e3c835c5985@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yiup30KVCQiHUZFC"
Content-Disposition: inline
In-Reply-To: <0dc5cb2e-b765-9e13-b05e-9e3c835c5985@huawei.com>
X-Cookie: Killing turkeys causes winter.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yiup30KVCQiHUZFC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 09, 2020 at 03:54:00PM +0000, John Garry wrote:

> From checking acpi_spi_add_resource() or anywhere else, I cannot see how
> SPI_RX_DUAL or the others are set for spi_device.mode. What am I missing?
> Are these just not supported yet for ACPI? Or should the spi-nor code not be
> relying on this since we should be able to get this info from the SPI NOR
> part?

I'm not aware of any work on integrating this sort of stuff into ACPI
platforms so I think it's just not yet supported in ACPI.  I'm not
really sure what would be idiomatic for ACPI, figuring it out from what
the part supports might well be idiomatic there though I don't know how
common it is for people not to wire up all the data lines even if both
controller and device support wider transfers.  I've got a horrible
feeling that the idiomatic thing is a combination of that and a bunch of
per-device quirks.  There may be a spec I'm not aware of though I'd be a
bit surprised.

--yiup30KVCQiHUZFC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4XmwkACgkQJNaLcl1U
h9DSmwf/cxqR58GjrThK9SdQjRi/lDgE2Zvu+klgcyq4qaE5CzctPqfdcJvyMn3D
8dnuZ0QZ/u4P/6nbc1FfGXfqeV7B0KeZ7yZbzklrjD1ehohvg3H46K52oVsVjF4H
xsjPdJDNeTtFBIgHGy1M4AIYVC58nRYX/6S7qLRKdyE5OOL4uHv/ZXSzBfhh+XPe
UtVTZNNfcXxdkWOTsmFo3qo0hnb8FxD/K0Rg++9C6XHLftNqmsXJcpzLaYKEBkor
FuQEwWTfDc4x3bq3cjsBqEURrEBAhUSMwZlfwgBJgX4GZfgR7pBv1IDZvXCwff0W
o8LOG/PgA593X83a55IjHs2w5oIGoQ==
=Vjtj
-----END PGP SIGNATURE-----

--yiup30KVCQiHUZFC--

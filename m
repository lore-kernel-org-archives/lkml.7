Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB0DC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA842084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554894652;
	bh=YzmL0AB6OFxfCFDjXpa333/MPscmt+Rz4yow9AUj3qM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fd9xAANxRn+Yz68E/eVgF3YaRWgjptSSq+HXLEGOXo2oV7zseh3T+rxjvh+E0vsbR
	 2Ga5HxcQA8mcWQj/L1Z5f2TcMZYn0Cm6x25NPB2AKWkthy5LUNVKfMVCQiDxt8b3JS
	 NXM9SV5A4o2edRQXgkDdKZ0cwIEFmvV/z/P1c7bI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730623AbfDJLKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:10:51 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48860 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728160AbfDJLKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WXi4bag9AIkk6ziIctmV/IUWj6sf4eclCenSqyfnqbk=; b=cYTxdd0JVN0RNtLhVIF0fwvue
        jvjWMFcaHcD3tCdOBbfuKvEpcmshP7m0IwagGwQNlV/TMnEHpGygGLbPT6aawnqHp9txgwr0K6X5Z
        iF90CQQCQIp6RkxpBE+sgSlv8dFd55rvzwObyDmSoaOWYUOOjAyiL9mfyZgECtUo/J6s0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hEB7h-00080a-89; Wed, 10 Apr 2019 11:10:33 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id AD5381128ED3; Wed, 10 Apr 2019 12:10:32 +0100 (BST)
Date:   Wed, 10 Apr 2019 12:10:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pengcheng Li <lipengcheng8@huawei.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        john.stultz@linaro.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, suzhuangluan@hisilicon.com,
        kongfei@hisilicon.com, liyuequan@hisilicon.com,
        cash.qianli@hisilicon.com, huangli295@hisilicon.com,
        hantanglei@huawei.com, wangyoulin1@hisilicon.com,
        ninggaoyu@hisilicon.com, xuwei5@huawei.com
Subject: Re: [PATCH 2/3] ASoC: add hikey960-i2s DT bindings
Message-ID: <20190410111032.GJ6106@sirena.org.uk>
References: <1551362261-99422-1-git-send-email-lipengcheng8@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MzdA25v054BPvyZa"
Content-Disposition: inline
In-Reply-To: <1551362261-99422-1-git-send-email-lipengcheng8@huawei.com>
X-Cookie: teamwork, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MzdA25v054BPvyZa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 28, 2019 at 09:57:41PM +0800, Pengcheng Li wrote:

> +Required properties:
> +
> +- compatible: should be one of the following:
> +   - "hisilicon,hi3660-i2s-1.0"
> +- reg: physical base address of the i2s controller unit and length of
> +   memory mapped region.

This binding is inaccurate for the code as it requires two memory
regions, one for the IP and one for the system controller.  However as I
said in the review of the driver you should probably be using the
standard syscon binding for the system controller.

--MzdA25v054BPvyZa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlytzycACgkQJNaLcl1U
h9CbMQf+MU0o4vQiRVLvnUzyJy9F0DiTkSTOzWFxxAmW0jm5y0v5vMCD9ExC2uBF
uvYHdj9luy4Es/ah0eovKtLFVgV7xnQtqAUPpz+uH9azreBiCH8nMHTz2l8NVXys
8zdjd+5fsO2tggHKiiOJka17c7XC1XWrOkCfz9GZC3RuKPOe/Vg10ZNgH4fbzfdP
OdeQRhnrviDWTLhcdE6VPH5XayiG+DPZxqOk5hfkAI6Lcqk3ZiNBXeRSclOt6G8u
vRZPLEztEjY9aSDi32wEs1BFvt8hpXE+CuRxUPIgHTBiwC7sojdl3P66y3H52ILQ
1R96bj2dZ4baL1Z5fls7UKaNUSKmLQ==
=Zgie
-----END PGP SIGNATURE-----

--MzdA25v054BPvyZa--

Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967E3C04AB4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A3CA208C0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557128289;
	bh=OplcOJgXCBTWNyGsHg1gze+ejETAogmJNTbMKat0E9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=REfEVkNoAsOS9O2QPvAxGgnDFm80RvN0GD9vZhHyIxzeGtFL03VxaVAKk8EMHJwgl
	 a5NRMksvpHMLq/HemiJ7BDGenAvA/hS9jmaTwhkzPfjBpe/VcwQ6NC8sKQebvqmzkJ
	 QKj2694sDLyW3dijMXNYpIKrvAggt4TQp4JeQ7UI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfEFHiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 03:38:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39014 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfEFHhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 03:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=K/VZmSu1PxmZ4mNcRzQNM4WPWZPh3W+ZX3c4pwzEk7A=; b=NDqKyDnms24nHU1GRspLEi8Gg
        fJY+FT95h8Pmjp6Gxjpg56Fq4hp+X7++KKiho1kXIjgzSWZLLWboOinUSuWlzHujEvpgobWh+BBZZ
        vbKjrX8OGefqZIk6SFP6m9CrkuELjWacXNrYT0rMJfGT9IdKHyQdSFun4WDAWtSngehcY=;
Received: from kd111239184067.au-net.ne.jp ([111.239.184.67] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hNYBt-0000s3-Df; Mon, 06 May 2019 07:37:37 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 64A2E440036; Mon,  6 May 2019 05:40:12 +0100 (BST)
Date:   Mon, 6 May 2019 13:40:12 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, vkoul@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 2/2] regmap: soundwire: fix Kconfig select/depend issue
Message-ID: <20190506044012.GM14916@sirena.org.uk>
References: <20190419194649.18467-1-pierre-louis.bossart@linux.intel.com>
 <20190419194649.18467-3-pierre-louis.bossart@linux.intel.com>
 <20190503043957.GA14916@sirena.org.uk>
 <535dfeac-77d8-1307-0329-33b8f2675bbd@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hS2jB1L/urRucW8g"
Content-Disposition: inline
In-Reply-To: <535dfeac-77d8-1307-0329-33b8f2675bbd@linux.intel.com>
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hS2jB1L/urRucW8g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 03, 2019 at 09:32:53AM -0500, Pierre-Louis Bossart wrote:

> As I mentioned it'll compile the bus even if there is no user for it, but
> it's your call: alignment or optimization.

You can have both.  Alignment is a requirement.  If you want to optimize
this then it'd be better to optimize all the bus types rather than just
having the one weird bus type that does something different for no
documented reason.

--hS2jB1L/urRucW8g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzPuqsACgkQJNaLcl1U
h9C3gwf/aCYXhO7xjzbVx9t1Sndb/c/UMHT0O5CXlHTDLFHr1Qjt+C6/EVAM0ku7
LgY7KpSCoMzqDf1AsI/kB2YyjCxC6h/7t0VRLGqulLDxELKXocOqISneW1WjuDrt
UehqoT/opy+sONl7v68Rqf4hAEZ/pM9IPQ6yDFB2HzZ9eqRE7OC6HC5V9NfwX2/q
V3399AowQFYUI9CtlPDkBV/uWEUOysqSLVLUq8gDbuptte2zLy3M+tiycCu/sNpG
9ZUrqC/M7TqjyeX9VT8U0aN1Ij2eL2+eqkR8p6LyUtR7z5e0jH9Spe+tJK1LcwlY
RhcJzggLimdE8hFYlTAtdBaWO+gPpA==
=LwsG
-----END PGP SIGNATURE-----

--hS2jB1L/urRucW8g--

Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54D1C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2BF248CE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559586153;
	bh=MSkJDPcob0Lccjzm8FxBFewk6g01Az/qXy0hZ7zPV+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Y/LgW5iNcaqGlFjBqlgxNqCfYBu+mKt40IIq0K6Ra3cQjvSTy+PRP5d29PFrW4aKu
	 2kTK3ylfB5rtU+11t5UKmAMifhokCFObWCqmgxcE3o8UNUDkjFQJ49Y7bTfm7cko3A
	 sirTgZcsc5cizD6R5i+Er8KxELx7Te32xnBxruqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfFCSWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 14:22:32 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33116 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfFCSWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 14:22:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3r3KESlL5pAfrYtn4vQKj5z96Mal9mpoBCdHth5veJs=; b=JfH0ghwn1a7WHN/lmUoj5GFKQ
        rlaH6Ld8CGB1LBHNnaLHyptkuOpHpVn4RlVlEajg/RfzRvZjZCPabi+FnzvpITJCWqBuMmFjgG0DJ
        F2brHBjRkTsxlKOX8ka2KclZKhdoBzGbL1u42f5VqwulFI7nQCn3QbN5VRxGiTtgRAzZY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hXrbC-0003dj-RV; Mon, 03 Jun 2019 18:22:23 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 05FD9440046; Mon,  3 Jun 2019 19:22:21 +0100 (BST)
Date:   Mon, 3 Jun 2019 19:22:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     lee.jones@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        tony.xie@rock-chips.com, zhangqing@rock-chips.com,
        huangtao@rock-chips.com
Subject: Re: [PATCH v8 RESEND 2/5] regulator: rk808: add RK809 and RK817
 support.
Message-ID: <20190603182221.GA2456@sirena.org.uk>
References: <20190603170900.5195-1-heiko@sntech.de>
 <20190603170900.5195-3-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XiX5sJQOWZsNRXst"
Content-Disposition: inline
In-Reply-To: <20190603170900.5195-3-heiko@sntech.de>
X-Cookie: The other line moves faster.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XiX5sJQOWZsNRXst
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 03, 2019 at 07:08:57PM +0200, Heiko Stuebner wrote:

>         default:
> -               pr_warn("%s ramp_delay: %d not supported, setting 10000\n",
> -                       rdev->desc->name, ramp_delay);
> +               dev_warn(&rdev->dev,
> +                        "%s ramp_delay: %d not supported, setting 10000\n",
> +                        rdev->desc->name, ramp_delay);

This appears to be unrelated and should've been a separate patch.

> +static int rk817_check_suspend_voltage(int id)
> +{
> +	if (id >= RK817_ID_DCDC1 && id <= RK817_ID_LDO9)
> +		return 0;
> +	return -1;
> +}

Rather than have these checks in the implementation you should just not
define these operations for regulators that don't have the
functionality.

> +static unsigned int rk8xx_regulator_of_map_mode(unsigned int mode)
> +{
> +	if (mode == 1)
> +		return REGULATOR_MODE_FAST;
> +	if (mode == 2)
> +		return REGULATOR_MODE_NORMAL;
> +
> +	return -EINVAL;
> +}

This should be written as a switch statement for clarity.

--XiX5sJQOWZsNRXst
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlz1ZVsACgkQJNaLcl1U
h9A1LAf+IawRfBxIBUR2HWNgjqoJMnLF0GaliOyoJBELCf9chqPQk1+aTKdnn4l0
MLYTCsLJA77ur0D8ncMYsPvvBRUasG5U0T5XEyJzXWYNIx7togwumtv/w3JAnBSh
RRMSKYhaS/wNrVHdYcVt8SzVVrVkB5OsYKXzPDbRRFTmeHXrxO2YKjLY9AQK93Sg
cruWOCSi6HuzhAxlr5uf9TcaEM6VsN4+0HXsKT68T9iJ87q5/lhsL6REBsayhaGF
/hlyx7ZqehspqO23eFUX1g4wTSTdatd1UXZ8RoqzrFuOX44+hsw0snF9GeCCwVUH
KWc4k3Qa6PrxyYA9/f9G316d63x0YQ==
=QMyH
-----END PGP SIGNATURE-----

--XiX5sJQOWZsNRXst--

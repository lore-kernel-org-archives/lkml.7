Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F8ACA9EC2
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 07:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46F92086D
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 07:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572335317;
	bh=FXgcfNOvXeZ6eBY7zQ7oil3dfcM2q0wnJso7d5WHhxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S+GBPuVIgp5mug8e5O7OAsowmaZR5K40sqXkX0dP7gHPO88P67FPwfIbZHaeNW/+E
	 5H7S+NIuLVh4nvozMh3/HewrRf2nw8IbhIN8IKTcuQ2xK7b3rHtvP5O64Lk1auwqlb
	 WhXYqn0acVDZH6K363TlpPfRDymTrdyhbfHy4Z3s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfJ2Hsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 03:48:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:48634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727861AbfJ2Hsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 03:48:36 -0400
Received: from localhost (unknown [91.217.168.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66E1F20862;
        Tue, 29 Oct 2019 07:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572335316;
        bh=FXgcfNOvXeZ6eBY7zQ7oil3dfcM2q0wnJso7d5WHhxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dZKqDQIox/2uMUpK/QV6sPMi1BfuzxaFYWsLchJ5qWl0GxCWShvDRUhJBZbs92VRD
         PUAOmymSQcIYE6Gf9taNX2oiMh9322kdr1JVg/8IgWcf/K3gSyuN4vf7LaJQ68tzG3
         ZCqTUMCXNhvGpokgte0iXmwd9F+ywIBkqlrvPovM=
Date:   Tue, 29 Oct 2019 08:43:21 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: sunxi-ng: a80: fix the zero'ing of bits 16 and 18
Message-ID: <20191029074321.ftamn6qitkbfrucm@hendrix>
References: <20191023112809.27595-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gufwthkvpo2ckxgg"
Content-Disposition: inline
In-Reply-To: <20191023112809.27595-1-colin.king@canonical.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gufwthkvpo2ckxgg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 23, 2019 at 12:28:09PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> The zero'ing of bits 16 and 18 is incorrect. Currently the code
> is masking with the bitwise-and of BIT(16) & BIT(18) which is
> 0, so the updated value for val is always zero. Fix this by bitwise
> and-ing value with the correct mask that will zero bits 16 and 18.
>
> Addresses-Coverity: (" Suspicious &= or |= constant expression")
> Fixes: b8eb71dcdd08 ("clk: sunxi-ng: Add A80 CCU")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thanks!
Maxime

--gufwthkvpo2ckxgg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXbftmQAKCRDj7w1vZxhR
xUkfAP9Z5pgiCu01sgdMtiTA28A0ugCnNsspfAqhabiBnF1uMAD/UtXwYMkvUTC7
Eqx/KFAYrADVGg14oOUSrdk0eFxowwY=
=j3Hb
-----END PGP SIGNATURE-----

--gufwthkvpo2ckxgg--

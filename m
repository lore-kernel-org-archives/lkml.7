Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC767C17445
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 12:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C05342190F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 12:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573476347;
	bh=WDxipH3XLB+HfXaUZVK+cmzbhva8WgS/ApH5twhhsWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YpPoFAC/gD9dHCMEk94m6piHRrxnLO/mQpJS+s5rMyhtmGNoSVtFRcA0sySyzntv6
	 D6ozxHRf9qBL/Nla5PZ3qQ8iTSr/1LTNpEDUZoZS1utjLP/j9w75xQ6dhOGvC867eY
	 Jfk/pyu/ObFtJJ8bkf5Ht9QIJeTNaOUQ5V867TL0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfKKMpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 07:45:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:60752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbfKKMpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 07:45:46 -0500
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81A512067B;
        Mon, 11 Nov 2019 12:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573476346;
        bh=WDxipH3XLB+HfXaUZVK+cmzbhva8WgS/ApH5twhhsWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SSUQBKR6JLC3ewYFOQo4yHy+RGXZpUGmrE7icwLKEYPpw3bdXBepxFdp68ZXSr75B
         IvMrYpO2hXuFGD0v11QZ049hbuzuBxUN9nSmbp1LRRYw4PD+ZPT2Nd7JaEI2m9VHcL
         mKbHd2FEvQjOL0SeE7dW1r2m5uLbQ81g1A9MXPX8=
Date:   Mon, 11 Nov 2019 13:45:42 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     emilio@elopez.com.ar, mturquette@baylibre.com, sboyd@kernel.org,
        wens@csie.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH] clk: sunxi: use of_device_get_match_data
Message-ID: <20191111124542.GO4345@gilmour.lan>
References: <1573403720-7916-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/JIF1IJL1ITjxcV4"
Content-Disposition: inline
In-Reply-To: <1573403720-7916-1-git-send-email-clabbe@baylibre.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/JIF1IJL1ITjxcV4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 10, 2019 at 04:35:20PM +0000, Corentin Labbe wrote:
> The usage of of_device_get_match_data reduce the code size a bit.
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Queued for 5.6, thanks!
Maxime

--/JIF1IJL1ITjxcV4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXclX9gAKCRDj7w1vZxhR
xXQrAQCuBvWXvw9bB/NYXgGhHA5eGk4zCcGrX2njuT6ALJldIAEA+N8WJYaZVKxA
jDggN/JLd5CcVAR68UGM79sdoFQlags=
=venc
-----END PGP SIGNATURE-----

--/JIF1IJL1ITjxcV4--

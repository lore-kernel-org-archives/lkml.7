Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768CFC32767
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 09:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE55222C4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 09:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578044249;
	bh=t1n4osX8UFyfzagbobo+KoZCptgIJ8gvbeKetytczeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gqwxkbjXgtzFhtTNfg0bhXu6ptprt1zs4HDC1krBfMQ4tLlFYwbykkwNFfdrDTRrB
	 VkP/WkqEGQWlJiGXtc9lenG4Be+0i74c9BjNrrhTQOPhFnYVyOQtWPgIbRXVcNs2Mz
	 HrBS2rnM62XsYQlr8I1gwxvq2aLsu73lf34AxdZQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbgACJh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 04:37:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:56948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgACJh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 04:37:28 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 121A821734;
        Fri,  3 Jan 2020 09:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578044247;
        bh=t1n4osX8UFyfzagbobo+KoZCptgIJ8gvbeKetytczeM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H6+N5bPGQlNhV1gyvOOg2A1ukTS7rQlhfNWi+c/GaXeqQYGYgRzbiDrVw9GctGa3P
         BDAjdvQDi8XqZV/vhzmGC8cCssXQwvcTd1Lv0QDXWUzKaoTfKCCeGhCebE7SY6VmSy
         mM3QibPSZ/Z5n5vQSCNzCYvjKYD01jayq8lpO9co=
Date:   Fri, 3 Jan 2020 10:37:24 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: sunxi-ng: r40: Export MBUS clock
Message-ID: <20200103093724.qo2enqqpr5dzcvfc@gilmour.lan>
References: <20200103071848.3977-1-wens@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6ydtg2u437jgrsyi"
Content-Disposition: inline
In-Reply-To: <20200103071848.3977-1-wens@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6ydtg2u437jgrsyi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 03, 2020 at 03:18:48PM +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
>
> The MBUS clock needs to be referenced in the MBUS device node.
> Export it.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks
Maxime

--6ydtg2u437jgrsyi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXg8LVAAKCRDj7w1vZxhR
xTXyAPwOmHJ3brL7yUfKmR5he70BqWy5MhxZQ3ik2vpHkUxeEwD9F58DhQY/DVl+
PPeLEWk09d1ZxePABfHlBOoPLFXWXAQ=
=vkyJ
-----END PGP SIGNATURE-----

--6ydtg2u437jgrsyi--

Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD1FC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 00:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 007D920665
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 00:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565742281;
	bh=b4p1ci6dEEfWunfHLhqU5NpsLSBWvNL4n/hABsu9kgs=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=WP7CVnP4fdYwqvgESjnsaMRMMziwFjaBKAdZUVWTgOZSkQEVzaCAgVKKfWsoIZDxU
	 W6es4fo+wv4PFDWGXfzryfPlspq0hICy/kkSnJ0deKGglXyZlpsxiFXAW2Klc9+D/C
	 tzA0UT1N4IotJSRT460ixEi5cfrfiQDJDs9bM2kw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfHNAYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 20:24:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:39866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbfHNAYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 20:24:39 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D99F20665;
        Wed, 14 Aug 2019 00:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565742276;
        bh=b4p1ci6dEEfWunfHLhqU5NpsLSBWvNL4n/hABsu9kgs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ZQMSutrKpbvIB5EiLXzATQJIr1GQTAYvoWw98v4WIcXy8iG2PyM4AnYGCuZgYC5wW
         ANhuSot0ZD3aXlsPRU8i6i96dPeNtyfUT7Qd/mv2bqBY7zOW4kKqqgJv5ouSwoVhiP
         R7k+DmGLqa29/KPxG0lNGfS2oS4ZTEhO/BFNFlLI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190731193517.237136-2-sboyd@kernel.org>
References: <20190731193517.237136-1-sboyd@kernel.org> <20190731193517.237136-2-sboyd@kernel.org>
Subject: Re: [PATCH 1/9] clk: actions: Don't reference clk_init_data after registration
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Tue, 13 Aug 2019 17:24:35 -0700
Message-Id: <20190814002436.8D99F20665@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-07-31 12:35:09)
> A future patch is going to change semantics of clk_register() so that
> clk_hw::init is guaranteed to be NULL after a clk is registered. Avoid
> referencing this member here so that we don't run into NULL pointer
> exceptions.
>=20
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next


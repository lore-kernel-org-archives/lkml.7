Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAF3C2D0D2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 08:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2CB920706
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 08:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577175041;
	bh=1L4dp+QiqPHu7wf6E/7HV0BXGvYjQV2y0FxjdXBHZ9s=;
	h=In-Reply-To:References:Cc:From:To:Subject:Date:List-ID:From;
	b=aNw7BOmcRumBmwmOKV/qdUhJ5hNevjiiCRKaDY9oy+OY9Wp2dMczStpY8M1vzMUtQ
	 rxdQ72xSBTGWGnHyuQb4cjG3S1RpZ+wPPFSR5j7froj2ysSy9pej2dBwXM4w9Ws8qa
	 A11v/9g6SX6m/Zy0h9f/NWBQJIR/Ktq44OehrHZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbfLXIKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 03:10:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:56952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbfLXIKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 03:10:40 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C9D220643;
        Tue, 24 Dec 2019 08:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577175039;
        bh=1L4dp+QiqPHu7wf6E/7HV0BXGvYjQV2y0FxjdXBHZ9s=;
        h=In-Reply-To:References:Cc:From:To:Subject:Date:From;
        b=RY7QYj5lLy1i/HTUw0wApZHy5nhxgS1JolwiFEk9QB9rxouqZ4NmlxOSYzpJ6Dct+
         cxdSEqyKOyfU152A91Juvdc5de3oRiufgv4sKmJR6032Wnw9hvP+Be4osDJ5fvlHb/
         m4T4LhRz0bt5CrrX81pbtANWSI4/DXmNyXXvtAgs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191129033534.188257-1-yuehaibing@huawei.com>
References: <20191129033534.188257-1-yuehaibing@huawei.com>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH -next] clk: bm1800: Remove set but not used variable 'fref'
User-Agent: alot/0.8.1
Date:   Tue, 24 Dec 2019 00:10:38 -0800
Message-Id: <20191224081039.6C9D220643@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting YueHaibing (2019-11-28 19:35:34)
> Fixes gcc '-Wunused-but-set-variable' warning:
>=20
> drivers/clk/clk-bm1880.c: In function 'bm1880_pll_rate_calc':
> drivers/clk/clk-bm1880.c:477:13: warning:
>  variable 'fref' set but not used [-Wunused-but-set-variable]
>=20
> It is never used, so remove it.
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Applied to clk-next


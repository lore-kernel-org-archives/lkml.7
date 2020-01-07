Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBB6C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 06:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13E40207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 06:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578379424;
	bh=PFIrvMeHctQIbZGGn3lH2s/DJfH4pCsrMOndmz582ZY=;
	h=In-Reply-To:References:Cc:To:Subject:From:Date:List-ID:From;
	b=QIwD4euSpbr9t54vVF+DcSXTOTRgobe1Xg5AFXdJ1e/xA0lNZ+tKJllKNta03ekYB
	 x0rIQro7itrXuZFyF3S9V6OIuyTRbrSfwvBPTgOlkxGp6cEuQyXxgGpWBpdxVuSpmi
	 ha/+VJxI2Sca5BzMu/ShG+E4tMwNJSrJ1/ncAmIg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgAGGnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 01:43:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:43050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgAGGnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 01:43:42 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D47732075A;
        Tue,  7 Jan 2020 06:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578379421;
        bh=PFIrvMeHctQIbZGGn3lH2s/DJfH4pCsrMOndmz582ZY=;
        h=In-Reply-To:References:Cc:To:Subject:From:Date:From;
        b=jVcKLpk+e+EjMVK9r7puhXquPR50bKKfqxIPGMUjpT/cduhHN1u5kd73uh3htFHix
         svPuoHkJob9nnK3K2FHDFHyhudMoUyfOnvg441jEIaMu6buTmUY0m3q6T7zw9chUJJ
         L43/PIxmJP5OfsJmpwj6EsJ0hKXDJqXVMZ+uCHd0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190830150923.259497-2-sboyd@kernel.org>
References: <20190830150923.259497-1-sboyd@kernel.org> <20190830150923.259497-2-sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Tony Lindgren <tony@atomide.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 01/12] clk: gpio: Use DT way of specifying parents
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Mon, 06 Jan 2020 22:43:41 -0800
Message-Id: <20200107064341.D47732075A@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-08-30 08:09:12)
> Nobody has used the gpio clk registration functions nor the gpio clk_ops
> exposed by the basic gpio clk type. Let's remove all those APIs and move
> the gpio clk support into the C file. Since nothing is using the
> exported APIs, simplify the driver to be a platform driver that uses
> clk_parent_data to pick 0th or 1st cell of the node's clocks property.
>=20
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next


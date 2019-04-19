Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3D3C282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 210E021736
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555711987;
	bh=pj903/DlAl0VGAtPPT7N8zTWtyR1LahHJdVGXcTz/y8=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=muClZig+Z5cAPI8PRqxyD+W1SmWlCzHclX4adLX5g0v/A9/gPnJ57sqn25LCRmGnN
	 Nweb1u8TzuoF30QRjqo14d3pgpUrvtxwjgQdJlCBm1x7UiCky35jcG5x9G2CpbsZde
	 BX2PdRphzLb7qJO6GeHRte9wg+PFYZzpR48aq+mE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfDSWNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 18:13:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfDSWNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 18:13:04 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9874121736;
        Fri, 19 Apr 2019 22:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555711983;
        bh=pj903/DlAl0VGAtPPT7N8zTWtyR1LahHJdVGXcTz/y8=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=vTvGIweb9hOFU+9zHRMILKHh7sKgPTBX7nBWV7qXua/yvwycrmFbk7RjL7Fdir160
         JuhS2GCqaNNJuKzKWt8+n4fp6KZVsmxV2lXf6cCV5ql0qnUr8GleNIS5N457MAc9Pg
         9dmjYs7FIbsFvCf6hXQjfnnNPOCnRYL8ughtbE6w=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190412183150.102131-8-sboyd@kernel.org>
References: <20190412183150.102131-1-sboyd@kernel.org> <20190412183150.102131-8-sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Chen-Yu Tsai <wens@csie.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v4 7/9] clk: Look for parents with clkdev based clk_lookups
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Message-ID: <155571198295.15276.8581236778047172380@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Fri, 19 Apr 2019 15:13:02 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-04-12 11:31:48)
> In addition to looking for DT based parents, support clkdev based
> clk_lookups. This should allow non-DT based clk drivers to participate
> in the parent lookup process.
>=20
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Jeffrey Hugo <jhugo@codeaurora.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next


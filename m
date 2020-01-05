Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0A9C00523
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 07:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0126D21775
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 07:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578208931;
	bh=36YMIfds6bcjOeZrdHkRP5guH3R8Wyde9Xa7tDKb8pI=;
	h=In-Reply-To:References:Cc:Subject:To:From:Date:List-ID:From;
	b=1l5F9ChWHY/nGsb6iMvR7WEmvPlenu0Cw6jpb2k+3pkTR15z9o5gOMrj1WNCE71ig
	 zVOW1Zp3JB0eIq3tZrTuAO6mKIAEcEIQ5Ok70BecjL/BPamTH1TKC7c9t/cWUATrq0
	 /OhVgxtCBkTYhcNuUVZEzBEsIjIm+h4Rft25JeJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgAEHWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 02:22:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:43618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbgAEHWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 02:22:08 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B5A4217F4;
        Sun,  5 Jan 2020 07:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578208928;
        bh=36YMIfds6bcjOeZrdHkRP5guH3R8Wyde9Xa7tDKb8pI=;
        h=In-Reply-To:References:Cc:Subject:To:From:Date:From;
        b=Y5pNq0reydLkdp82SHfKPQEDwJd7XZHJbQ4N8+70XSxR5RX0nrt+g1d7r2CQH5LSo
         F9xVK8on6mx2cKZ8ys9ezNjDWKdtJZ0TjUIaAK9bmB2nsPAl/J1u9hsSuiJ5URoooC
         9E4xYTSsfY6DWyMHj9u5D2js3Z2qHFmt6TTmrtmY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200102005503.71923-1-sboyd@kernel.org>
References: <20200102005503.71923-1-sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] clk: Warn about critical clks that fail to enable
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Sat, 04 Jan 2020 23:22:07 -0800
Message-Id: <20200105072208.0B5A4217F4@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2020-01-01 16:55:03)
> If we don't warn here users of the CLK_IS_CRITICAL flag may not know
> that their clk isn't actually enabled because it silently fails to
> enable. Let's print a warning in that case so developers find these
> problems faster.
>=20
> Suggested-by: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next


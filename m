Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C2AC33C9A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 03:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 829DF21734
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 03:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578280409;
	bh=xp5rF0xCmJyirucp8HZboIfxMQ8XLnhsBHjxGVseJco=;
	h=In-Reply-To:References:Cc:To:Subject:From:Date:List-ID:From;
	b=m1kg5WWIpSnVyEM3LGezIgWlE3Qchp4BKGrrjz7b3I1s1mcW9uQnVoJmB195tNVJb
	 EYiS4v6nICtk9gQ9OgKCpZV6j7A4rmnlfQka1ww5QwBO6KiKRec0dQ+YynAOiq2+pE
	 Kv+icOr4H36fzc4tn5TrlIEpYfoClDzpFJKcw4dY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbgAFDN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 22:13:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:36526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727369AbgAFDN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 22:13:28 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B85DF21582;
        Mon,  6 Jan 2020 03:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578280407;
        bh=xp5rF0xCmJyirucp8HZboIfxMQ8XLnhsBHjxGVseJco=;
        h=In-Reply-To:References:Cc:To:Subject:From:Date:From;
        b=RlTrdEvsDbPNoGW9+XnBUgE2QpnFbWKcBiZ/8CGOljq+0R+M1u5xDb/26vLYnm93I
         +cB9Ahz7XHg5BgI4a9errFsY9KD43p8eg0LNZaqLyy1D/uCAZ+aec8N/TkcdEfpol1
         vzg/w3dG0n3Z7FLzQcc1NXK99SxjxgG46bRaqV6s=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190828132306.19012-1-geert+renesas@glider.be>
References: <20190828132306.19012-1-geert+renesas@glider.be>
Cc:     Raman Banka <raman.k2@samsung.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v2] clk: Add support for setting clk_rate via debugfs
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Sun, 05 Jan 2020 19:13:26 -0800
Message-Id: <20200106031327.B85DF21582@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Geert Uytterhoeven (2019-08-28 06:23:06)
> For testing, it is useful to be able to specify a clock rate manually.
> As this is a dangerous feature, it is not enabled by default.
> Users need to modify the source directly and #define
> CLOCK_ALLOW_WRITE_DEBUGFS.
>=20
> This follows the spirit of commit 09c6ecd394105c48 ("regmap: Add support
> for writing to regmap registers via debugfs").
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Stephen: you suggested this approach in
> https://lore.kernel.org/linux-clk/153029668040.143105.2059491089047180792=
@swboyd.mtv.corp.google.com/

Ok. Let's do it!

Applied to clk-next.


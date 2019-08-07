Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218BBC32754
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 21:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1FA921872
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 21:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565212832;
	bh=H6IRZcxzKndx5zx8Pkv7nOJGJAfsgtBu+QGrgi9asLw=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=ms3OLjvNbp/daWqF8taBXHpQvjGVVbHXfMFh4CLFmCpiozvakGv1qTnl5woHBHh6Q
	 ghhGpJVZkiKRThdP8vuKHTZpbglfTGAXYw9ameyZ2RHgSt6fgWVFQZ1zR4qHi/tDWj
	 3AC8sLCtYxksYyCY5qfotpdsgq7rmCnfI/ZLhnJE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389427AbfHGVUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 17:20:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:36068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389207AbfHGVUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 17:20:30 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5E902184E;
        Wed,  7 Aug 2019 21:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565212829;
        bh=H6IRZcxzKndx5zx8Pkv7nOJGJAfsgtBu+QGrgi9asLw=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=2F2JZEh7amLOi00ZrGHzAGDa1Xgnd+Y8dNSOOg7G+qeIbhpl9ly23IS/Ctb8Faooy
         Z8PF75foc4+NqT5l/t5AGzY4M1FUIEYmmoCvtmZ7DAurL1JszCdBt5ovPL/DPhkhCr
         XwIGH/i/t2ttuHcvHceMPI+CFchPCtba57rgdnuw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190627220642.78575-1-nhuck@google.com>
References: <20190627220642.78575-1-nhuck@google.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Huckleberry <nhuck@google.com>,
        clang-built-linux@googlegroups.com
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: qoriq: Fix -Wunused-const-variable
To:     Nathan Huckleberry <nhuck@google.com>, mturquette@baylibre.com,
        oss@buserror.net, yogeshnarayan.gaur@nxp.com
User-Agent: alot/0.8.1
Date:   Wed, 07 Aug 2019 14:20:28 -0700
Message-Id: <20190807212029.A5E902184E@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nathan Huckleberry (2019-06-27 15:06:42)
> drivers/clk/clk-qoriq.c:138:38: warning: unused variable
> 'p5020_cmux_grp1' [-Wunused-const-variable] static const struct
> clockgen_muxinfo p5020_cmux_grp1
>=20
> drivers/clk/clk-qoriq.c:146:38: warning: unused variable
> 'p5020_cmux_grp2' [-Wunused-const-variable] static const struct
> clockgen_muxinfo p5020_cmux_grp2
>=20
> In the definition of the p5020 chip, the p2041 chip's info was used
> instead.  The p5020 and p2041 chips have different info. This is most
> likely a typo.
>=20
> Link: https://github.com/ClangBuiltLinux/linux/issues/525
> Cc: clang-built-linux@googlegroups.com
> Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> ---

Applied to clk-next


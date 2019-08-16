Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C8BC3A59E
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF3820665
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565976033;
	bh=3KMN/Kgpj12U1KnF0aSVcsts5VrzGykXKT0Y4iOihjA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=DJ4lyXt+qoR7JLmHZUMtR5AwOCXaTfwwxHVrr6uznJHJeVFJaVMup07y5WyCaI4U8
	 Cpb56Few1VWUxGu15h535nsGelfdjOqaI3EVMgi5DvFkMMADQnTMKWQtV2vhemGSnG
	 mb+2+1cPvL7++EcB/3NanPR/trQNUE5Tne4ML5dE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfHPRUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 13:20:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbfHPRUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 13:20:32 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A802720665;
        Fri, 16 Aug 2019 17:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565976031;
        bh=3KMN/Kgpj12U1KnF0aSVcsts5VrzGykXKT0Y4iOihjA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ET/MaVSShmmG06FDDqPjhPW7/eW//gfea8+70j6c3PEDSl+smIXRjGB3iSgCo68MJ
         TFnKb6Wi66WmjfwQjxYKl7XjusPjMxZOYeH3hNFXQEjq57QxYkrABOT2VpPWB+KLGg
         j4IupB2qC+V6pofVo/jgUhg1Bdohy26VQFON5Xcs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190815160020.183334-2-sboyd@kernel.org>
References: <20190815160020.183334-1-sboyd@kernel.org> <20190815160020.183334-2-sboyd@kernel.org>
Subject: Re: [PATCH 1/4] clk: milbeaut:  Don't reference clk_init_data after registration
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Sugaya Taichi <sugaya.taichi@socionext.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Fri, 16 Aug 2019 10:20:30 -0700
Message-Id: <20190816172031.A802720665@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-08-15 09:00:17)
> A future patch is going to change semantics of clk_register() so that
> clk_hw::init is guaranteed to be NULL after a clk is registered. Avoid
> referencing this member here so that we don't run into NULL pointer
> exceptions.
>=20
> Cc: Sugaya Taichi <sugaya.taichi@socionext.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next


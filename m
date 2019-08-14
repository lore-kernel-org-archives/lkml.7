Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324C1C32750
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 00:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2FF720665
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 00:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565742291;
	bh=VS8sG0HAEV5veNQ7ouG2ExNPPus0w08d5ru1ibctqps=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=2bCYycjs8ZQH22ck33hrLphWl7Rk9X9GB8UDOwZ1C11maWNdyUYjcKZX5NKIPpzBw
	 aGHmpchVO4aAfrvjijerD8dkF1ibg6YKOyn/RUAS8sz1iM87mKM72DBuaKDP6/9jOT
	 /BEqxakE46r+tp++KndWGUx9WdSdFVldaGoNNGpk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfHNAYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 20:24:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:40072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbfHNAYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 20:24:48 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3D1020665;
        Wed, 14 Aug 2019 00:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565742287;
        bh=VS8sG0HAEV5veNQ7ouG2ExNPPus0w08d5ru1ibctqps=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=nrFelGQXBO6iAM90u1uPlR6xx9EuU5AxkxxIPP9NMIemOuZPod/9jT8LPKA9wfpXX
         zXGSADudVWinxdbIcY8tAj7srxMTdBrvwZRWEdp16cqApH0IjBdaMOf1CIG5GwBD3M
         M6MbF6A9kpHr0U7qONPJCB44ErOxuJ8ly/jdiaDU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190731193517.237136-4-sboyd@kernel.org>
References: <20190731193517.237136-1-sboyd@kernel.org> <20190731193517.237136-4-sboyd@kernel.org>
Subject: Re: [PATCH 3/9] clk: meson: axg-audio: Don't reference clk_init_data after registration
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Tue, 13 Aug 2019 17:24:46 -0700
Message-Id: <20190814002447.B3D1020665@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-07-31 12:35:11)
> A future patch is going to change semantics of clk_register() so that
> clk_hw::init is guaranteed to be NULL after a clk is registered. Avoid
> referencing this member here so that we don't run into NULL pointer
> exceptions.
>=20
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next


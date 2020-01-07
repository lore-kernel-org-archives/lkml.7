Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60641C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 06:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33CF02075A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 06:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578379429;
	bh=3Kll344KicY5i1MDInRWng0VEgTsRiXvTcEpcd4Bgdg=;
	h=In-Reply-To:References:Cc:To:Subject:From:Date:List-ID:From;
	b=EK+2ag7ZhV4jliaG32Mynxo5oe6IoNVo+3Teb+MEUHz7uTHcc0joEfUGSWK9r/MgS
	 N88hV8lGLLXENRvlrQEuG+4caaP07VtHuGBmGjz7WKJ6iyU7P9ofb2gklCw0/+EwIp
	 JtFASrzDM+T5WE0K01R4KO95AZUBp808SRjnQCk8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbgAGGns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 01:43:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:43242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgAGGnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 01:43:47 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23AE2207E0;
        Tue,  7 Jan 2020 06:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578379427;
        bh=3Kll344KicY5i1MDInRWng0VEgTsRiXvTcEpcd4Bgdg=;
        h=In-Reply-To:References:Cc:To:Subject:From:Date:From;
        b=T0h1ZKsdRYquEtN+u3Y+juYIkk5Ghpsn03jjsE19X+CO8gOF8FF6DCQElATPcvUNq
         U8kYSSe8ro99T59FIQ65kbzm0x49M8bRhFhFX5CcWBGTjeF0mEjLL/xdQPHUvPGq3m
         cQIw3Rd9Y8A1PQqQ4Zam2eFvGaf37RuNw2kn9LRM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190830150923.259497-3-sboyd@kernel.org>
References: <20190830150923.259497-1-sboyd@kernel.org> <20190830150923.259497-3-sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 02/12] clk: fixed-rate: Convert to clk_hw based APIs
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Mon, 06 Jan 2020 22:43:46 -0800
Message-Id: <20200107064347.23AE2207E0@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-08-30 08:09:13)
> This code still uses struct clk to register clks from the probe path.
> Migrate this to the clk_hw based APIs to modernize the code. Also, this
> isn't a module and it can't be one because the driver is always builtin
> so drop the module table.
>=20
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next


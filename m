Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B822C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 00:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D652020843
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 00:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565742323;
	bh=8dyhBqs0VxtzBSkGAOHopIMOkiyohHR0rKM1ajB+SuQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=TLv+eUSfRnBkwpFsjvF5sL8MrBMjtC6G/mws4w7A1BWBfoNZlJP0U9MQyzeZXSSIT
	 eWwIF/gHWhhLKKdxuqemN1i8OxWE7mHfGJMj+BFTghmAN8cm6oPp1Os9SqCya2wtxx
	 9anxH8xyKy9hJkYo472zkvyv5ATpZWaqiK1/fYhc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfHNAZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 20:25:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:40744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbfHNAZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 20:25:22 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5833820843;
        Wed, 14 Aug 2019 00:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565742321;
        bh=8dyhBqs0VxtzBSkGAOHopIMOkiyohHR0rKM1ajB+SuQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ZJXhUUkB56XEd1B+UZ5NEAQkz+loDeI+aKi8+4s5Pwyy1VjJrRjtU6uP4KOL+cPrQ
         qZByHJETTB7yQWGLQcFG5WsdXAPxLTLR2t5xn3yYDnmpZ5oS0rVoOnsB0NZf99S+G3
         itutRjjpV3Kc6Q7hwUYwQ9vKW0sm23FTj/jZcHtU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190731193517.237136-9-sboyd@kernel.org>
References: <20190731193517.237136-1-sboyd@kernel.org> <20190731193517.237136-9-sboyd@kernel.org>
Subject: Re: [PATCH 8/9] phy: ti: am654-serdes: Don't reference clk_init_data after registration
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Roger Quadros <rogerq@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Tue, 13 Aug 2019 17:25:20 -0700
Message-Id: <20190814002521.5833820843@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-07-31 12:35:16)
> A future patch is going to change semantics of clk_register() so that
> clk_hw::init is guaranteed to be NULL after a clk is registered. Avoid
> referencing this member here so that we don't run into NULL pointer
> exceptions.
>=20
> Cc: Roger Quadros <rogerq@ti.com>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next


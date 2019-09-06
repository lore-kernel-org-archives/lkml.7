Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FEFC00307
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 22:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9EE020854
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 22:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567808623;
	bh=bZdcjHRTRictQKuKHROlwLDaTmKRAORwUFoQbRhpj28=;
	h=In-Reply-To:References:To:From:Cc:Subject:Date:List-ID:From;
	b=ljJLIJr9iLkaw+cj6SauF957h730htxbPrFCSZA1W3vpTtGowMnBhc875I/D8+NeQ
	 LUaH65zAda9+xoqmyeQK50V9DvhhNewzOVNBlXZ7X95uF/fMJvUWrIFmY/TXPUstQs
	 nPNThsFr+uCNSBI7xfHljXgQHaOeV/1rqpPsvjDI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392369AbfIFWXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 18:23:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391961AbfIFWXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 18:23:42 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E63C2207FC;
        Fri,  6 Sep 2019 22:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567808622;
        bh=bZdcjHRTRictQKuKHROlwLDaTmKRAORwUFoQbRhpj28=;
        h=In-Reply-To:References:To:From:Cc:Subject:Date:From;
        b=DZ6igBgMOMpRoIV4Lq6HqTpdhr2Z7iGqIkhs8+ySpg6iV9iUejH5iUEkMTxD4A0VZ
         aX9iy9LAUaxyqPWfQJdUPXtfHMOGVO8gpngAezv1MyZ1MD0b+z3A/JWBNGzQFDC8JY
         HQ3HdZ14sHe6zjmvhx7iYeToJ8rKdCyCLnTCCKzg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190825141848.17346-2-joel@jms.id.au>
References: <20190825141848.17346-1-joel@jms.id.au> <20190825141848.17346-2-joel@jms.id.au>
To:     Joel Stanley <joel@jms.id.au>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Andrew Jeffery <andrew@aj.id.au>, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH v2 1/2] clk: aspeed: Move structures to header
User-Agent: alot/0.8.1
Date:   Fri, 06 Sep 2019 15:23:41 -0700
Message-Id: <20190906222341.E63C2207FC@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Joel Stanley (2019-08-25 07:18:47)
> They will be reused by the ast2600 driver.
>=20
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---

Applied to clk-next


Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33C2C48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6555205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561495076;
	bh=OVSKbYEmCYUYFKXz6+Jf3XDclNFQmS6oG/sdiBhVaIQ=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=wfN0MaBzouQxcSa6V8Ci7GqAc2Aq6qMpcqiVk2X1e7rKJ1AMeXtJ0Nzt+ouFqTbwY
	 7yyXZWOYPVOxCD3rdmgxZ67RqCWKJcf3T6Edwr4Kkmh77xsk9k16hXVkUueNNeNWu8
	 PZmrkwt0WDWr/X1hh1QEBUgYMDfKPW5hStmgYi+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfFYUhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 16:37:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:60634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726274AbfFYUhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 16:37:52 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2894205ED;
        Tue, 25 Jun 2019 20:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561495072;
        bh=OVSKbYEmCYUYFKXz6+Jf3XDclNFQmS6oG/sdiBhVaIQ=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=WYrqLsdF9x+U2qx5X8JPx1eqRVT8OGTYf88O00aPUuYonHhVuQQd6EEfMeFlnyzn8
         bf79OlKkuZemWxjs6nfzsqeOrrCQfULmgsm1luVkvTbNmSUOaXHMNW3SCCmWBGXP7g
         2rxzTAjJ/7YqD5V0AJV0QAYZ4OW6UqnOHT2G60lg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190625070602.37670-2-Anson.Huang@nxp.com>
References: <20190625070602.37670-1-Anson.Huang@nxp.com> <20190625070602.37670-2-Anson.Huang@nxp.com>
To:     Anson.Huang@nxp.com, festevam@gmail.com, kernel@pengutronix.de,
        leonard.crestez@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, peng.fan@nxp.com, ping.bai@nxp.com,
        s.hauer@pengutronix.de, shawnguo@kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 2/2] clk: imx8mm: GPT1 clock mux option #5 should be sys_pll1_80m
Cc:     Linux-imx@nxp.com
User-Agent: alot/0.8.1
Date:   Tue, 25 Jun 2019 13:37:51 -0700
Message-Id: <20190625203751.E2894205ED@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson.Huang@nxp.com (2019-06-25 00:06:02)
> From: Anson Huang <Anson.Huang@nxp.com>
>=20
> i.MX8MM's GPT1 clock mux option #5 should be sys_pll1_80m,
> NOT sys_pll1_800m, correct it.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Any Fixes tags?


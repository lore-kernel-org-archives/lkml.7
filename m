Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497BAFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2329420663
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571256409;
	bh=ZOsiycWlcu+SnL6IZ3oaAxvxPo3wW8QAyUj/9tKCtvo=;
	h=In-Reply-To:References:From:To:Cc:Subject:Date:List-ID:From;
	b=bPev5Jw3BdhtytCexFJnE0XgSulXL+ul/W7IawAOzGSMd+a/qSjEU16kf0f7pO4JQ
	 rnOcxai31DzxzEfR9gqyftACnWXn3vgxG9f6iwzaSvANWbt4/N2KsmWrbBQPv2Q55R
	 isB6jXQtbALBVRIqbNZVsMgRI0Z7jfO8L8Sla6J8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbfJPUGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 16:06:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:52122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfJPUGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 16:06:47 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF8032064B;
        Wed, 16 Oct 2019 20:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571256406;
        bh=ZOsiycWlcu+SnL6IZ3oaAxvxPo3wW8QAyUj/9tKCtvo=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=B9NUNTRP+CR61Zxnndl+/V3ZoFYybuIX36+wPHeBqad6DqY92dc/6Nt/sq9pzmylP
         liwk3NROPaBBFnZ9NXpDxuYoPC30nEwnxl1crMQZ+yK69LELdd9mdaoMM9oVjtkM1e
         9Tk/EGuK17KAHY9D1yfSgN6NTJIKF7hldDACe0Zw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1571122989-29361-1-git-send-email-peng.fan@nxp.com>
References: <1571122989-29361-1-git-send-email-peng.fan@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
To:     "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Cc:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] clk: imx: imx8mn: drop unused pll enum
User-Agent: alot/0.8.1
Date:   Wed, 16 Oct 2019 13:06:46 -0700
Message-Id: <20191016200646.CF8032064B@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Peng Fan (2019-10-15 00:05:53)
> From: Peng Fan <peng.fan@nxp.com>
>=20
> The PLL enum definition is not used, so drop it.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Was it ever used?

Applied to clk-next


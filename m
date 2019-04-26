Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81290C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B0DE2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556300229;
	bh=o9o9+Z94Z/oiqMiF+PnymzY7M4yCfHuuU8iP3fzHZkY=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=PxSTcTSweu+ElNmIa8LGtGJlEAWTl114+0jSWcUWi9YVwyrrDw001g7jtejGyfwcr
	 Xvo+ZsIgogNFmkm1NzAMA23Ir33DEiNlJxaBAHtP+s+UdwmiXlUbqrOTeHdQcwoKO+
	 8Rud3pTROaEMrnjRccFJtgBbShjiARGK6vZAsVVA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfDZRhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 13:37:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:53266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbfDZRhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 13:37:07 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA242208CB;
        Fri, 26 Apr 2019 17:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556300227;
        bh=o9o9+Z94Z/oiqMiF+PnymzY7M4yCfHuuU8iP3fzHZkY=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=WfchCxMN1f4Rh7NHcRxBVd8SlW0SrV4l4sVAI9oUaeI3L6Vy3gIbtiW5uEeCg/sPi
         EZXEGCututJYKpWn/bNirSNQp/URYGMnU1TDL5z8PFEzg5r2EnobmFo/oxCxBywJxl
         m/V7DHT4u52G5kWxDJOAKdxrCiBrdcZbSYS+GLaY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190426032003.GC7980@dragon>
References: <1556169264-31683-1-git-send-email-Anson.Huang@nxp.com> <155623701103.15276.18082131746292726812@swboyd.mtv.corp.google.com> <20190426032003.GC7980@dragon>
Cc:     "festevam@gmail.com" <festevam@gmail.com>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 1/2] clk: imx7ulp: update nic1_bus_clk parent info
To:     Shawn Guo <shawnguo@kernel.org>
Message-ID: <155630022606.15276.7971206139125625780@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Fri, 26 Apr 2019 10:37:06 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Shawn Guo (2019-04-25 20:20:04)
> On Thu, Apr 25, 2019 at 05:03:31PM -0700, Stephen Boyd wrote:
> > Quoting Anson Huang (2019-04-24 22:19:07)
> > > Since i.MX7ULP B0 chip, nic1_bus_clk's parent is changed to
> > > from nic0_clk directly, update it accordingly.
> > >=20
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> >=20
> > Looks ok. Shawn, will you pick it up?
>=20
> Stephen,
>=20
> I prefer you directly pick up any i.MX clock patches that look good,
> after I already send you PR.  I will start again for next cycle
> around -rc1.
>=20

Ok. Thanks for letting me know.


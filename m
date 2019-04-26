Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B96C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 00:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A9320878
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 00:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556237014;
	bh=RPO1uIC2IWh3mWyjsnKtUI+ErqImL3HOmmQm9sNEC94=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=rNG52IecjIkGzFgTVik4NoPeoc9ccZt+ZASbSaYdAtsnBR/kHG+f4+9iki46Jyubo
	 Giak9YQpVau3KmoNWwoOOgYYOrJ1j1wT8J9WXDLnFu5ih4qV3c2LL9BvoBkeBRdJNp
	 G2uBSMb09cNJsCyS+zIYyXHLS8mfl5nwBHoyPeW0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbfDZADd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 20:03:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:52820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728999AbfDZADc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 20:03:32 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB93F2084F;
        Fri, 26 Apr 2019 00:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556237012;
        bh=RPO1uIC2IWh3mWyjsnKtUI+ErqImL3HOmmQm9sNEC94=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=maZCC/ZZs2YcapksAW4v1joBDZ0LoDPpscVt1eERQsq2Boju1+Ut7f5EtHQm0T+LK
         IpSeoTpx7FIbBL/S/aXlKhn095TZzNHouKTjrhIue7bOtSdFzHTr0cB0vGQQpqGCIQ
         7oVoWnaVeZpSwi1ZzwvMAlhkjcKRpXRaZ3NVSsoo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1556169264-31683-1-git-send-email-Anson.Huang@nxp.com>
References: <1556169264-31683-1-git-send-email-Anson.Huang@nxp.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 1/2] clk: imx7ulp: update nic1_bus_clk parent info
To:     "festevam@gmail.com" <festevam@gmail.com>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>
Message-ID: <155623701103.15276.18082131746292726812@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 25 Apr 2019 17:03:31 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2019-04-24 22:19:07)
> Since i.MX7ULP B0 chip, nic1_bus_clk's parent is changed to
> from nic0_clk directly, update it accordingly.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Looks ok. Shawn, will you pick it up?


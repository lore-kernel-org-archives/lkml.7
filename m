Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EFDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2AE320850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552940550;
	bh=rYkYvizLYaF4Tp6HqpglWg5ijSOqjSQJk/SUsx+zXyg=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=pNgY7Q2w+j1pProvCphf6EIEEiWveRpGyPvfLTM4OjFPciDC2K08CvdedoJRLHwMM
	 MoNjkDvM1fgKIwo/hZO+e048nPM775A6J1s5VQ/AVc5938D27fRLDSlS0lPDqWJsu4
	 HcSNmqTypk+7shwEStioR7hPEymaP11zK4G6CDJ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfCRUW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 16:22:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:49758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbfCRUW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 16:22:28 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0005320850;
        Mon, 18 Mar 2019 20:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552940548;
        bh=rYkYvizLYaF4Tp6HqpglWg5ijSOqjSQJk/SUsx+zXyg=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=JCBAjZn5rt1D8h37i+FvS/gXXfEumBOOXUPjK0pFghbu/Y+2Yw+SbgZm2vbdF0Y+z
         qkXlgKZwoXx6ahLpwZwjdA9J6t8zI1ZG9OS6bwMcMY5yiCP6CZGwqgwYhGzM3bWYhJ
         cKIGY32k0Y3sBA9aye5DRiDdwG6pnSqrrABJ4a+Q=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190313135503.3198-1-narmstrong@baylibre.com>
References: <20190313135503.3198-1-narmstrong@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: meson-g12a: fix VPU clock parents
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com
Message-ID: <155294054725.20095.14218989036413639726@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Mon, 18 Mar 2019 13:22:27 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Neil Armstrong (2019-03-13 06:55:03)
> First two VPU clock parents are wrong, fix it here.
>=20
> Fixes: 085a4ea93d54 ("clk: meson: g12a: add peripheral clock controller")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Are you going to send this as a PR later? Or I can pick this directly to
clk-fixes now?


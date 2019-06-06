Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF749C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 17:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD8F2089E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 17:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559843757;
	bh=AQujoUskv1cUCT/ttXfe2eKJQcGVonInZu44yu7SV50=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=tqVHfWYxsyuxQRqCa47gxPx8CDsazLb/bapq1Fzbc+0WlSjWN3Ti/kmhueQB0pv2o
	 OJw28ESzRqJ4WDnv955ZS6CPSY1GoVMKGkt+AczThyPyubBZd162BygwzjpBvhWuvv
	 er6tYRUHUgtGZFhZgBYlTvFaAQ1Wf4eU13iZzDjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbfFFRz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 13:55:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:43326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728762AbfFFRz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 13:55:56 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1C132083E;
        Thu,  6 Jun 2019 17:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559843755;
        bh=AQujoUskv1cUCT/ttXfe2eKJQcGVonInZu44yu7SV50=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=2ve19ZUuliCz0eGq+XJlmjzhukF/h0t8PK7p8WRLuGY8oa/jMeGFg5ON4XdjBhUAr
         04hMMqOKDmR0f9l7eyvv7QMcTUh4KKEAi31AR0WXADTPx7YIk1Fqfj0gaXPrOXtiDi
         jGWe2vH5O6EtL8VAW/2hxrXeUFwJ80tJJQze5hG0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190529093937.21748-1-yuehaibing@huawei.com>
References: <20190512100328.27136-1-yuehaibing@huawei.com> <20190529093937.21748-1-yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>, mturquette@baylibre.com,
        t-kristo@ti.com, tony@atomide.com
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3] clk: ti: Remove unused functions
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-omap@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
User-Agent: alot/0.8.1
Date:   Thu, 06 Jun 2019 10:55:54 -0700
Message-Id: <20190606175555.B1C132083E@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting YueHaibing (2019-05-29 02:39:37)
> They are not used any more since
> commit 7558562a70fb ("clk: ti: Drop legacy clk-3xxx-legacy code")
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Suggested-by: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Applied to clk-next


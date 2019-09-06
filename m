Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC11C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 17:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9202208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 17:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567790810;
	bh=YRMcR+HQrUeaDrLBRje8EoVrRR1wLTS84uYBmVgT4XY=;
	h=In-Reply-To:References:To:From:Cc:Subject:Date:List-ID:From;
	b=qSS5NnIHyX1iO28TBCtUzRX6sCw4Qz0StKTELYua3tMfO3mA3qHGBQYk7QQUablgC
	 cbebRguWuCaUQHbMS5ZRcMVLSVnn5yw0Sc9A6u40/DyJh9AJT7DsGVV1myAk5vu3rn
	 HheQpNo0xUq+tDf2s6uisgGqnnNwbBHT2AAmO6Q0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406087AbfIFR0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 13:26:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731974AbfIFR0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 13:26:47 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB10820838;
        Fri,  6 Sep 2019 17:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567790806;
        bh=YRMcR+HQrUeaDrLBRje8EoVrRR1wLTS84uYBmVgT4XY=;
        h=In-Reply-To:References:To:From:Cc:Subject:Date:From;
        b=kcF8MyZtZT18CxficZr2uGAFgvh94CvmOBu7AazrLr/OpzVOwdzsdpKhQz8rWZiSB
         nyOTAEll2C8mfibpJkbSKYxj4KWKnIH/ldMXvTStSJMui1m9wrEZnZcr30ArmiruCQ
         euOMvhx45D5PkBUP4RcyrilCfCpXkxbi5rNrbcqY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190816135341.52248-1-yuehaibing@huawei.com>
References: <20190816135341.52248-1-yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>, info@metux.net,
        mturquette@baylibre.com, robh@kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH -next] clk: st: clkgen-fsyn: remove unused variable 'st_quadfs_fs660c32_ops'
User-Agent: alot/0.8.1
Date:   Fri, 06 Sep 2019 10:26:45 -0700
Message-Id: <20190906172646.BB10820838@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting YueHaibing (2019-08-16 06:53:41)
> drivers/clk/st/clkgen-fsyn.c:70:29: warning:
>  st_quadfs_fs660c32_ops defined but not used [-Wunused-const-variable=3D]
>=20
> It is never used, so can be removed.
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Applied to clk-next


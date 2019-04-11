Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C33C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A4920850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555008356;
	bh=CuM4rO4xmAWPMutjm3yhUUYsLmMe7b3+zQLDNHQHtik=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=WdEjiUrFR3ibAP/+PbqW+r3XMQO4rNFCM3YMAL66p9AIm+WQ8WKsdkKgtmBLJloDj
	 iOw6EdKbMF59tawUbfTX2qJDy1CsRS3tXHkWjYzB811Tig6bmFZ3UhoOCMNf4pMw6y
	 TbGWr/9rVv6KpZnDjhNdc/3QJpb2ZIHtFWDLrxDA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbfDKSpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 14:45:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:59258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbfDKSpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 14:45:53 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E77C2083E;
        Thu, 11 Apr 2019 18:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555008353;
        bh=CuM4rO4xmAWPMutjm3yhUUYsLmMe7b3+zQLDNHQHtik=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=SKr2dRXNDwj4dOkHoAPMf20VefvJe/Ynp31/VGr2fNiO3fbWdQDLUaQEJ2gw90xpE
         w4sC3OwCeLwBP6q/K35PnaqL4IuaMXFnQjw7gfm/UrCCeZNK7ZojDI2WnlXKvD2FGx
         zIUCgTX8WWtL/Dp8HgEmjmWI5HH4X8Dl/SYdnrbo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190319153504.23072-1-yuehaibing@huawei.com>
References: <20190319153504.23072-1-yuehaibing@huawei.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH -next] clk: tegra: Make tegra_clk_super_mux_ops static
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
To:     Yue Haibing <yuehaibing@huawei.com>, jonathanh@nvidia.com,
        mturquette@baylibre.com, pdeschrijver@nvidia.com,
        pgaikwad@nvidia.com, thierry.reding@gmail.com
Message-ID: <155500835238.20095.14738602496154666995@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 11 Apr 2019 11:45:52 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yue Haibing (2019-03-19 08:35:04)
> From: YueHaibing <yuehaibing@huawei.com>
>=20
> Fix sparse warning:
>=20
> drivers/clk/tegra/clk-super.c:124:22:
>  warning: symbol 'tegra_clk_super_mux_ops' was not declared. Should it be=
 static?
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Applied to clk-next


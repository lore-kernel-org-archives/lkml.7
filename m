Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2B1ECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 23:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 123F121848
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 23:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571268858;
	bh=L+x36Hr7mn62wktApT7ZWsmNPWQ59k80ebb+ftQV7LU=;
	h=In-Reply-To:References:From:To:Cc:Subject:Date:List-ID:From;
	b=LcYly1ECROxKGFtDE1444nAzjPDjf4gCAcWjoFb4ssL7xY9gXG0ICku8uDK/m7qx0
	 S52im2Npqb7CpzrAUTrDsomHpq8islDCTnAeeSALkMmwWOzMGI3w7oRb51AKUl7VC5
	 UNeBF7uPYDWNwjVA3x/O8BJ4Jv1ijJEm3Bh+0l/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438939AbfJPXeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 19:34:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:55964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732849AbfJPXeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 19:34:11 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32EA32168B;
        Wed, 16 Oct 2019 23:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571268851;
        bh=L+x36Hr7mn62wktApT7ZWsmNPWQ59k80ebb+ftQV7LU=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=csThAAc9MVoj9pVTWHJZpOpYOd3XIEFrGD5dH/zdjecOxNODOE9PWZOOWaumrciBN
         0jEpI2yWfHn92rot7f1D1pSKX8Ir0nxahAkNplaBHGNo3rg+RuS4jKM5c2+2JhUw6p
         +bLKzZDWJON1vHgdizpRZNSbjwJdK1Q3BRDxGRw8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191015142259.17216-1-yuehaibing@huawei.com>
References: <20191015142259.17216-1-yuehaibing@huawei.com>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Eugeniy.Paltsev@synopsys.com, YueHaibing <yuehaibing@huawei.com>,
        mturquette@baylibre.com
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH -next] clk: axs10x: use devm_platform_ioremap_resource() to simplify code
User-Agent: alot/0.8.1
Date:   Wed, 16 Oct 2019 16:34:10 -0700
Message-Id: <20191016233411.32EA32168B@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting YueHaibing (2019-10-15 07:22:59)
> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Applied to clk-next


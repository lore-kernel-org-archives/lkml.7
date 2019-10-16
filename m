Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36951FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 23:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D70821848
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 23:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571268866;
	bh=vteasG9t82lTuUd1FLxsGGoHzxtVjFCukWZwh1O1yTw=;
	h=In-Reply-To:References:From:To:Cc:Subject:Date:List-ID:From;
	b=ghGv2zOQ8IIYqHwg2Y0SW25jOayg791isNj/4MOiwB8gYcwBJAlPohFe3qqtoI2Ob
	 RbzGpOyiFCrBeiVJVmpPgJ8Myx/WQMnknYL43Lytfdya5wtnIv2VkNDxK2HIeFIpP8
	 vXKueuiOfSArQTqpZKZUqYPHTtdBX/yZQ5nz8dak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439063AbfJPXeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 19:34:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728302AbfJPXeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 19:34:23 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCA782168B;
        Wed, 16 Oct 2019 23:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571268862;
        bh=vteasG9t82lTuUd1FLxsGGoHzxtVjFCukWZwh1O1yTw=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=IJCEHxCyF/QrZcX1ouR2Xs87dz0bNKCt5dCEU2dtoyrONT+mSIiaEMnpeI3tAKWnd
         PvioMJG9hafa5yrkztUz0Emnqt23HrRJl78oroPpPjm3trt2MeRsBm0ofYHYE2jv8p
         2+zO2yQ8jmca61oU2cjWsnjZ2Enjzkypu/J18af8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191015142424.25944-1-yuehaibing@huawei.com>
References: <20191015142424.25944-1-yuehaibing@huawei.com>
From:   Stephen Boyd <sboyd@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>, cw00.choi@samsung.com,
        kgene@kernel.org, krzk@kernel.org, mturquette@baylibre.com,
        s.nawrocki@samsung.com, tomasz.figa@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH -next] clk: s3c2410: use devm_platform_ioremap_resource() to simplify code
User-Agent: alot/0.8.1
Date:   Wed, 16 Oct 2019 16:34:22 -0700
Message-Id: <20191016233422.CCA782168B@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting YueHaibing (2019-10-15 07:24:24)
> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Applied to clk-next


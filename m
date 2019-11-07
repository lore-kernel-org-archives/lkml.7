Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67270FC6195
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 22:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F40921882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 22:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573167347;
	bh=7zGw+sMZ0nVOb+x0yOBgQB0+CeXv7FHyjZHL4J39OMQ=;
	h=In-Reply-To:References:From:To:Cc:Subject:Date:List-ID:From;
	b=GAJSjq4ls7UaSdqUYhO5cWyqtBeWNjOrkg0BhWW/3hymUxs0C8PC2BkSh5H2xyY8F
	 1FoImgmu+fO/MdDBBEPd5kCMwFE5iFsNkqsPh4QSbYlMmx05NH2gjiqGPbRe5vV7/H
	 FTkxuipUKwYsLtitqj1whqB/xsur/x4gjNiIsoJw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfKGWzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 17:55:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:51338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfKGWzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 17:55:45 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8D752085B;
        Thu,  7 Nov 2019 22:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573167345;
        bh=7zGw+sMZ0nVOb+x0yOBgQB0+CeXv7FHyjZHL4J39OMQ=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=1oYy1ntU3KvDDNlcp2PJZUS3a+EqlTaIfIQOnzOI8iUGS/cT7p8dPD21Yqi00T7kZ
         UvsgFaIIyhtPCRMegpHWeL5kpXQRV04wXglWDHuw6Lo6rAl1+M8gurVzmbw9lpJiZq
         +Va1pfDTLuDo4pfVrPU22DxpuBMN2ZREmdfArNe4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1573117429-9175-1-git-send-email-rajan.vaja@xilinx.com>
References: <1573117429-9175-1-git-send-email-rajan.vaja@xilinx.com>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Rajan Vaja <rajan.vaja@xilinx.com>, dan.carpenter@oracle.com,
        gustavo@embeddedor.com, jolly.shah@xilinx.com,
        m.tretter@pengutronix.de, michal.simek@xilinx.com,
        mturquette@baylibre.com
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>
Subject: Re: [PATCH] clk: zynqmp: Extend driver for versal
User-Agent: alot/0.8.1
Date:   Thu, 07 Nov 2019 14:55:44 -0800
Message-Id: <20191107225544.E8D752085B@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajan Vaja (2019-11-07 01:03:49)
> Add Versal compatible string to support Versal
> binding.
>=20
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---

Can you send this as a patch series instead of a collection of different
patches all sent individually? It's hard to track the topics without
proper threading in my MUA.

>  drivers/clk/zynqmp/clkc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20

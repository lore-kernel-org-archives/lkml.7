Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494F5ECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 23:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E54B2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 23:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571268816;
	bh=sb6zxmY9F7HAXLQZ5rcVLMnMNdNt5Cwq7bWYoCgvZC4=;
	h=In-Reply-To:References:From:To:Cc:Subject:Date:List-ID:From;
	b=BO3w5fNWGMlUKC0QYiJa6brHREseDO/YmHF1cERUuW/UKx6kOjpKWBthqSLM00M6G
	 TjRp+7E+xwG2hFZuBcR70ZOlLX+77LdcHHWdHJrmBYibqy5albSxjIl8msYGwBA7U2
	 VtZz9vfUKJbUplIeMat5tTp732gsE4+lc9ZA3OCI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438562AbfJPXdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 19:33:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732849AbfJPXdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 19:33:33 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 240BE21925;
        Wed, 16 Oct 2019 23:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571268813;
        bh=sb6zxmY9F7HAXLQZ5rcVLMnMNdNt5Cwq7bWYoCgvZC4=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=mrxbGz/h9uZnQ++n6wK3oCyA+agmC5Q6fgBCSxKkxhv0F5tzxL9S/3qEeAdn7LQzG
         yw5gBtgLZdJ37LJ9dTo6FpprPqJTMjKLWysFFPC2qu/avxqgRet1QC+ANMZerEp05S
         Q30lSUSeOEx/sqJd5M+R0ux5bSVqcrMXoecNuVmg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191015121421.26144-1-yuehaibing@huawei.com>
References: <20191015121421.26144-1-yuehaibing@huawei.com>
From:   Stephen Boyd <sboyd@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>, chunfeng.yun@mediatek.com,
        drinkcat@chromium.org, erin.lo@mediatek.com,
        matthias.bgg@gmail.com, mturquette@baylibre.com, robh@kernel.org,
        weiyi.lu@mediatek.com, yong.liang@mediatek.com
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH -next] clk: mediatek: mt8183: use devm_platform_ioremap_resource() to simplify code
User-Agent: alot/0.8.1
Date:   Wed, 16 Oct 2019 16:33:32 -0700
Message-Id: <20191016233333.240BE21925@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting YueHaibing (2019-10-15 05:14:21)
> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Applied to clk-next


Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29EAFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 23:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78EB721925
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 23:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571268832;
	bh=J0c1fc+cVlOSedR6bxWcZ3BNhUFkVY/5owItVepDo14=;
	h=In-Reply-To:References:From:To:Cc:Subject:Date:List-ID:From;
	b=B0pgMdt2yMMWsDROcy8hPSh8S9uuIP+oZBQ4heylMz120Ix4LhlslatjDq6NWyiSk
	 avCweObzbSB42Hu85jCp+E+lhMDSoTHe0UCXJjB45SkMuGXN+DV3LtCtWrvLJnjZJi
	 jChZ+VLoWs7XyatvPVe+3XTxdwTS/rl07cIq9q3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438858AbfJPXdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 19:33:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:55678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732849AbfJPXdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 19:33:49 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC30621A49;
        Wed, 16 Oct 2019 23:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571268828;
        bh=J0c1fc+cVlOSedR6bxWcZ3BNhUFkVY/5owItVepDo14=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=ravOVQCp8V/0fJXEs3ewm1/jkVXFZTtklaupE62sRKCFtO8Tiz2GknIp8fK6Y2a93
         K2yFDI0zmFgPTJjGZvtgAKYGVaGocf3sxXdFgt23wPlE2vTr8zzBPBEXWkjD+iDKhL
         x5ZaCzE7g7nQz0lNw7Npz5oGRXi6bLt00nyGz05U=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191015124226.25792-1-yuehaibing@huawei.com>
References: <20191015124226.25792-1-yuehaibing@huawei.com>
From:   Stephen Boyd <sboyd@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>, matthias.bgg@gmail.com,
        mturquette@baylibre.com, robh@kernel.org, ryder.lee@mediatek.com,
        wenzhen.yu@mediatek.com
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH -next] clk: mediatek: mt7629: use devm_platform_ioremap_resource() to simplify code
User-Agent: alot/0.8.1
Date:   Wed, 16 Oct 2019 16:33:48 -0700
Message-Id: <20191016233348.BC30621A49@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting YueHaibing (2019-10-15 05:42:26)
> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Applied to clk-next


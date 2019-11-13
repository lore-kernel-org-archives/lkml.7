Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CDCC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B1B206EE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573681209;
	bh=M+nipflJymUR7+6kjYIKQWkkOgtmFWX20qEyoriHsD8=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=JB4JM1o8C+qU//94197jraxGpRoJwkTG6/CKPvALm+T6jqT/S2A7PpOAOntgDp0Qo
	 VkdEDzgzUWGctG9ZFd4jwwkoLCiBBM7bvWkW96PzJVue7ZxGRduyQaDcB7zW0A8h5c
	 8ZA8EWPGFp52icsQzS1/dReFg4trLLkWQMdf/i5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfKMVkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:40:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:39544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbfKMVkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:40:06 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F826206E5;
        Wed, 13 Nov 2019 21:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573681207;
        bh=M+nipflJymUR7+6kjYIKQWkkOgtmFWX20qEyoriHsD8=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=OnDe1A/nWN7+PYH6RwHPZdT674aBQCp3OhjCKTHwbOZj7pBeQxyAwlQL57Q3MAI0y
         5yVZ70DGtBIiuiEX07mxJIHR4GgE+pqDv3jyXXhMwl9JnrLXCf7aWSwG60+P5xz3sC
         yJayvNgD/sav/rrTsEQlBGuO3xQCGGxq+7swd0+Y=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191111140420.36092-1-yuehaibing@huawei.com>
References: <20191111140420.36092-1-yuehaibing@huawei.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     gregory.clement@bootlin.com, mturquette@baylibre.com,
        tiny.windzz@gmail.com, yuehaibing@huawei.com
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH -next] clk: armada-xp: remove unused code
User-Agent: alot/0.8.1
Date:   Wed, 13 Nov 2019 13:40:05 -0800
Message-Id: <20191113214007.2F826206E5@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting YueHaibing (2019-11-11 06:04:20)
> drivers/clk/mvebu/armada-xp.c:171:38: warning:
>  mv98dx3236_coreclks defined but not used [-Wunused-const-variable=3D]
> drivers/clk/mvebu/armada-xp.c:213:41: warning:
>  mv98dx3236_gating_desc defined but not used [-Wunused-const-variable=3D]
>=20
> They are not used since commit 337072604224 ("clk: mvebu:
> Expand mv98dx3236-core-clock support").
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Applied to clk-next


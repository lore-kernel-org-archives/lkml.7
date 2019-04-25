Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72435C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828632088F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556228368;
	bh=QV+KhoMm+qvubf4BBbcuj+P6ndycnsFc4a3jxIeQzsI=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=rm1TV3iabaafcD3ZevmqrW1jUOrmF6b3rqXiYA+/0JC/WSvcKMR5TzlhehsBRtWYb
	 oSZkACpqPqW8wuXWRAOFnZHyJqD3a6XOWHWd9eHHTSfk0PHSj82C6cuAwo7wWD7X48
	 gx7CxCBhXrIwh+E3rfLD1KzXF0zuOktAJTF+HXMw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731338AbfDYVj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:39:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727179AbfDYVj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 17:39:26 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7537206BF;
        Thu, 25 Apr 2019 21:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556228365;
        bh=QV+KhoMm+qvubf4BBbcuj+P6ndycnsFc4a3jxIeQzsI=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=v1fhsiGq/KOFeGeRZUyGATJ50iAs47cuQJdH8c6Na+xVcmoZNLLgAFQ9ya1kZlGDG
         NS1vjhycH/ByHs9COR7DTGUZlfkQiKb/8tlKIo8nRRXLI0eIYJ7JzXM14Tjapltbol
         6xmm2mxA+xfCVDewxUsWmuTk5juHN9qrxKhZh26E=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190323211612.860-15-fparent@baylibre.com>
References: <20190323211612.860-1-fparent@baylibre.com> <20190323211612.860-15-fparent@baylibre.com>
Cc:     sean.wang@kernel.org, ryder.lee@mediatek.com,
        hsin-hsiung.wang@mediatek.com, wenzhen.yu@mediatek.com,
        chaotian.jing@mediatek.com, yong.mao@mediatek.com,
        jjian.zhou@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-clk@vger.kernel.org, stephane.leprovost@mediatek.com,
        Fabien Parent <fparent@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 14/24] clk: mediatek: add clock driver for MT8516
To:     Fabien Parent <fparent@baylibre.com>, mark.rutland@arm.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org
Message-ID: <155622836474.15276.3720750789980463871@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 25 Apr 2019 14:39:24 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Fabien Parent (2019-03-23 14:16:02)
> Add the clock driver for the MT8516 SoC.
>=20
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---

Applied to clk-next


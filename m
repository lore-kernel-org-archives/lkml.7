Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2166C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5BCD217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553800194;
	bh=SprQsEdRnbpNMH9Z51mIFuD7A0vDVpdtNwoNemDpD5c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rwDy7LnOVBivTyWc2veCm2crM6KE2LBjpcTAZKe9PIXXaUS+sZ7yZkfWwpLV8mS+4
	 WiA1L2d8Huf4q+vxzrZIHBDZqgKMerAcU8YfOf1XRJ+O9ETswkJQfnc4OWbNsQTf+t
	 7hOTSy9a4jjTgdDGoyA9vZeP6CjcP9TYdS3xQSVg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfC1TJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:09:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:48450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbfC1TJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 15:09:51 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 994112184E;
        Thu, 28 Mar 2019 19:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553800190;
        bh=SprQsEdRnbpNMH9Z51mIFuD7A0vDVpdtNwoNemDpD5c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ldtFI4OXhHJe7st9mhVOtyH5YnPmqc76bxdxPvOFecyqA+vN0DFfLI7T/ICl2bf0B
         kiCaH73+5a5r9WlD5Kr2QWsCHcFlVjQaqWvz2U/sRzQQI1HpBiIzt09Bx/kgVCEhhK
         KJgjgk7yaomEA67K0ZWZYe0076JDFsWMp2FS5+zA=
Received: by mail-qt1-f178.google.com with SMTP id k2so24482880qtm.1;
        Thu, 28 Mar 2019 12:09:50 -0700 (PDT)
X-Gm-Message-State: APjAAAU2/ZloPFNP0PFbR4DlT8k6qXTYTrxBkP8Tm8ldeyoPYv+2QyaZ
        NKpVZgqLvnoaMGStXyPZ5FMa/mHO9hyc2LmJJA==
X-Google-Smtp-Source: APXvYqx5fUpR7gu+fayjaeAP2rETOBgF5evOFtfCbK33QT0vsqfLRfoUFlfmsZHhpFfmBn2HaYq0lEJzna81DRFkyvM=
X-Received: by 2002:a0c:b018:: with SMTP id k24mr37635042qvc.218.1553800189858;
 Thu, 28 Mar 2019 12:09:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190323211612.860-1-fparent@baylibre.com> <20190323211612.860-12-fparent@baylibre.com>
In-Reply-To: <20190323211612.860-12-fparent@baylibre.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 28 Mar 2019 14:09:38 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKdWjtzNVtAm1aO6Dv+bDmurJ2q709Uakf6xP4Co+HgWg@mail.gmail.com>
Message-ID: <CAL_JsqKdWjtzNVtAm1aO6Dv+bDmurJ2q709Uakf6xP4Co+HgWg@mail.gmail.com>
Subject: Re: [PATCH 11/24] dt-bindings: mediatek: topckgen: add support for MT8516
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sean Wang <sean.wang@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Wenzhen Yu <wenzhen.yu@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Yong Mao <yong.mao@mediatek.com>, jjian.zhou@mediatek.com,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        stephane.leprovost@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 4:17 PM Fabien Parent <fparent@baylibre.com> wrote:
>
> Add binding documentation of topckgen for MT8516 SoC.
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  .../arm/mediatek/mediatek,topckgen.txt        |   1 +
>  include/dt-bindings/clock/mt8516-clk.h        | 192 ++++++++++++++++++
>  2 files changed, 193 insertions(+)
>  create mode 100644 include/dt-bindings/clock/mt8516-clk.h

Acked-by: Rob Herring <robh@kernel.org>

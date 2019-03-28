Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE49C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3523220811
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553800364;
	bh=AjtXW1qFyIWtNsZQn9MisAT+W4qGa/onDY41TQMhoo8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2GpqbqxbGQ51lYAVNAylDrxPm8Daa3btmTnz7sF3aJWrYRnt88eNhQCI7BUG2dsTa
	 58qQBw7yZdU2WwgX2CmMqFrTwnyutDJsJGVhAHhkNuFU8CQ7MIDTZ9Qj6V9yWEV4mr
	 AibEBSTE9m7HaIup0FMs5NKCBvMJT/vSPqRsgjwo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfC1TMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:12:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:49724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbfC1TMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 15:12:42 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C2482183F;
        Thu, 28 Mar 2019 19:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553800361;
        bh=AjtXW1qFyIWtNsZQn9MisAT+W4qGa/onDY41TQMhoo8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TjYYKE4PIuXpiQPr13NBoJK8omqwPoFwuOXnKDPSvuFf7yI6dHcG2LxMHFvVY1o0M
         rT1pKY+JKjs2UWedLFr3dv+3gqINY03wBXUCUa4houvysJ8ji/ypd0CHBDSLm6m28+
         BfDZjzNzswnnBf0QxKXrB0mnTMAywwO9krvvIN/8=
Received: by mail-qk1-f171.google.com with SMTP id a71so6585184qkg.2;
        Thu, 28 Mar 2019 12:12:41 -0700 (PDT)
X-Gm-Message-State: APjAAAUZQ/BhkMXUeqcWiJJCljbG99TD+QR/Ju6cLR1WdwrTQJNxhp/k
        kgylM1szE53kq3p8jond6X7pNH+Vz1IfQPWUHA==
X-Google-Smtp-Source: APXvYqzKkT6oM1n9B7ums3ALQfVo0PgfUF1GKglpP/069QHAsRUWGejZuGF4pJboP2nTMoW5tX7gcfLGVF52bu82t74=
X-Received: by 2002:a37:9186:: with SMTP id t128mr7373301qkd.326.1553800360930;
 Thu, 28 Mar 2019 12:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190323211612.860-1-fparent@baylibre.com> <20190323211612.860-20-fparent@baylibre.com>
In-Reply-To: <20190323211612.860-20-fparent@baylibre.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 28 Mar 2019 14:12:29 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKJgxERJOcETr638vbdC-HzVs9=nFcQ1eDjgKrJjPRn1w@mail.gmail.com>
Message-ID: <CAL_JsqKJgxERJOcETr638vbdC-HzVs9=nFcQ1eDjgKrJjPRn1w@mail.gmail.com>
Subject: Re: [PATCH 19/24] dt-bindings: spi: spi-mt65xx: add support for MT8516
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
> Add binding documentation of spi-mt65xx for MT8516 SoC.
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-mt65xx.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>

Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BF2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59ABF20811
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553800158;
	bh=YM0FDythSmRXaoeiDaMk/3/dGc984JP5wlb+G0V2XTg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=c+iUIU8J6I1cKp1OWaWkMrXpR9TabQn55tecKgCojz5h62JUZrG9MAcxz6kK7K7ai
	 ngCicygU6XsPBlK436Ouniw/SPANYBfdrFqdCG+4XD6ylS7rUBtfwiCBLv+kXejkKV
	 oomjUOUllGtVJtRmjAub1q44lmHxzept4Pj6OQBw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfC1TJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:09:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:48204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbfC1TJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 15:09:16 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74B2B2184D;
        Thu, 28 Mar 2019 19:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553800155;
        bh=YM0FDythSmRXaoeiDaMk/3/dGc984JP5wlb+G0V2XTg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sEgWcI/zI+Ajx6aFyOyvnVAbTLa3/8QpNmBvEUO1XqyO6NVdnyJzDYP/K+oHpT4Gj
         ddFwEI34jN9WJ3vJ1mVgyBYWTLdUrLyvDrmVIZrcOpy5oPBzl+NeeIOuyp9zyjA0WX
         bOiHVN1BTDDlR97bYGgPUWyEiXOiWIKcnAasowf0=
Received: by mail-qk1-f176.google.com with SMTP id c189so12853519qke.6;
        Thu, 28 Mar 2019 12:09:15 -0700 (PDT)
X-Gm-Message-State: APjAAAWaz8g+rIlhS2B5sfigXZwqq/mxZneHcUoiFrXPtfThwRKB5yVE
        EiP8clllTB8q71kus8u6ShGM1tXVBkIySpoP8g==
X-Google-Smtp-Source: APXvYqzNYuLs7TyK5Cdwyhq0msjygssh3VHr7+WEh0gZ4K+rWIsLFSl/gO6BjI6tPg4LxpqOoteFNtRvXcrvTXVFwcU=
X-Received: by 2002:a37:9186:: with SMTP id t128mr7357627qkd.326.1553800154674;
 Thu, 28 Mar 2019 12:09:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190323211612.860-1-fparent@baylibre.com> <20190323211612.860-4-fparent@baylibre.com>
In-Reply-To: <20190323211612.860-4-fparent@baylibre.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 28 Mar 2019 14:09:03 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKr=SNqcFGQ53L6HVV1ec+aP_n_SZwtkTa3O8HqHhW51w@mail.gmail.com>
Message-ID: <CAL_JsqKr=SNqcFGQ53L6HVV1ec+aP_n_SZwtkTa3O8HqHhW51w@mail.gmail.com>
Subject: Re: [PATCH 03/24] dt-bindings: pwrap: mediatek: add pwrap support for MT8516
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

On Sat, Mar 23, 2019 at 4:16 PM Fabien Parent <fparent@baylibre.com> wrote:
>
> Add binding documentation of pwrap for MT8516 SoCs.
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  Documentation/devicetree/bindings/soc/mediatek/pwrap.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>

Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90697C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E75C20811
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553800251;
	bh=DjyvtDJ2qdBVgDAsHRdUYJlFrSFRjFf0ySQ/HKDt1JQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=k7AGFXyIveU+amwTqQCYbvdhIjSiah7a8WQavQsuzSm2GD4z437+Tr5Hz2cS25j80
	 rzW8PRDWV6QzJwNYMfZ3ZXfeK5HiPbHAOKZ/agEXVl1NFdZnF4WDQ4/7dwqCCX+zyd
	 is+JuYqKTADaUwun8T+8TnNnDY4uTf4ceQMV0YoQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfC1TKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:10:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:48750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbfC1TKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 15:10:49 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FC322183F;
        Thu, 28 Mar 2019 19:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553800248;
        bh=DjyvtDJ2qdBVgDAsHRdUYJlFrSFRjFf0ySQ/HKDt1JQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dcIqhFA3vbpak2nyU8+EPjB1CNVVUhU3/wAy9hK0pku3TruuPy8+wLS3vhRoZTT4b
         JUnAltbPQpA96VWVDV5uTxFq2rgYZz99P1IbNIqM04frXlg3NUHI41tG9uOyYghQGU
         n4iWdX/Nskv6Z+fZjbrG+cWxMpTVsc34UXShPO7A=
Received: by mail-qk1-f171.google.com with SMTP id a71so6581254qkg.2;
        Thu, 28 Mar 2019 12:10:48 -0700 (PDT)
X-Gm-Message-State: APjAAAVfZk9KBlEaJejt+fIThcSTBdvgViIuB0GZVTcQAKofb+xjdaJO
        nIAeWlIlVLTgOimuQ8FNFTCqyH6R4mZYSIc1zA==
X-Google-Smtp-Source: APXvYqyWoK5oBIwqhg79nJ8aTEfwsYhluIKyKhCLbgJBeMOWABFFSST2oCZ57y/xkRwVhO6apYa+wf3QbxwUPJEzWME=
X-Received: by 2002:ae9:e417:: with SMTP id q23mr32628158qkc.29.1553800247549;
 Thu, 28 Mar 2019 12:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190323211612.860-1-fparent@baylibre.com> <20190323211612.860-13-fparent@baylibre.com>
In-Reply-To: <20190323211612.860-13-fparent@baylibre.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 28 Mar 2019 14:10:36 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLCCHd8bs6DZJw3qGRjvx17baQ2v_SiPpBhsjNFOJFCUQ@mail.gmail.com>
Message-ID: <CAL_JsqLCCHd8bs6DZJw3qGRjvx17baQ2v_SiPpBhsjNFOJFCUQ@mail.gmail.com>
Subject: Re: [PATCH 12/24] dt-bindings: mediatek: infracfg: add support for MT8516
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
> Add binding documentation of infracfg for MT8516 SoC.
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  .../bindings/arm/mediatek/mediatek,infracfg.txt          | 1 +
>  include/dt-bindings/clock/mt8516-clk.h                   | 9 +++++++++
>  2 files changed, 10 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>

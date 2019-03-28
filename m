Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D02C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F142B206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553800948;
	bh=K+gwKGzqQARAaXOLz90I/Z/+A6iJ1UiZQQE5zJ2BzsM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ke//mN+gWtREhJptPiqiGlwRpCXg30zFFOXhGgQK4X+mn0J67I5s0dz60/S3i0GIK
	 MsrB6EXFyZeM3nOA/7O+wPjKdH8hHM6DkCR5RIknYplcqtwl0iN5UQZkOi0bUffXXf
	 TGSqejEXX1+jHPOGodHFhEwhU8cOpKXYgW6ibyf4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfC1TW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:22:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:52838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfC1TWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 15:22:25 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5131206B7;
        Thu, 28 Mar 2019 19:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553800944;
        bh=K+gwKGzqQARAaXOLz90I/Z/+A6iJ1UiZQQE5zJ2BzsM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=z4isrTAIm3Pn7Mbrh/sQHkUdJwopEcAwBcZDxotZbQ/usH1x3tDRtNGyPkIetW/hg
         XTaS+tF5lra0AHpbbmWvldhxo0KByenLD559vL3EQlULjYvBq+B+kF02eXebSEKIEn
         22ujsCjJeeMZjrNqv9Yg0ttiaMTKDW6nFHw3Zi88=
Received: by mail-qt1-f175.google.com with SMTP id z17so24449108qts.13;
        Thu, 28 Mar 2019 12:22:23 -0700 (PDT)
X-Gm-Message-State: APjAAAUAR/FD/dCMvRHiWyvVhvJ9/g4jvvLAZFZ+Fbc7JHNIWHY1WaFh
        6fHe47NzCMkM5CwLTOJgrtFzOGU+7pWdtccgxw==
X-Google-Smtp-Source: APXvYqzQHiylD1g/X2+qiXuMZjxX0Xk5odu/QGqdW7lTJGavIV8lF4iP0fTc41YVwzuDqcqmmBj5kQI4PE0WhpluEvo=
X-Received: by 2002:a0c:c11c:: with SMTP id f28mr35598760qvh.106.1553800943228;
 Thu, 28 Mar 2019 12:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190323211612.860-1-fparent@baylibre.com> <20190323211612.860-24-fparent@baylibre.com>
In-Reply-To: <20190323211612.860-24-fparent@baylibre.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 28 Mar 2019 14:22:12 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+Q06O84-MTpgTWGG312VXm_vGOkjMCjtWuS0eZ-j_0yw@mail.gmail.com>
Message-ID: <CAL_Jsq+Q06O84-MTpgTWGG312VXm_vGOkjMCjtWuS0eZ-j_0yw@mail.gmail.com>
Subject: Re: [PATCH 23/24] arm64: dts: mediatek: add dtsi for MT8516
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
> The MT8516 SoC provides the following peripherals: GPIO, UART, USB2,
> SPI, eMMC, SDIO, NAND, Flash, ADC, I2C, PWM, Timers, IR, Ethernet, and
> Audio (I2S, SPDIF, TDM).
>
> This commit is adding the basic dtsi file with the support of the
> following IOs: GPIO, UART, SPI, eMMC, I2C, Timers.
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8516-pinfunc.h | 663 ++++++++++++++++++
>  arch/arm64/boot/dts/mediatek/mt8516.dtsi      | 409 +++++++++++
>  2 files changed, 1072 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8516-pinfunc.h
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8516.dtsi

Reviewed-by: Rob Herring <robh@kernel.org>

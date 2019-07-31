Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE4AC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BFE720C01
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564592174;
	bh=Cic2JrM+YjcNDGZKD8kvKDZrx7id5Fahrh8aT8NyBT0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Uju9nLEFcxpuLgMjoES1VHpnkgorfCNJsjz3mFLazSMDtM6XiAsueYGcoqXgAlOBw
	 FQxgyxdA2KUCmh/Sqkm8iO4XV3rDCus8QFxEVmHpxSqbzapFznIpWMy3NQbtHD2J4/
	 ccv9p+X0P8+uzVhjte1oQN/osAmtGqdvZw5BN94Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbfGaQ4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 12:56:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:42800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbfGaQ4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 12:56:12 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F426208E4;
        Wed, 31 Jul 2019 16:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564592171;
        bh=Cic2JrM+YjcNDGZKD8kvKDZrx7id5Fahrh8aT8NyBT0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OSG11j0ovXBywu0fX2l8W0z5qMeemjGHn+yizDeOCR2IWH+d/iXJtJ4IK0/KdsbiJ
         tkgSY3sEjP0BzN3NIDeknh+o1MxDvRgoruqQgvFUUBuSPN8DDZFqijJpS52YAdN+Ej
         sT49EcBWZ2gxc/nz/PzFCsjRdfSsQhWbSIWkp1uQ=
Received: by mail-qt1-f170.google.com with SMTP id 44so36250751qtg.11;
        Wed, 31 Jul 2019 09:56:11 -0700 (PDT)
X-Gm-Message-State: APjAAAUJgle6U6qsFsJr7mhiWMic1azZ57dLHYJHrmP6hWJYBo8868PA
        RshojvheDYYW8LCfjOX2Uk5G86nSmBzdNFA5lQ==
X-Google-Smtp-Source: APXvYqyq5aSqkMkY1jRWObJcHd+QJppxe0Gfq8GLINw2AdMyUd2oGDpfDfAN517bLe0isUjhnIa9VYbJPYtguO8ywn8=
X-Received: by 2002:ac8:3908:: with SMTP id s8mr41133202qtb.224.1564592170319;
 Wed, 31 Jul 2019 09:56:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190731124000.22072-1-narmstrong@baylibre.com> <20190731124000.22072-5-narmstrong@baylibre.com>
In-Reply-To: <20190731124000.22072-5-narmstrong@baylibre.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 31 Jul 2019 10:55:58 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ=RtSxw8m687X_zWKY_V5X9zqt3xrq5gjF8WcEZspg-g@mail.gmail.com>
Message-ID: <CAL_JsqJ=RtSxw8m687X_zWKY_V5X9zqt3xrq5gjF8WcEZspg-g@mail.gmail.com>
Subject: Re: [PATCH 4/6] dt-bindings: arm: amlogic: add support for the Khadas VIM3
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        linux-amlogic@lists.infradead.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 6:40 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> From: Christian Hewitt <christianshewitt@gmail.com>
>
> The Khadas VIM3 uses the Amlogic S922X or A311S SoC, both based on the
> Amlogic G12B SoC family, on a board with the same form factor as the
> VIM/VIM2 models. It ships in two variants; basic and
> pro which differ in RAM and eMMC size:
>
> - 2GB (basic) or 4GB (pro) LPDDR4 RAM
> - 16GB (basic) or 32GB (pro) eMMC 5.1 storage
> - 16MB SPI flash
> - 10/100/1000 Base-T Ethernet
> - AP6398S Wireless (802.11 a/b/g/n/ac, BT5.0)
> - HDMI 2.1 video
> - 1x USB 2.0 + 1x USB 3.0 ports
> - 1x USB-C (power) with USB 2.0 OTG
> - 3x LED's (1x red, 1x blue, 1x white)
> - 3x buttons (power, function, reset)
> - IR receiver
> - M2 socket with PCIe, USB, ADC & I2C
> - 40pin GPIO Header
> - 1x micro SD card slot
>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>

Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62189C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D0B620811
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553800307;
	bh=o2491EKbmckKME0YCVdyHWP2uXdA6xg1SjeMBPDP1dg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=U91xqBK27DCejsTNGEyaonDz5gKemjUSVvUh5HKVlHRMNRugmZZpbBObSxzJLMR+z
	 QkApVVW4WAWA/kceP0PR+u1pkR/x7yCF84iH9FiVgaSsa0m1V0c1J9gc8iz4bKPaYA
	 nqt0/ItiZ8UPoXVgTgHge3Dz2PLhFFESm430Okkc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfC1TLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:11:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:49230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbfC1TLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 15:11:44 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 801FA2184C;
        Thu, 28 Mar 2019 19:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553800303;
        bh=o2491EKbmckKME0YCVdyHWP2uXdA6xg1SjeMBPDP1dg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p6LBJ+wBCiga7jR9M2rxFKLMBAwL817QGPJHLvc0GdGo095m1AlqMfjH0PU1+zeIF
         fTp7Y7sR1byeCTyxuvpvr7kC0Afr1colomyCiIP3vdmUaXzXGDhx3KPhQtUxtqAr6s
         zLTh46V5RDtLU/4EHCkk0WCOKOTMD8gG8+LYVwfY=
Received: by mail-qt1-f182.google.com with SMTP id w30so24441467qta.8;
        Thu, 28 Mar 2019 12:11:43 -0700 (PDT)
X-Gm-Message-State: APjAAAUINaxm74dcXZOD6zwlPzNK8LcZCjo34ho7Rc4XGP+p2ygWeYuk
        VYj55CrYEFD2pQkMhFBD2czSdXiRg2U/K11MYw==
X-Google-Smtp-Source: APXvYqxw06v9Sw7RM35lVoGj/oa0STL3w+sTbEJtR6vdRdp7OsaIxj1x1upX9eI9bvkpLWYMKr6ZeVsYervtek0yn8Q=
X-Received: by 2002:a0c:d7c2:: with SMTP id g2mr9373722qvj.90.1553800302794;
 Thu, 28 Mar 2019 12:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190323211612.860-1-fparent@baylibre.com> <20190323211612.860-16-fparent@baylibre.com>
In-Reply-To: <20190323211612.860-16-fparent@baylibre.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 28 Mar 2019 14:11:31 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJcmjcCv8m3UHM9-fDDMRdRyb-STNyzjom736ugyi-9cg@mail.gmail.com>
Message-ID: <CAL_JsqJcmjcCv8m3UHM9-fDDMRdRyb-STNyzjom736ugyi-9cg@mail.gmail.com>
Subject: Re: [PATCH 15/24] dt-bindings: pinctrl: pinctrl-mt65xx: add support
 for MT8516
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
> Add binding documentation of pinctrl-mt65xx for MT8516 SoC.
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>

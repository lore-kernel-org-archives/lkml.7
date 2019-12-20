Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3A1C2D0D3
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40CF720684
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfLTMAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 07:00:33 -0500
Received: from mx.socionext.com ([202.248.49.38]:46351 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727241AbfLTMAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 07:00:33 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 20 Dec 2019 21:00:31 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 953D2603AB;
        Fri, 20 Dec 2019 21:00:31 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Fri, 20 Dec 2019 21:01:08 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 098D24044A;
        Fri, 20 Dec 2019 21:00:31 +0900 (JST)
Received: from [10.213.132.48] (unknown [10.213.132.48])
        by yuzu.css.socionext.com (Postfix) with ESMTP id CC2D012044A;
        Fri, 20 Dec 2019 21:00:30 +0900 (JST)
Date:   Fri, 20 Dec 2019 21:00:30 +0900
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/6] phy: socionext: Add some improvements and legacy SoC support
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
In-Reply-To: <1573035979-32200-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1573035979-32200-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-Id: <20191220210030.BD1F.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Gentle ping.
Are there any comments about this series?

Thank you,

On Wed, 6 Nov 2019 19:26:13 +0900 <hayashi.kunihiko@socionext.com> wrote:

> This series adds some improvements to PHY interface drivers, and adds legacy SoC
> support that needs to manage gio clock and reset.
> 
> Kunihiko Hayashi (6):
>   phy: socionext: Use devm_platform_ioremap_resource()
>   dt-bindings: phy: socionext: Add Pro5 support and remove Pro4 from
>     usb3-hsphy
>   phy: uniphier-usb3ss: Add Pro5 support
>   phy: uniphier-usb3hs: Add legacy SoC support for Pro5
>   phy: uniphier-usb3hs: Change Rx sync mode to avoid communication
>     failure
>   phy: uniphier-pcie: Add legacy SoC support for Pro5
> 
>  .../devicetree/bindings/phy/uniphier-pcie-phy.txt  | 13 ++-
>  .../bindings/phy/uniphier-usb3-hsphy.txt           |  6 +-
>  .../bindings/phy/uniphier-usb3-ssphy.txt           |  5 +-
>  drivers/phy/socionext/phy-uniphier-pcie.c          | 87 ++++++++++++++++----
>  drivers/phy/socionext/phy-uniphier-usb3hs.c        | 92 ++++++++++++++++------
>  drivers/phy/socionext/phy-uniphier-usb3ss.c        |  8 +-
>  6 files changed, 163 insertions(+), 48 deletions(-)
> 
> -- 
> 2.7.4

---
Best Regards,
Kunihiko Hayashi


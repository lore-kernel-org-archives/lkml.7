Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EE1C4CECE
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 09:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F1A206A1
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 09:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbfJLJBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 05:01:35 -0400
Received: from gloria.sntech.de ([185.11.138.130]:43748 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728536AbfJLI6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 04:58:49 -0400
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iJDES-0006Xs-Sy; Sat, 12 Oct 2019 10:58:36 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Jianqun Xu <jay.xu@rock-chips.com>
Cc:     linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] pinctrl: rockchip: support rk3308 SoC
Date:   Sat, 12 Oct 2019 10:58:36 +0200
Message-ID: <11066785.VItf2zBqlU@diego>
In-Reply-To: <20191012061528.27821-1-jay.xu@rock-chips.com>
References: <20191012061528.27821-1-jay.xu@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 12. Oktober 2019, 08:15:26 CEST schrieb Jianqun Xu:
> Add support for rk3308 SoC from rockchip.
> 
> Jianqun Xu (2):
>   dt-bindings: pinctrl: rockchip: add rk3308 SoC support
>   pinctrl: rockchip: add rk3308 SoC support

both patches
Reviewed-by: Heiko Stuebner <heiko@sntech.de>



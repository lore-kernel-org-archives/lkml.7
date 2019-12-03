Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2541C432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 08:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B327B2068E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 08:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfLCIPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 03:15:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:57678 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727093AbfLCIPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 03:15:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E3C94ACB4;
        Tue,  3 Dec 2019 08:15:33 +0000 (UTC)
Subject: Re: [PATCH 0/6] arm64: Realtek RTD1619 clock and reset controllers
To:     James Tai <james.tai@realtek.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Cheng-Yu Lee <cylee12@realtek.com>, devicetree@vger.kernel.org,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>
References: <20191203073540.9321-1-james.tai@realtek.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <0fcbcb58-6973-d903-91c3-844008094fda@suse.de>
Date:   Tue, 3 Dec 2019 09:15:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191203073540.9321-1-james.tai@realtek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Am 03.12.19 um 08:35 schrieb James Tai:
> This series adds clock and reset controllers for the Realtek RTD1619 SoC.

Thanks - when you resend (in this case I guess because of missing
linux-realtek-soc mailing list), please change the subject prefix to
"PATCH RESEND" (--subject-prefix=) so that people know which one to
reply to.

Let's try to keep the review on the series sent 10 minutes later (:45),
so that everyone receives it.

Thanks,
Andreas

> 
> Cc: Andreas Färber <afaerber@suse.de>
> Cc: Cheng-Yu Lee <cylee12@realtek.com>
> Cc: devicetree@vger.kernel.org
> 
> cylee12 (6):
>   dt-bindings: clock: add bindings for RTD1619 clocks
>   dt-bindings: reset: add bindings for rtd1619 reset controls
>   clk: realtek: add common clock support for Realtek SoCs
>   clk: realtek: add reset controller support for Realtek SoCs
>   clk: realtek: add rtd1619 controllers
>   dt-bindings: clk: realtek: add rtd1619 clock controller bindings
> 
>  .../bindings/clock/realtek,clocks.txt         |  38 ++
>  drivers/clk/Kconfig                           |   1 +
>  drivers/clk/Makefile                          |   1 +
>  drivers/clk/realtek/Kconfig                   |  21 +
>  drivers/clk/realtek/Makefile                  |  12 +
>  drivers/clk/realtek/clk-pll-dif.c             |  81 +++
>  drivers/clk/realtek/clk-pll-psaud.c           | 120 ++++
>  drivers/clk/realtek/clk-pll.c                 | 400 +++++++++++++
>  drivers/clk/realtek/clk-pll.h                 | 151 +++++
>  drivers/clk/realtek/clk-regmap-gate.c         |  89 +++
>  drivers/clk/realtek/clk-regmap-gate.h         |  26 +
>  drivers/clk/realtek/clk-regmap-mux.c          |  63 ++
>  drivers/clk/realtek/clk-regmap-mux.h          |  26 +
>  drivers/clk/realtek/clk-rtd1619-cc.c          | 553 ++++++++++++++++++
>  drivers/clk/realtek/clk-rtd1619-ic.c          | 112 ++++
>  drivers/clk/realtek/common.c                  | 320 ++++++++++
>  drivers/clk/realtek/common.h                  | 123 ++++
>  drivers/clk/realtek/reset.c                   | 107 ++++
>  drivers/clk/realtek/reset.h                   |  37 ++
>  include/dt-bindings/clock/rtk,clock-rtd1619.h |  88 +++
>  include/dt-bindings/reset/rtk,reset-rtd1619.h | 124 ++++
>  21 files changed, 2493 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/realtek,clocks.txt
>  create mode 100644 drivers/clk/realtek/Kconfig
>  create mode 100644 drivers/clk/realtek/Makefile
>  create mode 100644 drivers/clk/realtek/clk-pll-dif.c
>  create mode 100644 drivers/clk/realtek/clk-pll-psaud.c
>  create mode 100644 drivers/clk/realtek/clk-pll.c
>  create mode 100644 drivers/clk/realtek/clk-pll.h
>  create mode 100644 drivers/clk/realtek/clk-regmap-gate.c
>  create mode 100644 drivers/clk/realtek/clk-regmap-gate.h
>  create mode 100644 drivers/clk/realtek/clk-regmap-mux.c
>  create mode 100644 drivers/clk/realtek/clk-regmap-mux.h
>  create mode 100644 drivers/clk/realtek/clk-rtd1619-cc.c
>  create mode 100644 drivers/clk/realtek/clk-rtd1619-ic.c
>  create mode 100644 drivers/clk/realtek/common.c
>  create mode 100644 drivers/clk/realtek/common.h
>  create mode 100644 drivers/clk/realtek/reset.c
>  create mode 100644 drivers/clk/realtek/reset.h
>  create mode 100644 include/dt-bindings/clock/rtk,clock-rtd1619.h
>  create mode 100644 include/dt-bindings/reset/rtk,reset-rtd1619.h
> 


-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)

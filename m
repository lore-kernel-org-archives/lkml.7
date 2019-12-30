Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CC2C2D0DA
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 02:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3463F2075D
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 02:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfL3C5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 21:57:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:56800 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbfL3C5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 21:57:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AF0D1AAF1;
        Mon, 30 Dec 2019 02:57:40 +0000 (UTC)
Subject: Re: [PATCH 00/14] ARM: dts: realtek: Introduce syscon
To:     James Tai <james.tai@realtek.com>
Cc:     linux-realtek-soc@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20191202182205.14629-1-afaerber@suse.de>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <0f4d6872-b764-1c5e-9c2a-4e4e415a4877@suse.de>
Date:   Mon, 30 Dec 2019 03:57:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191202182205.14629-1-afaerber@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Am 02.12.19 um 19:21 schrieb Andreas Färber:
> This patch series factors out system controller multi-function device nodes
> for CRT, Iso, Misc, SB2 and SCPU Wrapper IP blocks.
> 
> It was inspired by my SoC info RFC, as discussed in its cover letter [1].
> 
> Goal of DT is to describe the hardware, and in previous patches we've already
> introduced Realtek's r-bus as node layer. The next step here is to model
> multi-function blocks as nodes. In order to cope with 80-character line limit,
> child nodes are added via reference rather than in-place.

I'm waiting for your Acked-by of the blocks & numbers in these patches. 
Other Realtek engineers are also invited to respond, of course.

Thanks in advance,
Andreas

> Andreas Färber (14):
>    ARM: dts: rtd1195: Introduce iso and misc syscon
>    arm64: dts: realtek: rtd129x: Introduce CRT, iso and misc syscon
>    arm64: dts: realtek: rtd139x: Introduce CRT, iso and misc syscon
>    arm64: dts: realtek: rtd16xx: Introduce iso and misc syscon
>    ARM: dts: rtd1195: Add CRT syscon node
>    dt-bindings: reset: Add Realtek RTD1195
>    ARM: dts: rtd1195: Add reset nodes
>    ARM: dts: rtd1195: Add UART resets
>    arm64: dts: realtek: rtd16xx: Add CRT syscon node
>    ARM: dts: rtd1195: Add SB2 and SCPU Wrapper syscon nodes
>    arm64: dts: realtek: rtd129x: Add SB2 and SCPU Wrapper syscon nodes
>    arm64: dts: realtek: rtd139x: Add SB2 and SCPU Wrapper syscon nodes
>    arm64: dts: realtek: rtd16xx: Add SB2 and SCPU Wrapper syscon nodes
>    dt-bindings: reset: rtd1295: Add SB2 reset
> 
>   arch/arm/boot/dts/rtd1195.dtsi              | 110 ++++++++++++++++---
>   arch/arm64/boot/dts/realtek/rtd129x.dtsi    | 157 ++++++++++++++++++----------
>   arch/arm64/boot/dts/realtek/rtd139x.dtsi    | 157 ++++++++++++++++++----------
>   arch/arm64/boot/dts/realtek/rtd16xx.dtsi    |  91 ++++++++++++----
>   include/dt-bindings/reset/realtek,rtd1195.h |  74 +++++++++++++
>   include/dt-bindings/reset/realtek,rtd1295.h |   3 +
>   6 files changed, 449 insertions(+), 143 deletions(-)
>   create mode 100644 include/dt-bindings/reset/realtek,rtd1195.h

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)

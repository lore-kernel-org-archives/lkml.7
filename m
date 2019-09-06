Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF66C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 10:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F10C206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 10:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389180AbfIFKQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 06:16:06 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:53105 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726931AbfIFKQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 06:16:06 -0400
X-UUID: 35be169ede134e03bb7c75bec3103570-20190906
X-UUID: 35be169ede134e03bb7c75bec3103570-20190906
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 524014696; Fri, 06 Sep 2019 18:16:00 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 6 Sep 2019 18:15:50 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 6 Sep 2019 18:15:50 +0800
Message-ID: <1567764953.472.2.camel@mtksdaap41>
Subject: Re: [PATCH v5 0/3] PM / AVS: SVS: Introduce SVS engine
From:   Roger Lu <roger.lu@mediatek.com>
To:     Kevin Hilman <khilman@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Fan Chen <fan.chen@mediatek.com>,
        "HenryC Chen" <HenryC.Chen@mediatek.com>, <yt.lee@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Date:   Fri, 6 Sep 2019 18:15:53 +0800
In-Reply-To: <20190906100514.30803-1-roger.lu@mediatek.com>
References: <20190906100514.30803-1-roger.lu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: BC4C79346B1AD8DE4D01B67A379430A73C2A7576C913D66AAA878836F8AEDA7A2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excuse me, I forgot to add "changes since" below. Add it back now.

On Fri, 2019-09-06 at 18:05 +0800, Roger Lu wrote:
> 1. SVS driver use OPP adjust event in [1] to update OPP table voltage part.
> 2. SVS dts node refers to CPU opp table [2] and GPU opp table [3].
> 3. SVS dts node refers to thermal efuse [4] and PMIC regulator [5].
> 
> [1] https://patchwork.kernel.org/patch/11092245/
> [2] https://patchwork.kernel.org/patch/10934123/
> [3] https://patchwork.kernel.org/patch/11132381/
> [4] https://patchwork.kernel.org/patch/11093655/
> [5] https://patchwork.kernel.org/patch/11110493/

changes since v4:
- Add SVS dts node patch in SVS patch series.

> Roger Lu (3):
>   dt-bindings: soc: add mtk svs dt-bindings
>   arm64: dts: mt8183: add svs device information
>   PM / AVS: SVS: Introduce SVS engine
> 
>  .../devicetree/bindings/power/mtk-svs.txt     |   88 +
>  arch/arm64/boot/dts/mediatek/mt8183-evb.dts   |   16 +
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi      |   38 +
>  drivers/power/avs/Kconfig                     |   10 +
>  drivers/power/avs/Makefile                    |    1 +
>  drivers/power/avs/mtk_svs.c                   | 2075 +++++++++++++++++
>  include/linux/power/mtk_svs.h                 |   23 +
>  7 files changed, 2251 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/mtk-svs.txt
>  create mode 100644 drivers/power/avs/mtk_svs.c
>  create mode 100644 include/linux/power/mtk_svs.h



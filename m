Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92530C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69FF420850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfDKBFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 21:05:07 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:59177 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725782AbfDKBFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 21:05:06 -0400
X-UUID: 2fe1136a61104be0b6a3761b7a79c787-20190411
X-UUID: 2fe1136a61104be0b6a3761b7a79c787-20190411
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 977830350; Thu, 11 Apr 2019 09:05:02 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32DR.mediatek.inc
 (172.27.6.104) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 11 Apr
 2019 09:05:00 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 11 Apr 2019 09:04:59 +0800
Message-ID: <1554944699.10179.181.camel@mhfsdcap03>
Subject: Re: [v2 PATCH 4/4] phy: phy-meson-gxl-usb2: get optional clock by
 devm_clk_get_optional()
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Andy Gross" <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Motoya Tanigawa <tanigawa.motoya@socionext.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>
Date:   Thu, 11 Apr 2019 09:04:59 +0800
In-Reply-To: <CAFBinCBoQ6C7MrtwSctDgFPpXnaRVKm490piGOFmN2i2PV3GOQ@mail.gmail.com>
References: <a8539bcf66065380069676fbea99a51254309803.1554874961.git.chunfeng.yun@mediatek.com>
         <9f04a619e8a2cc44f5b1fe299a08f237f069d56d.1554874961.git.chunfeng.yun@mediatek.com>
         <CAFBinCBoQ6C7MrtwSctDgFPpXnaRVKm490piGOFmN2i2PV3GOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: 6CF08254F7B4AD4CBBAD478DAA7D9C5E9F0742FDD2D8A18FA0B5EF750B3D59842000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-04-10 at 19:59 +0200, Martin Blumenstingl wrote:
> On Wed, Apr 10, 2019 at 8:13 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
> >
> > Use devm_clk_get_optional() to get optional clock
> >
> > Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> now also:
> Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> (on my Khadas VIM by manually adjusting meson-gxl.dtsi and dropping
> the clocks in usb2_phy0 and usb2_phy1)

Thank you:)



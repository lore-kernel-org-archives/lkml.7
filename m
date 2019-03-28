Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670DAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 05:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DE7720700
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 05:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbfC1FSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 01:18:37 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:13758 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725765AbfC1FSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 01:18:37 -0400
X-UUID: e960acfd394541fe96aad7131fd252d5-20190328
X-UUID: e960acfd394541fe96aad7131fd252d5-20190328
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 62728532; Thu, 28 Mar 2019 13:18:27 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 28 Mar 2019 13:18:25 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 28 Mar 2019 13:18:20 +0800
Message-ID: <1553750300.20204.2.camel@mtksdaap41>
Subject: Re: [PATCH v5 0/9] Mediatek MT8183 clock support
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Stephen Boyd <sboyd@codeaurora.org>
CC:     Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, <stable@vger.kernel.org>
Date:   Thu, 28 Mar 2019 13:18:20 +0800
In-Reply-To: <20190305050546.23431-1-weiyi.lu@mediatek.com>
References: <20190305050546.23431-1-weiyi.lu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-05 at 13:05 +0800, Weiyi Lu wrote:

Hi Stephen,
Just gentle ping. Many thanks.

> Resend clock patches from v4 based on v5.0-rc1.
> 
> The whole series now is composed of
> a fix for PLL tuner (PATCH 1),
> clock common changes for both MT8183 & MT6765 (PATCH 2-3),
> clock support of MT8183 (PATCH 4-8) and
> resend a clock patch long time ago(PTACH 9).
> 
> changes since v4:
> - refine for the fix of PLL tuner(PATCH 1).
> - add configurable pcw_chg_reg for MT8183 and the following IC(PATCH 7).
> 
> changes sinve v3:
> - add fix tag.
> - small change of mtk_clk_mux data structure.
> - use of_property_for_each_string to iterate dependent subsys clock of power domain.
> - document critical clocks.
> - reduce some clock register error log.
> - few coding style fix.
> 
> changes sinve v2:
> - refine for implementation consistency of mtk clk mux.
> - separate the onoff API into enable/disable API for mtk scpsys.
> - resend a patch about PLL rate changing.
> 
> changes since v1:
> - refine for better code quality.
> - some minor bug fix of clock part, like incorrect control address
>   and missing clocks.
> 
> 



Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B5BC10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 570DC21726
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731278AbfDEOtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:49:39 -0400
Received: from ns.iliad.fr ([212.27.33.1]:35610 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbfDEOti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 10:49:38 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id E733C20C39;
        Fri,  5 Apr 2019 16:49:36 +0200 (CEST)
Received: from [192.168.108.8] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id CF674206B8;
        Fri,  5 Apr 2019 16:49:36 +0200 (CEST)
Subject: Re: [PATCH v3 0/9] RPMPD for QCS404 and MSM8998
To:     Sibi Sankar <sibis@codeaurora.org>
References: <20190327123832.11566-1-sibis@codeaurora.org>
Cc:     MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <c860ba37-31e7-be99-cbc1-040d3a844815@free.fr>
Date:   Fri, 5 Apr 2019 16:49:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190327123832.11566-1-sibis@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Fri Apr  5 16:49:37 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2019 13:38, Sibi Sankar wrote:

> Re-worked the macros of the rpmpd driver. Add power domains support
> for QCS404 and MSM8998.
> 
> V3:
> * always send level updates to vfc and vfl in set_performance state
> * fixup commit messages [Rajendra]
> * fixup s-o-b ordering
> 
> V2:
> * Add rpmpd support for msm8998
> * fixup corner/vfc with vlfl/vfl
> 
> Bjorn Andersson (4):
>   soc: qcom: rpmpd: Modify corner defining macros
>   dt-bindings: power: Add rpm power domain bindings for qcs404
>   soc: qcom: rpmpd: Add QCS404 power-domains
>   arm64: dts: qcom: qcs404: Add rpmpd node
> 
> Sibi Sankar (5):
>   soc: qcom: rpmpd: fixup rpmpd set performance state
>   soc: qcom: rpmpd: Add support to set rpmpd state to max
>   dt-bindings: power: Add rpm power domain bindings for msm8998
>   soc: qcom: rpmpd: Add MSM8998 power-domains
>   arm64: dts: qcom: msm8998: Add rpmpd node
> 
>  .../devicetree/bindings/power/qcom,rpmpd.txt  |   2 +
>  arch/arm64/boot/dts/qcom/msm8998.dtsi         |  51 +++++++
>  arch/arm64/boot/dts/qcom/qcs404.dtsi          |  55 +++++++
>  drivers/soc/qcom/rpmpd.c                      | 135 ++++++++++++++----
>  include/dt-bindings/power/qcom-rpmpd.h        |  34 +++++
>  5 files changed, 252 insertions(+), 25 deletions(-)

Hello Sibi,

Please note that you sent this series to linux-arm-msm-owner@vger.kernel.org
instead of linux-arm-msm@vger.kernel.org (the admin instead of the list).

This seems to be the case for other patches as well.

Regards.

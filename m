Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9CDC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FDBA208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbfDAQFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:05:36 -0400
Received: from ns.iliad.fr ([212.27.33.1]:35614 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726854AbfDAQFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:05:36 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id A790A21752;
        Mon,  1 Apr 2019 18:05:34 +0200 (CEST)
Received: from [192.168.108.8] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 8F30221751;
        Mon,  1 Apr 2019 18:05:34 +0200 (CEST)
Subject: Re: [PATCH v3 1/2] phy: qcom-qmp: Add msm8998 PCIe QMP PHY support
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     Kishon Vijay Abraham <kishon@ti.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <6acbdd28-b64a-0074-8d88-0e3930bacd7e@free.fr>
Message-ID: <7a5e29c3-f5f0-25a9-177e-a546fc0b9f2a@free.fr>
Date:   Mon, 1 Apr 2019 18:05:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <6acbdd28-b64a-0074-8d88-0e3930bacd7e@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Mon Apr  1 18:05:34 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2019 17:08, Marc Gonzalez wrote:

> Copy init sequence from downstream:
> https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/arch/arm/boot/dts/qcom/msm8998-v2.dtsi?h=LE.UM.1.3.r3.25#n372
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---
> Changes from v2: Toggle 2 (not 3) reset knobs
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 110 ++++++++++++++++++++++++++++
>  drivers/phy/qualcomm/phy-qcom-qmp.h |  12 +++
>  2 files changed, 122 insertions(+)

Hello Kishon,

Are there any more issues holding up this series?

Regards.

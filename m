Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F6DC49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E0D52081B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388170AbfIJOPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 10:15:44 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:48053 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730709AbfIJOPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 10:15:44 -0400
X-Originating-IP: 148.69.85.38
Received: from localhost (unknown [148.69.85.38])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 2B0A224000F;
        Tue, 10 Sep 2019 14:15:41 +0000 (UTC)
Date:   Tue, 10 Sep 2019 16:15:38 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: sc27xx: Remove clearing SPRD_RTC_POWEROFF_ALM_FLAG
 flag
Message-ID: <20190910141538.GT21254@piout.net>
References: <1f75310242de75b14d8973538bf96efffb395daf.1567666894.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f75310242de75b14d8973538bf96efffb395daf.1567666894.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2019 15:03:30+0800, Baolin Wang wrote:
> The SPRD_RTC_POWEROFF_ALM_FLAG flag is used to indicate if a poweroff alarm
> is set, which can power on the system when system in power-off status.
> 
> And the bootloader will validate this flag to check if the booting mode is
> alarm booting mode, thus we should not clear this flag in kernel, instead
> bootloader will clear this flag after checking the booting mode.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  drivers/rtc/rtc-sc27xx.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

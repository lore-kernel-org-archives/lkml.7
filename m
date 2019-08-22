Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A6AC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C7DB233FC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389427AbfHVVMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 17:12:20 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:56215 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729718AbfHVVMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:12:19 -0400
X-Originating-IP: 90.65.161.137
Received: from localhost (lfbn-1-1545-137.w90-65.abo.wanadoo.fr [90.65.161.137])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 0056B240004;
        Thu, 22 Aug 2019 21:12:16 +0000 (UTC)
Date:   Thu, 22 Aug 2019 23:12:16 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Biwen Li <biwen.li@nxp.com>
Cc:     a.zummo@towertech.it, leoyang.li@nxp.com, robh+dt@kernel.org,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiaobo.xie@nxp.com, jiafei.pan@nxp.com, ran.wang_1@nxp.com,
        mark.rutland@arm.com, devicetree@vger.kernel.org
Subject: Re: [v7,1/2] rtc/fsl: add FTM alarm driver as the wakeup source
Message-ID: <20190822211216.GC27031@piout.net>
References: <20190813030157.48590-1-biwen.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813030157.48590-1-biwen.li@nxp.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/08/2019 11:01:56+0800, Biwen Li wrote:
> For the paltforms including LS1012A, LS1021A, LS1028A, LS1043A,
> LS1046A, LS1088A, LS208xA that has the FlexTimer
> module, implementing alarm functions within RTC subsystem
> to wakeup the system when system going to sleep (work with RCPM driver).
> 
> Signed-off-by: Biwen Li <biwen.li@nxp.com>
> ---
> Change in v7:
>     - None
> 
> Change in v6:
>     - None
> 
> Change in v5:
>     - replace devm_rtc_device_register with devm_rtc_allocate_device
>     and rtc_register_device
> 
> Change in v4:
>     - clean code
>     - correct requesting irq
>     - register as a regular RTC driver
>     - change return value of ftm_rtc_set_alarm from -EINVAL to -ERANGE
>     - replace pr_err with dev_err
>     - sort alphabetically
>     - auto select RCPM driver
>     - correct UTC time in ftm_rtc_read_time
> 
> Change in v3:
> 	- add some comments about clock source and errata
> 	- adjust format
> 	- replace endian with big_endian of struct ftm_rtc
> 	- remove compatible "fsl,ftm-alarm"
> 
> Change in v2:
> 	- remove code about setting rcpm
> 
>  drivers/rtc/Kconfig             |  15 ++
>  drivers/rtc/Makefile            |   1 +
>  drivers/rtc/rtc-fsl-ftm-alarm.c | 336 ++++++++++++++++++++++++++++++++
>  3 files changed, 352 insertions(+)
>  create mode 100644 drivers/rtc/rtc-fsl-ftm-alarm.c
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

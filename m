Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7204AC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 06:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FED7215EA
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 06:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbfKIGeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 01:34:01 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:48280 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725861AbfKIGeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 01:34:01 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 93226CE3855530B242E5;
        Sat,  9 Nov 2019 14:33:59 +0800 (CST)
Received: from [127.0.0.1] (10.57.101.250) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Sat, 9 Nov 2019
 14:33:50 +0800
Subject: Re: [PATCH v3 0/5] hisi_lpc: Improve build test coverage
To:     John Garry <john.garry@huawei.com>, <xuwei5@huawei.com>
References: <1572888139-47298-1-git-send-email-john.garry@huawei.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <olof@lixom.net>, <bhelgaas@google.com>, <arnd@arndb.de>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5DC65DC1.9090305@hisilicon.com>
Date:   Sat, 9 Nov 2019 14:33:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <1572888139-47298-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.101.250]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 2019/11/5 1:22, John Garry wrote:
> This series aims to improve the build test cover of the driver by
> supporting building under COMPILE_TEST.
>
> I also included "lib: logic_pio: Enforce LOGIC_PIO_INDIRECT region ops
> are set at registration" as it was never picked up for 5.4.
>
> Two new patches are also included since v1:
> - clean issues detected by sparse
> - build logic_pio.o into /lib library
>
> Since v2 I limited test coverage for archs which don't define
> {read, write}sb().
>
> John Garry (5):
>    lib: logic_pio: Enforce LOGIC_PIO_INDIRECT region ops are set at
>      registration
>    logic_pio: Define PIO_INDIRECT_SIZE for !CONFIG_INDIRECT_PIO
>    bus: hisi_lpc: Clean some types
>    bus: hisi_lpc: Expand build test coverage
>    logic_pio: Build into a library
>
>   drivers/bus/Kconfig       |  5 +++--
>   drivers/bus/hisi_lpc.c    |  9 ++++-----
>   include/linux/logic_pio.h |  4 ++--
>   lib/Makefile              |  2 +-
>   lib/logic_pio.c           | 14 ++++++++------
>   5 files changed, 18 insertions(+), 16 deletions(-)
>

Thanks!
Dropped the v2 and applied v3 series to the hisilicon driver tree.

Best Regards,
Wei


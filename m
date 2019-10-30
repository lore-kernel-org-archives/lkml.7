Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AD1CA9EAF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 09:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D46205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 09:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfJ3JTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 05:19:13 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5651 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726028AbfJ3JTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 05:19:13 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BCB42F7E8EC2917545BA;
        Wed, 30 Oct 2019 17:19:08 +0800 (CST)
Received: from [127.0.0.1] (10.57.101.250) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Wed, 30 Oct 2019
 17:19:00 +0800
Subject: Re: [PATCH v2 0/5] hisi_lpc: Improve build test coverage
To:     John Garry <john.garry@huawei.com>, <xuwei5@huawei.com>
References: <1572264605-172363-1-git-send-email-john.garry@huawei.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <olof@lixom.net>, <bhelgaas@google.com>, <arnd@arndb.de>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5DB95584.3040907@hisilicon.com>
Date:   Wed, 30 Oct 2019 17:19:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <1572264605-172363-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.101.250]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/10/28 20:10, John Garry wrote:
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
> John Garry (5):
>    lib: logic_pio: Enforce LOGIC_PIO_INDIRECT region ops are set at
>      registration
>    logic_pio: Define PIO_INDIRECT_SIZE for !CONFIG_INDIRECT_PIO
>    bus: hisi_lpc: Clean some types
>    bus: hisi_lpc: Expand build test coverage
>    logic_pio: Build into a library
>
>   drivers/bus/Kconfig       |  4 ++--
>   drivers/bus/hisi_lpc.c    |  9 ++++-----
>   include/linux/logic_pio.h |  4 ++--
>   lib/Makefile              |  2 +-
>   lib/logic_pio.c           | 14 ++++++++------
>   5 files changed, 17 insertions(+), 16 deletions(-)
>

Thanks!
Series applied to the hisilicon driver tree.

Best Regards,
Wei


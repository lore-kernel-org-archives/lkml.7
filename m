Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF52C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 15:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA2920675
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 15:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbfD2PnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 11:43:02 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60930 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728438AbfD2PnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 11:43:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DD0580D;
        Mon, 29 Apr 2019 08:43:02 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BFB23F5C1;
        Mon, 29 Apr 2019 08:42:59 -0700 (PDT)
Subject: Re: [PATCH v6 00/13] Add support for usb on Hikey960
To:     Yu Chen <chenyu56@huawei.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     john.stultz@linaro.org, suzhuangluan@hisilicon.com,
        kongfei@hisilicon.com, liuyu712@hisilicon.com,
        wanghu17@hisilicon.com, butao@hisilicon.com, chenyao11@huawei.com,
        fangshengzhou@hisilicon.com, lipengcheng8@huawei.com,
        songxiaowei@hisilicon.com, xuyiping@hisilicon.com,
        xuyoujun4@huawei.com, yudongbin@hisilicon.com,
        zangleigang@hisilicon.com
References: <20190420064019.57522-1-chenyu56@huawei.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <766eb894-f939-02d2-5a3b-03fb51f7c4ee@arm.com>
Date:   Mon, 29 Apr 2019 16:42:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190420064019.57522-1-chenyu56@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20/04/2019 07:40, Yu Chen wrote:
> The patchset adds support for usb functionality of Hikey960, includes:
> - usb phy driver for Hisilicon Kirin Soc hi3660
> - usb driver for HiKey960 board
> - some adjustment in dwc3 and usb role driver
> - dts for support usb of HiKey960
> 

Still works fine on my Debian setup:

Tested-by: Valentin Schneider <valentin.schneider@arm.com>

Thanks,
Valentin

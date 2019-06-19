Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2490C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 16:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE51217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 16:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbfFSQOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 12:14:07 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33027 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725838AbfFSQOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 12:14:06 -0400
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 095893D40BFF13CBD759;
        Wed, 19 Jun 2019 17:14:04 +0100 (IST)
Received: from [127.0.0.1] (10.202.227.157) by lhreml702-cah.china.huawei.com
 (10.201.108.43) with Microsoft SMTP Server id 14.3.408.0; Wed, 19 Jun 2019
 17:13:53 +0100
Subject: Re: [PATCH v4] arm64: dts: hi3660: Add CoreSight support
To:     Leo Yan <leo.yan@linaro.org>,
        Wanglai Shi <shiwanglai@hisilicon.com>
CC:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <mike.leach@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <suzhuangluan@hisilicon.com>, John Stultz <john.stultz@linaro.org>
References: <1555768835-68555-1-git-send-email-shiwanglai@hisilicon.com>
 <20190516041140.GC12557@leoy-ThinkPad-X240s>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <be5ea435-2484-18c3-2282-426c688d33aa@hisilicon.com>
Date:   Wed, 19 Jun 2019 17:13:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190516041140.GC12557@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.157]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo, Wanglai

On 5/16/2019 5:11 AM, Leo Yan wrote:
> On Sat, Apr 20, 2019 at 10:00:35PM +0800, Wanglai Shi wrote:
>> This patch adds DT bindings for the CoreSight trace components
>> on hi3660, which is used by 96boards Hikey960.
>>
>> Signed-off-by: Wanglai Shi <shiwanglai@hisilicon.com>
> 
> Hi Wei,
> 
> Mathieu and me both have reviewed this patch, could you pick up this
> patch?  Thanks a lot!

Applied to the hisilicon dt tree.
Thanks!

Best Regards,
Wei


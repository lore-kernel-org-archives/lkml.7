Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95ED3C46477
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 16:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76A2D2177B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 16:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbfFSQ2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 12:28:13 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33028 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726251AbfFSQ2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 12:28:12 -0400
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 980B6A667165A875910C;
        Wed, 19 Jun 2019 17:28:08 +0100 (IST)
Received: from [127.0.0.1] (10.202.227.157) by LHREML710-CAH.china.huawei.com
 (10.201.108.33) with Microsoft SMTP Server id 14.3.408.0; Wed, 19 Jun 2019
 17:27:58 +0100
Subject: Re: [PATCH] arm64: dts: hisilicon: Switch to SPDX header
To:     Lubomir Rintel <lkundrak@v3.sk>
CC:     Pengcheng Li <lipengcheng8@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190611072009.2978447-1-lkundrak@v3.sk>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <52f3ed62-79c0-2730-03c6-f480b0558af2@hisilicon.com>
Date:   Wed, 19 Jun 2019 17:27:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190611072009.2978447-1-lkundrak@v3.sk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.157]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lubomir,

On 6/11/2019 8:20 AM, Lubomir Rintel wrote:
> The original license text had a typo ("publishhed") which would be
> likely to confuse automated licensing auditing tools. Let's just switch
> to SPDX instead of fixing the wording.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Thanks!
I found linux-next has already fix this.

Best Regards,
Wei


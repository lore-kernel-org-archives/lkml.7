Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DAFC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E46218FD
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732309AbfDJNKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:10:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6719 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729441AbfDJNKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 09:10:50 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A15CDCF8180C2EA6CFF3;
        Wed, 10 Apr 2019 21:10:45 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Wed, 10 Apr 2019
 21:10:42 +0800
Subject: Re: [LINUX PATCH v3] spi: spi-mem: Fix build error without
 CONFIG_SPI_MEM
To:     Mark Brown <broonie@kernel.org>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>
References: <1554897429-5959-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <2d9cee19-a776-ad18-b8ac-6d0d1b096ad6@huawei.com>
 <20190410122457.GP6106@sirena.org.uk>
 <MWHPR02MB262352F3C89EB163AB1EC2B5AF2E0@MWHPR02MB2623.namprd02.prod.outlook.com>
 <20190410123558.GQ6106@sirena.org.uk>
CC:     "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "nagasuresh12@gmail.com" <nagasuresh12@gmail.com>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <8316c6e9-9000-bd1e-aa96-3db069e61824@huawei.com>
Date:   Wed, 10 Apr 2019 21:10:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190410123558.GQ6106@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/4/10 20:35, Mark Brown wrote:
> On Wed, Apr 10, 2019 at 12:30:37PM +0000, Naga Sureshkumar Relli wrote:
> 
>>> Yeah, I'm surprised that builds...
> 
>> Sorry, I tested with CONFIG_SPI_MEM enabled. It's my bad.
> 
> I also see that I'd queued an earlier version for application.  I've
> lost track of whatever issues there were with that, sorry - could one of
> you please post an incremental patch for them?  IIRC they were nice to
> haves and the patch that was applied fixes the correctness issue.

Ok, there just make the stub helper to  static inline

I can post a new patch based my initial patch.

> 


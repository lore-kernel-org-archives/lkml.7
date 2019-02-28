Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65071C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 01:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB9620842
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 01:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730589AbfB1BIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 20:08:30 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:41974 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730139AbfB1BIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 20:08:30 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 44DED6987C41DA553685;
        Thu, 28 Feb 2019 09:08:28 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Thu, 28 Feb 2019
 09:08:25 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't clear CP_QUOTA_NEED_FSCK_FLAG
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20190212023343.52215-1-jaegeuk@kernel.org>
 <df77f830-e5dd-5943-d5b0-e21ced3a7df2@huawei.com>
 <20190216045530.GA57019@jaegeuk-macbookpro.roam.corp.google.com>
 <29a4fd24-6340-41df-7199-6e89b70c6341@huawei.com>
 <20190220070855.GA91331@jaegeuk-macbookpro.roam.corp.google.com>
 <c39a995f-9bfd-e68a-7d04-11bd8c0f8e64@huawei.com>
 <7580aa2e-b2eb-a686-a19d-4e82a713944a@huawei.com>
 <20190222024058.GA6093@jaegeuk-macbookpro.roam.corp.google.com>
 <0e00fefb-d0af-6143-afcd-6d8c8fa34743@huawei.com>
 <20190226175725.GB59048@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <f5b5832f-293c-a794-f55f-0a5e46031d07@huawei.com>
Date:   Thu, 28 Feb 2019 09:08:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190226175725.GB59048@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/2/27 1:57, Jaegeuk Kim wrote:
>        /*
>         * TODO: we count on fsck.f2fs to clear this flag until we figure out
>         * missing cases which clear it incorrectly.
>         */
> 
> I added like this.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> 
> Thanks,


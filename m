Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2507BC4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 01:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE60F206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 01:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbfIPBPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 21:15:50 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2223 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728927AbfIPBPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 21:15:49 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B9426788CD4FFC694493;
        Mon, 16 Sep 2019 09:15:47 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 16 Sep
 2019 09:15:45 +0800
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: avoid infinite GC loop due to stale
 atomic files
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20190909080108.GC21625@jaegeuk-macbookpro.roam.corp.google.com>
 <bf0683d9-ac05-1edc-71ea-3d02f7b2fb55@huawei.com>
 <20190909082112.GA25724@jaegeuk-macbookpro.roam.corp.google.com>
 <2f5b844c-f722-6a80-a4ab-61bdd72b8be4@huawei.com>
 <20190909083844.GC25724@jaegeuk-macbookpro.roam.corp.google.com>
 <83759349-644a-b3a0-787d-e463b0565885@huawei.com>
 <20190909143419.GB31108@jaegeuk-macbookpro.roam.corp.google.com>
 <c48f8992-eaef-9b2e-56a3-f6a922daa4af@huawei.com>
 <20190910115850.GA98080@jaegeuk-macbookpro.roam.corp.google.com>
 <2fd8940b-9ebd-d143-5ce6-c056750c596f@huawei.com>
 <20190910120913.GB98080@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <1ba048b4-7dac-1c98-837d-0f0456ccc560@huawei.com>
Date:   Mon, 16 Sep 2019 09:15:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190910120913.GB98080@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/9/10 20:09, Jaegeuk Kim wrote:
>> The lock is used to protect F2FS_I(inode)->inmem_pages list... it should be kept?
> Urg.. yup. I added.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> 

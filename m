Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2051C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8658E206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbfGaMHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:07:16 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53192 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726689AbfGaMHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:07:16 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7ED71FC8A3E7D1975919;
        Wed, 31 Jul 2019 20:07:12 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 31 Jul
 2019 20:07:03 +0800
Subject: Re: [PATCH 07/22] staging: erofs: remove redundant #include
 "internal.h"
To:     Gao Xiang <gaoxiang25@huawei.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-erofs@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>, <weidu.du@huawei.com>,
        Miao Xie <miaoxie@huawei.com>
References: <20190729065159.62378-1-gaoxiang25@huawei.com>
 <20190729065159.62378-8-gaoxiang25@huawei.com>
 <bae5fc5b-b2e1-0d74-6374-b1ae5835cbb9@huawei.com>
 <52072867-a9ae-5730-0ce4-47dd8dcb2d8c@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <b261d2bf-bdc0-a418-1cac-dc142c7dc467@huawei.com>
Date:   Wed, 31 Jul 2019 20:07:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <52072867-a9ae-5730-0ce4-47dd8dcb2d8c@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiang,

On 2019/7/31 15:08, Gao Xiang wrote:
> Hi Chao,
> 
> On 2019/7/31 15:03, Chao Yu wrote:
>> On 2019/7/29 14:51, Gao Xiang wrote:
>>> Because #include "internal.h" is included in xattr.h
>>
>> I think it would be better to remove "internal.h" in xattr.h, and include them
>> both in .c file in where we need xattr definition.
> 
> It seems that all xattr related source files needing internal.h,
> and we need "EROFS_V(inode)", "struct erofs_sb_info", ... stuffs in xattr.h,
> which is defined in internal.h...

Since I checked f2fs', it looks it's okay to don't include internal.h for
xattr.h, if .c needs xattr.h, we can just include interanl.h and xattr.h in the
head of it, it's safe.

Thanks,

> 
> Thanks,
> Gao Xiang
> 
>>
>> Thanks,
>>
> .
> 

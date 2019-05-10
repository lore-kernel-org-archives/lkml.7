Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B9EC04AB1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 01:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF26E2175B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 01:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfEJBOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 21:14:37 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:49818 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726765AbfEJBOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 21:14:37 -0400
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 9FD1A7C416A3151C2A41;
        Fri, 10 May 2019 09:14:34 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 10 May 2019 09:14:34 +0800
Received: from [10.134.22.195] (10.134.22.195) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 10 May 2019 09:14:33 +0800
Subject: Re: [PATCH v5] f2fs: fix to avoid accessing xattr across the boundary
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     Randall Huang <huangrandall@google.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20190411082646.169977-1-huangrandall@google.com>
 <20190509041535.GA62877@jaegeuk-macbookpro.roam.corp.google.com>
 <bdba5d01-4a31-d8f2-4805-81d167047c84@huawei.com>
 <20190509164814.GA79912@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <57a8cf36-af86-8d4b-856d-e7d70cf2d098@huawei.com>
Date:   Fri, 10 May 2019 09:14:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190509164814.GA79912@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-ClientProxiedBy: dggeme764-chm.china.huawei.com (10.3.19.110) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/5/10 0:48, Jaegeuk Kim wrote:
> Okay, how about this?
> 
>>From 2777e654371dd4207a3a7f4fb5fa39550053a080 Mon Sep 17 00:00:00 2001
> From: Randall Huang <huangrandall@google.com>
> Date: Thu, 11 Apr 2019 16:26:46 +0800
> Subject: [PATCH] f2fs: fix to avoid accessing xattr across the boundary

Looks good to me, and more clean. :)

Thanks,

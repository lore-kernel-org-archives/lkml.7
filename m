Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C081CA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 02:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BFF920856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 02:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfJ3CeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 22:34:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5646 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726037AbfJ3CeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 22:34:01 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 72FD0B1E863A346FBC17;
        Wed, 30 Oct 2019 10:33:56 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 30 Oct
 2019 10:33:48 +0800
Subject: Re: [PATCH v5] erofs: support superblock checksum
To:     Gao Xiang <gaoxiang25@huawei.com>,
        Pratik Shinde <pratikshinde320@gmail.com>,
        <linux-erofs@lists.ozlabs.org>
CC:     Gao Xiang <xiang@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20191028134405.GA186556@architecture4>
 <20191028143202.133428-1-gaoxiang25@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <d604526a-70dd-0a44-f001-33c84be99084@huawei.com>
Date:   Wed, 30 Oct 2019 10:33:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191028143202.133428-1-gaoxiang25@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/28 22:32, Gao Xiang wrote:
> From: Pratik Shinde <pratikshinde320@gmail.com>
> 
> Introduce superblock checksum feature in order to verify
> a number of given blocks at mounting time.
> 
> Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

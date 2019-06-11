Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6185C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 01:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC74D20652
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 01:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390674AbfFKBjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 21:39:40 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59248 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389168AbfFKBjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 21:39:40 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CF0A0C220EA37034A070;
        Tue, 11 Jun 2019 09:39:37 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 11 Jun
 2019 09:39:31 +0800
Subject: Re: [PATCH 2/2] staging: erofs: rename data_mapping_mode to datamode
To:     Gao Xiang <gaoxiang25@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
References: <20190610093640.96705-1-gaoxiang25@huawei.com>
 <20190610093640.96705-2-gaoxiang25@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <15407b2f-3224-0a88-004a-06a9eca67fdb@huawei.com>
Date:   Tue, 11 Jun 2019 09:39:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190610093640.96705-2-gaoxiang25@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/6/10 17:36, Gao Xiang wrote:
> data_mapping_mode is too long as a member name of erofs_vnode,
> datamode is straight-forward enough.
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

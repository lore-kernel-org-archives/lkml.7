Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D708AC2D0C3
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 03:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B08F5208C4
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 03:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfL1DJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 22:09:43 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:39642 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725860AbfL1DJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 22:09:42 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9DF1A5AB8160570B801F;
        Sat, 28 Dec 2019 11:09:40 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.439.0; Sat, 28 Dec
 2019 11:09:38 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: cover f2fs_lock_op in expand_inode_data
 case
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20191218195324.17360-1-jaegeuk@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <74e8531a-942d-4735-ed3b-128be6f733cb@huawei.com>
Date:   Sat, 28 Dec 2019 11:09:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191218195324.17360-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/12/19 3:53, Jaegeuk Kim wrote:
> We were missing to cover f2fs_lock_op in this case.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

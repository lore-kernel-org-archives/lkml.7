Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4132C48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 06:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF11A20665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 06:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbfGHGbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 02:31:03 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2236 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727420AbfGHGbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 02:31:02 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6AFEBC7DA0216E3C015F;
        Mon,  8 Jul 2019 14:30:58 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 8 Jul 2019
 14:30:55 +0800
Subject: Re: [PATCH v4] f2fs: avoid out-of-range memory access
To:     Ocean Chen <oceanchen@google.com>, <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20190708043456.24935-1-oceanchen@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <ebf31e70-b87b-ea26-c3e9-99775cea69af@huawei.com>
Date:   Mon, 8 Jul 2019 14:30:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190708043456.24935-1-oceanchen@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/7/8 12:34, Ocean Chen wrote:
> blkoff_off might over 512 due to fs corrupt or security
> vulnerability. That should be checked before being using.
> 
> Use ENTRIES_IN_SUM to protect invalid value in cur_data_blkoff.
> 
> Signed-off-by: Ocean Chen <oceanchen@google.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

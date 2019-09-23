Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F05FC3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 06:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 386DD21907
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 06:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393007AbfIWGtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 02:49:36 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45148 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729913AbfIWGtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 02:49:36 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1CB4DF3B17BFAFAFF9E5;
        Mon, 23 Sep 2019 14:49:34 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 23 Sep
 2019 14:49:25 +0800
Subject: Re: [PATCH v2 1/1] f2fs: update multi-dev metadata in resize_fs
To:     sunqiuyang <sunqiuyang@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <jaegeuk@kernel.org>
References: <20190923042139.36470-1-sunqiuyang@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <3f9b09b7-43fc-c4af-ab20-b7589d3fb347@huawei.com>
Date:   Mon, 23 Sep 2019 14:49:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190923042139.36470-1-sunqiuyang@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/9/23 12:21, sunqiuyang wrote:
> From: Qiuyang Sun <sunqiuyang@huawei.com>
> 
> Multi-device metadata should be updated in resize_fs as well.
> 
> Also, we check that the new FS size still reaches the last device.
> 
> --
> Changelog v1 => v2:
> Use f2fs_is_multi_device() and some minor cleanup.
> 
> Signed-off-by: Qiuyang Sun <sunqiuyang@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB0FCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 09:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F5322166E
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 09:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438442AbfJXJ0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 05:26:51 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47368 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2438325AbfJXJ0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 05:26:49 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 807416339BB4C677DB81;
        Thu, 24 Oct 2019 17:26:47 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 24 Oct
 2019 17:26:42 +0800
Subject: Re: [PATCH 2/2] f2fs: Add f2fs stats to sysfs
To:     Hridya Valsaraju <hridya@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
CC:     <kernel-team@android.com>
References: <20191023214821.107615-1-hridya@google.com>
 <20191023214821.107615-2-hridya@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <e61510b8-c8d7-349f-b297-9df367c26a9f@huawei.com>
Date:   Thu, 24 Oct 2019 17:26:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191023214821.107615-2-hridya@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/24 5:48, Hridya Valsaraju wrote:
> Currently f2fs stats are only available from /d/f2fs/status. This patch
> adds some of the f2fs stats to sysfs so that they are accessible even
> when debugfs is not mounted.

Why don't we mount debugfs first?

Thanks,

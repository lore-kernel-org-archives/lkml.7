Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36698C010CF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 118B321D71
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388803AbfKEMim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 07:38:42 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:52628 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388494AbfKEMil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 07:38:41 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 647CA64E02946AEBC6F4;
        Tue,  5 Nov 2019 20:38:37 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 5 Nov 2019
 20:38:35 +0800
Subject: Re: [PATCH 0/2] f2fs-tools: Introduce cache to speed up fsck
To:     Robin Hsu <robinhsu@google.com>, <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
CC:     <huangrandall@google.com>
References: <20191029074659.165884-1-robinhsu@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <4241b45c-1af4-5196-649d-c0132e64cb20@huawei.com>
Date:   Tue, 5 Nov 2019 20:38:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191029074659.165884-1-robinhsu@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

Could you explain what is the basic idea for this user-space cache?

Thanks,

On 2019/10/29 15:46, Robin Hsu wrote:
> Implemented cache and related command line options.
> 
> Robin Hsu (2):
>   libf2fs_io: Add user-space cache
>   fsck.f2fs: Enable user-space cache
> 
>  fsck/main.c       |  27 +++-
>  include/f2fs_fs.h |  20 +++
>  lib/libf2fs_io.c  | 317 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 362 insertions(+), 2 deletions(-)
> 

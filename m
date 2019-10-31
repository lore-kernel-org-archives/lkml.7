Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7C2CA9EC7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 02:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46D8020856
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 02:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfJaCQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 22:16:41 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55134 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726184AbfJaCQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 22:16:41 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A746713D84877026D930;
        Thu, 31 Oct 2019 10:16:37 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 31 Oct
 2019 10:16:32 +0800
Subject: Re: [PATCH 2/2] f2fs: support data compression
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20191022171602.93637-1-jaegeuk@kernel.org>
 <20191022171602.93637-2-jaegeuk@kernel.org>
 <20191027225006.GA321938@sol.localdomain>
 <da214cdc-0074-b7bf-7761-d4c4ad3d4f6a@huawei.com>
 <20191030025512.GA4791@sol.localdomain>
 <97c33fa1-15af-b319-29a1-22f254a26c0a@huawei.com>
 <20191030165056.GA693@sol.localdomain>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <a2586ef0-9f0d-d2e1-ecf0-e6e946c20a7a@huawei.com>
Date:   Thu, 31 Oct 2019 10:16:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191030165056.GA693@sol.localdomain>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/31 0:50, Eric Biggers wrote:
> No, just use kvmalloc().  The whole point of kvmalloc() is that it tries
> kmalloc() and then falls back to vmalloc() if it fails.

Okay, it's fine to me, let me fix this in another patch.

Thanks,

> 
> - Eric
> .
> 

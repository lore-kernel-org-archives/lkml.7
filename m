Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA41BC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 01:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB0E2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 01:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfHLBt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 21:49:57 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4656 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726200AbfHLBt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 21:49:57 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 60388B41B8A7E0293E9B;
        Mon, 12 Aug 2019 09:49:52 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 12 Aug
 2019 09:49:48 +0800
Subject: Re: [PATCH] mailmap: add entry for Jaegeuk Kim
To:     Jonathan Corbet <corbet@lwn.net>, Chao Yu <chao@kernel.org>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jaegeuk@kernel.org>
References: <20190802012135.31419-1-yuchao0@huawei.com>
 <20190802072626.405246e3@lwn.net>
 <fe9cd2bc-76ed-5371-e0c3-b538e7a805e7@kernel.org>
 <fd14e8d4-7468-ed3a-a679-6167eac72626@kernel.org>
 <20190809102816.52b3b310@lwn.net>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <be87504b-d0e2-3219-82da-568bf9b02cc3@huawei.com>
Date:   Mon, 12 Aug 2019 09:49:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190809102816.52b3b310@lwn.net>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/8/10 0:28, Jonathan Corbet wrote:
> On Thu, 8 Aug 2019 22:37:41 +0800
> Chao Yu <chao@kernel.org> wrote:
> 
>>> IMO, when we use git-blame to find out who is response for specified code, w/o
>>> mailmap we may just found old obsolete email address in the related commit; even
>>> we can search full name for his/her new email address, how can we make sure they
>>> are the same person... so anyway, it can help to find last valid/canonical email
>>> address of someone.  
>>
>> Any thoughts?
> 
> I'm not fully convinced that we want to maintain a database of every
> developer's email history.  But I did merge this patch a few days ago.

Thanks for the merging anyway. :)

> 
> Thanks,
> 
> jon
> .
> 

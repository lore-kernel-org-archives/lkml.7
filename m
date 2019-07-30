Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005D7C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 07:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D129C2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 07:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbfG3H04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 03:26:56 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3246 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726432AbfG3H04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 03:26:56 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 977212EF994AA4D160AD;
        Tue, 30 Jul 2019 15:26:51 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 30 Jul
 2019 15:26:42 +0800
Subject: Re: [PATCH 01/22] staging: erofs: update source file headers
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <devel@driverdev.osuosl.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        <weidu.du@huawei.com>, Fang Wei <fangwei1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>
References: <20190729065159.62378-1-gaoxiang25@huawei.com>
 <20190729065159.62378-2-gaoxiang25@huawei.com>
 <20190730072003.GA31548@kroah.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <17ef206b-cb90-b04a-d4e0-978786741238@huawei.com>
Date:   Tue, 30 Jul 2019 15:26:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190730072003.GA31548@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 2019/7/30 15:20, Greg Kroah-Hartman wrote:
> On Mon, Jul 29, 2019 at 02:51:38PM +0800, Gao Xiang wrote:
>> - Use the correct style for all SPDX License Identifiers;
>> - Get rid of the unnecessary license boilerplate;
>> - Use "GPL-2.0-only" instead of "GPL-2.0" suggested-by Stephen.
> 
> Note, either tag works just fine, they are identical.  I'll take this,
> but just be aware of this in the future please.

Okay, got it. I will keep track of potential GPL3.0+ stuffes
if community has such license discussions again.

It seems fine for now. :)

Thanks,
Gao Xiang

> 
> thanks,
> 
> greg k-h
> 

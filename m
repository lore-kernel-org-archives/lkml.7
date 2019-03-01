Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10DEC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 02:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 732B020850
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 02:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731931AbfCACj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 21:39:29 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:4749 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725896AbfCACj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 21:39:29 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 60046C166F44B639C8E0;
        Fri,  1 Mar 2019 10:39:26 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Fri, 1 Mar 2019
 10:39:21 +0800
Subject: Re: [PATCH 0/2] appletalk: A cleanup and bugfix
To:     David Miller <davem@davemloft.net>
References: <20190228135627.30408-1-yuehaibing@huawei.com>
 <20190228.124451.823828224339998259.davem@davemloft.net>
CC:     <joe@perches.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <b6fd1047-7b7b-ac25-a60d-9e37eaef1099@huawei.com>
Date:   Fri, 1 Mar 2019 10:39:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190228.124451.823828224339998259.davem@davemloft.net>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/3/1 4:44, David Miller wrote:
> 
> This series mixes cleanups with a bug fix.
> 
> The cleanup is only appropriate for net-next, and the bug fix is
> appropriate for net.

patch 2 is based on patch 1 now, atalk_proc_exit context is changed,
if they go separately, a small conflict will occur while merging

> Also, your header posting here was empty.  It must actually
> say something.
> 
> Specifically it must always say what the patch series is doing,
> why it is doing it, and why it is doing it that way.
> 

Got it, Thanks!

> Thanks.
> 
> .
> 


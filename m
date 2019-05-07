Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AF9C04A6B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 03:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C8620B7C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 03:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfEGD0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 23:26:10 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37612 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726866AbfEGD0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 23:26:09 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9B0F33BA8E3B6B52E5A6;
        Tue,  7 May 2019 11:26:07 +0800 (CST)
Received: from [127.0.0.1] (10.184.225.177) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Tue, 7 May 2019
 11:25:58 +0800
Subject: Re: [PATCH v2] mm/hugetlb: Don't put_page in lock of hugetlb_lock
To:     Michal Hocko <mhocko@kernel.org>
CC:     <mike.kravetz@oracle.com>, <shenkai8@huawei.com>,
        <linfeilong@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <wangwang2@huawei.com>,
        "Zhoukang (A)" <zhoukang7@huawei.com>,
        Mingfangsen <mingfangsen@huawei.com>, <agl@us.ibm.com>,
        <nacc@us.ibm.com>, Andrew Morton <akpm@linux-foundation.org>
References: <12a693da-19c8-dd2c-ea6a-0a5dc9d2db27@huawei.com>
 <b8ade452-2d6b-0372-32c2-703644032b47@huawei.com>
 <20190506142001.GC31017@dhcp22.suse.cz>
 <d11fa51f-e976-ec33-4f5b-3b26ada64306@huawei.com>
 <20190506190731.GE31017@dhcp22.suse.cz>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <32a63fc6-add1-5556-8174-517d41aa8a2a@huawei.com>
Date:   Tue, 7 May 2019 11:25:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190506190731.GE31017@dhcp22.suse.cz>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.225.177]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon 06-05-19 23:22:08, Zhiqiang Liu wrote:
> [...]
>> Does adding Cc: stable mean adding Cc: <stable@vger.kernel.org>
>> tag in the patch or Ccing stable@vger.kernel.org when sending the new mail?
> 
> The former. See Documentation/process/stable-kernel-rules.rst for more.
> 
> Thanks!

Thank you, Oscar Salvador and Mike Kravetz again.
> 


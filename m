Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5298CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27CB92147A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfCKNdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:33:20 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4670 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727552AbfCKNdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:33:19 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9FE40A695522DF555D55;
        Mon, 11 Mar 2019 21:33:12 +0800 (CST)
Received: from [127.0.0.1] (10.184.38.59) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Mon, 11 Mar 2019
 21:33:06 +0800
Subject: Re: [RFC PATCH] perf: Paper over the hw.target problems
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
CC:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <jolsa@redhat.com>, <dvyukov@google.com>, <namhyung@kernel.org>,
        <syzbot+a24c397a29ad22d86c98@syzkaller.appspotmail.com>,
        "chengjian (D)" <cj.chengjian@huawei.com>,
        Li Bin <huawei.libin@huawei.com>
References: <278ac311-d8f3-2832-5fa1-522471c8c31c@huawei.com>
 <20190228140109.64238-1-alexander.shishkin@linux.intel.com>
 <c174549c-d169-7773-2f47-5863ba0b8056@huawei.com>
 <87zhq5a6ck.fsf@ashishki-desk.ger.corp.intel.com>
From:   "chengjian (D)" <cj.chengjian@huawei.com>
Message-ID: <cf3f524e-cb3c-03d0-cfbd-c2d0efca9618@huawei.com>
Date:   Mon, 11 Mar 2019 21:32:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <87zhq5a6ck.fsf@ashishki-desk.ger.corp.intel.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.184.38.59]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,


I have tested the new version, and put it in

the syzkaller workspace, it works well now.

Tested-by: Cheng Jian <cj.chengjian@huawei.com>


> Thanks a lot for taking the time and providing all the details. Please
> find an updated version below, which should not exhibit that warning.


Thanks.



Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEA2CA9EC7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 01:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19AC220856
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 01:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfJaBgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 21:36:51 -0400
Received: from foss.arm.com ([217.140.110.172]:43660 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbfJaBgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 21:36:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8B531FB;
        Wed, 30 Oct 2019 18:36:50 -0700 (PDT)
Received: from [10.188.222.161] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 645D03F719;
        Wed, 30 Oct 2019 18:36:48 -0700 (PDT)
Subject: Re: [QUESTION] Hung task warning while running syzkaller test
To:     Zhihao Cheng <chengzhihao1@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, peterz@infradead.org,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        patrick.bellasi@arm.com, tglx@linutronix.de
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>
References: <0d7aa66d-d2b9-775c-56b3-543d132fdb84@huawei.com>
 <1693d19e-56c7-9d6f-8e80-10fe82101cff@arm.com>
 <aa5d0f35-e707-f5e3-251e-f940c0b0232b@huawei.com>
 <4ca01869-7997-cfce-edce-e75337d3a6fa@arm.com>
 <abba880d-cfa6-3485-7831-9998db290396@huawei.com>
 <d7e9f62e-d7a6-50ec-6fb5-76ad136506df@arm.com>
 <4453942d-c4f2-bbbe-64a9-4313c0fccfbf@huawei.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <6d78bdbc-e4f8-7ff7-8445-c9dc07b0614a@arm.com>
Date:   Thu, 31 Oct 2019 02:36:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <4453942d-c4f2-bbbe-64a9-4313c0fccfbf@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/10/2019 03:25, Zhihao Cheng wrote:
> I don't know much about the freezer mechanism of CGroup, but I tried it. I turned off all the CGroup related config options and reproduced the hung task on a fresh busybox-made root file system. I added rootfs in attachment. So, I guess hung task has nothing to do with CGroup(freezer).
> 

That's good to know, thanks for digging some more. I'm on the move ATM but if
I find some time I'll try to stare some more at the C reproducer.


Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B80C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B0CF21920
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfJBPhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 11:37:25 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36938 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725799AbfJBPhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 11:37:24 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6549D336E9101D376BFE;
        Wed,  2 Oct 2019 23:37:13 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.179) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Wed, 2 Oct 2019
 23:37:07 +0800
From:   John Garry <john.garry@huawei.com>
Subject: perf tool pmuevents: About arm64 a76 JSON
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        <seanvk.dev@oregontracks.org>,
        Florian Fainelli <f.fainelli@gmail.com>, <wcohen@redhat.com>,
        Ganapatrao Kulkarni <gklkml16@gmail.com>,
        Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To:     <James.Clark@arm.com>
Message-ID: <749a0b8e-2bfd-28f6-b34d-dc72ef3d3a74@huawei.com>
Date:   Wed, 2 Oct 2019 16:37:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I noticed that the JSON to support a76 pmu events was added recently.

May I ask why we add explicit support for the common architectural and 
microarch events (event id 0x0-0x3f), when they would be already 
available from the kernel pmuv3 driver?

The ampere emag jsons do similar. Others don't.

The only advantage I see is that we have an event description, but I am 
sure how useful that is.

Cheers,
John


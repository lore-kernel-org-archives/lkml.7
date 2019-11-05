Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAF9C49EAA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 09:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E5120869
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 09:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730761AbfKEJKi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 04:10:38 -0500
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:40959 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729171AbfKEJKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 04:10:38 -0500
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id xA59ALpw009604
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 5 Nov 2019 18:10:21 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id xA59ALr6007501;
        Tue, 5 Nov 2019 18:10:21 +0900
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id xA59AL0p027424;
        Tue, 5 Nov 2019 18:10:21 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.148] [10.38.151.148]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-10078506; Tue, 5 Nov 2019 18:09:45 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC20GP.gisp.nec.co.jp ([10.38.151.148]) with mapi id 14.03.0439.000; Tue, 5
 Nov 2019 18:09:44 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Yunfeng Ye <yeyunfeng@huawei.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hushiyuan@huawei.com" <hushiyuan@huawei.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
Subject: Re: [PATCH] mm/memory-failure.c: replace with page_shift() in
 add_to_kill()
Thread-Topic: [PATCH] mm/memory-failure.c: replace with page_shift() in
 add_to_kill()
Thread-Index: AQHVk7IjOfxiniM4JEmew4TP7s3IhKd7s0IA
Date:   Tue, 5 Nov 2019 09:09:44 +0000
Message-ID: <20191105090944.GA29554@hori.linux.bs1.fc.nec.co.jp>
References: <7bc9d610-728c-37b0-d175-dba21dc0dfff@huawei.com>
In-Reply-To: <7bc9d610-728c-37b0-d175-dba21dc0dfff@huawei.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.150]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <587BFB72EE2C8B4A9C1842BF814BA0B9@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 04:21:44PM +0800, Yunfeng Ye wrote:
> The function page_shift() is supported after the commit 94ad9338109f
> ("mm: introduce page_shift()").
> 
> So replace with page_shift() in add_to_kill() for readability.
> 
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>

Acked-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

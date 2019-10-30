Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCF2CA9EAF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 04:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DEA22087E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 04:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfJ3EMK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 00:12:10 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:37847 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbfJ3EMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 00:12:10 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x9U4BqPa008142
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 30 Oct 2019 13:11:53 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9U4Bqd3006121;
        Wed, 30 Oct 2019 13:11:52 +0900
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9U4BKYG017468;
        Wed, 30 Oct 2019 13:11:52 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.147] [10.38.151.147]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-9922790; Wed, 30 Oct 2019 13:09:51 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC19GP.gisp.nec.co.jp ([10.38.151.147]) with mapi id 14.03.0439.000; Wed,
 30 Oct 2019 13:09:50 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     zhong jiang <zhongjiang@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/hwpoison-inject: use DEFINE_DEBUGFS_ATTRIBUTE to
 define debugfs fops
Thread-Topic: [PATCH] mm/hwpoison-inject: use DEFINE_DEBUGFS_ATTRIBUTE to
 define debugfs fops
Thread-Index: AQHVjsz1YA+sBax7wkG5AkzDkMZe9adx+0SA
Date:   Wed, 30 Oct 2019 04:09:49 +0000
Message-ID: <20191030040949.GA11590@hori.linux.bs1.fc.nec.co.jp>
References: <1572403660-44718-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1572403660-44718-1-git-send-email-zhongjiang@huawei.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.96]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <1231EE03B9A77B46AB7FC4DBFF309295@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 10:47:40AM +0800, zhong jiang wrote:
> It is more clear to use DEFINE_DEBUGFS_ATTRIBUTE to define debugfs file
> operation rather than DEFINE_SIMPLE_ATTRIBUTE.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

Thank you!

Acked-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

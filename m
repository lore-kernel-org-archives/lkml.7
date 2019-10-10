Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41567C47404
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 01:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21CB320B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 01:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732446AbfJJBWa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 21:22:30 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:43989 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731553AbfJJBWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 21:22:30 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x9A1MHeT016151
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 10 Oct 2019 10:22:17 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9A1MHgX028027;
        Thu, 10 Oct 2019 10:22:17 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9A1MHo8000593;
        Thu, 10 Oct 2019 10:22:17 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.148] [10.38.151.148]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-9316515; Thu, 10 Oct 2019 10:22:03 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC20GP.gisp.nec.co.jp ([10.38.151.148]) with mapi id 14.03.0439.000; Thu,
 10 Oct 2019 10:22:03 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Jane Chu <jane.chu@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v4 0/2] mm/memory-failure: Poison read receives SIGKILL
 instead of SIGBUS issue
Thread-Topic: [PATCH v4 0/2] mm/memory-failure: Poison read receives SIGKILL
 instead of SIGBUS issue
Thread-Index: AQHVfgQYMR1+dM5I0kqkeQcqu0tLzKdQyn2AgAGckgCAABhEgA==
Date:   Thu, 10 Oct 2019 01:22:01 +0000
Message-ID: <20191010012201.GA2149@hori.linux.bs1.fc.nec.co.jp>
References: <1565112345-28754-1-git-send-email-jane.chu@oracle.com>
 <9af6b35d-bfbf-7f87-a419-042dff018fdd@oracle.com>
 <20191008231831.GB27781@hori.linux.bs1.fc.nec.co.jp>
 <20191009165510.9b38833c1117c77c0de21c9d@linux-foundation.org>
In-Reply-To: <20191009165510.9b38833c1117c77c0de21c9d@linux-foundation.org>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.96]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <420B238EBD4D854C9BFF7FB450C25653@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 04:55:10PM -0700, Andrew Morton wrote:
> On Tue, 8 Oct 2019 23:18:31 +0000 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com> wrote:
> 
> > I think that this patchset is good enough and ready to be merged.
> > Andrew, could you consider queuing this series into your tree?
> 
> I'll treat that as an acked-by:.

thanks.

> 
> Do you think 2/2 should be backported into -stable trees?

Yes, I think so. Please add Cc: stable.

Thanks,
Naoya Horiguchi

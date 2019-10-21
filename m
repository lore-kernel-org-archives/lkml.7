Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C34CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 07:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8A821929
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 07:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfJUHF3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 03:05:29 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:48403 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfJUHF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 03:05:28 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x9L75Flq015393
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 21 Oct 2019 16:05:15 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9L75FOq017626;
        Mon, 21 Oct 2019 16:05:15 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9L73dLb019265;
        Mon, 21 Oct 2019 16:05:15 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.152] [10.38.151.152]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-9695733; Mon, 21 Oct 2019 16:04:01 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC24GP.gisp.nec.co.jp ([10.38.151.152]) with mapi id 14.03.0439.000; Mon,
 21 Oct 2019 16:04:00 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Oscar Salvador <osalvador@suse.de>
CC:     "mhocko@kernel.org" <mhocko@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 06/16] mm,hwpoison: Kill put_hwpoison_page
Thread-Topic: [RFC PATCH v2 06/16] mm,hwpoison: Kill put_hwpoison_page
Thread-Index: AQHVhPYzgz0BcFE9qEa25BSbP458radkGqEA
Date:   Mon, 21 Oct 2019 07:04:00 +0000
Message-ID: <20191021070400.GB9037@hori.linux.bs1.fc.nec.co.jp>
References: <20191017142123.24245-1-osalvador@suse.de>
 <20191017142123.24245-7-osalvador@suse.de>
In-Reply-To: <20191017142123.24245-7-osalvador@suse.de>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.96]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <156A1B01F944214AB6C6A8C6930806A6@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 04:21:13PM +0200, Oscar Salvador wrote:
> After ("4e41a30c6d50: mm: hwpoison: adjust for new thp refcounting"),
> put_hwpoison_page got reduced to a put_page.
> Let us just use put_page instead.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Acked-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

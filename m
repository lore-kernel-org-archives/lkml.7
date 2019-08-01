Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A637C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 09:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 450E22087E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 09:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731000AbfHAJHV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 05:07:21 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:44207 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfHAJHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 05:07:20 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x7197CsK017672
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 1 Aug 2019 18:07:12 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x7197CP4008465;
        Thu, 1 Aug 2019 18:07:12 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x7196QOn002648;
        Thu, 1 Aug 2019 18:07:12 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.152] [10.38.151.152]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-7309567; Thu, 1 Aug 2019 18:06:53 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC24GP.gisp.nec.co.jp ([10.38.151.152]) with mapi id 14.03.0439.000; Thu, 1
 Aug 2019 18:06:52 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Jane Chu <jane.chu@oracle.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: Re: [PATCH v3 1/2] mm/memory-failure.c clean up around tk
 pre-allocation
Thread-Topic: [PATCH v3 1/2] mm/memory-failure.c clean up around tk
 pre-allocation
Thread-Index: AQHVQzSRmIJeo+dcwUujsqrGBDWq6ablc6CA
Date:   Thu, 1 Aug 2019 09:06:51 +0000
Message-ID: <20190801090651.GC31767@hori.linux.bs1.fc.nec.co.jp>
References: <1564092101-3865-1-git-send-email-jane.chu@oracle.com>
 <1564092101-3865-2-git-send-email-jane.chu@oracle.com>
In-Reply-To: <1564092101-3865-2-git-send-email-jane.chu@oracle.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.150]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <1FD28E0D8B0232438C43D1B28666B164@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 04:01:40PM -0600, Jane Chu wrote:
> add_to_kill() expects the first 'tk' to be pre-allocated, it makes
> subsequent allocations on need basis, this makes the code a bit
> difficult to read. Move all the allocation internal to add_to_kill()
> and drop the **tk argument.
> 
> Signed-off-by: Jane Chu <jane.chu@oracle.com>

Acked-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

# somehow I sent 2 acks to 2/2, sorry about the noise.

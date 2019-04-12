Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E855CC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4B12084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EqEgyH7e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfDLPOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:14:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55922 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfDLPOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:14:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6eopH1ulMxpwesyQyw5Ma3QJT2y7EdVBllYB2iJTBxg=; b=EqEgyH7e76H05fNJhPcj9xsQH
        gBQl3ndSh9ykqrwKlwi0vqfhT9ngC017CV/9Vg6lP/7yofGPbioE153xwlDLLik0keHRt6XymmOgW
        nuuRWVFGJdQ2C/tni0mmGV/D9stXPtaN8wrZezMBW5Ssk2xHbu0d10RTJGblUpcFSkvKi5sOa8QuG
        5r/c2uxLKp0f1a4D2Yb/t8blPLgUd+XvEr/1a43LlIve7jphml1riRGeHKFm7ZE12XV6VJUmHGeJE
        9qD6rQKCxLn9NW2oIp018CCD6TR1cY6Xmy3nF5m3ONj8KTHNttwWSklk1dlomtTXaRr296oaz5Rtm
        JABZhWMAg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hExsN-0003fV-GI; Fri, 12 Apr 2019 15:13:59 +0000
Subject: Re: linux-next: Tree for Apr 12 (net/sched/sch_taprio.c)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>
References: <20190412181707.51c073c3@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <39fbf66e-b816-447a-f214-50909aec9dfc@infradead.org>
Date:   Fri, 12 Apr 2019 08:13:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412181707.51c073c3@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/19 1:17 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20190411:
> 


on i386:

ld: net/sched/sch_taprio.o: in function `advance_sched':
sch_taprio.c:(.text+0x55d): undefined reference to `__divdi3'
ld: net/sched/sch_taprio.o: in function `taprio_dequeue':
sch_taprio.c:(.text+0x76d): undefined reference to `__divdi3'
ld: net/sched/sch_taprio.o: in function `taprio_init':
sch_taprio.c:(.text+0x12bb): undefined reference to `__divdi3'



-- 
~Randy

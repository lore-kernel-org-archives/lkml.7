Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C103FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7B92085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552919359;
	bh=d0BM1iuJfIOTJr475cQath8b8cF3zPFpFonqpht3rv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hbiG74fTPAE/TxaTY/OwSdGRo/2+/YCPxFQoX8QxI+qg4GZ8I8YBcdJ5exe5YQLT0
	 BaulMrxQpzPkPBFgnjSSuM4K50COKQIPBU49/SaFB6FVF5jaiGOwTRNvpbzuhre4fR
	 nLaGlwftdwsHtZcWMzML2NEzo3DRy7+YDw3mz5Dc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbfCRO3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:29:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:54354 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727183AbfCRO3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 10:29:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A70D1ACC5;
        Mon, 18 Mar 2019 14:29:16 +0000 (UTC)
Date:   Mon, 18 Mar 2019 15:29:16 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Pankaj Suryawanshi <pankaj.suryawanshi@einfochips.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "minchan@kernel.org" <minchan@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: Re: [External] Re: mm/cma.c: High latency for cma allocation
Message-ID: <20190318142916.GK8924@dhcp22.suse.cz>
References: <SG2PR02MB3098E44824F5AA69BC04F935E8470@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <20190318130757.GG8924@dhcp22.suse.cz>
 <SG2PR02MB309886996889791555D5B53EE8470@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <20190318134242.GI8924@dhcp22.suse.cz>
 <SG2PR02MB30986F43403B92F31499E42AE8470@SG2PR02MB3098.apcprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SG2PR02MB30986F43403B92F31499E42AE8470@SG2PR02MB3098.apcprd02.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 18-03-19 14:02:09, Pankaj Suryawanshi wrote:
>> > I have the system(vanilla kernel) with 2GB of RAM, reserved 1GB for CMA. No swap or zram.
>> > Sorry, I don't have information where the time is spent.
>> > time is calculated in between cma_alloc call.
>> > I have just cma_alloc trace information/function graph.
> 
>> Then please collect that data because it is really hard to judge
>> anything from the numbers you have provided.
>
> Any pointers from which i can get this details ?

I would start by enabling built in tracepoints for the migration or use
a system wide perf monitoring with call graph data.
-- 
Michal Hocko
SUSE Labs

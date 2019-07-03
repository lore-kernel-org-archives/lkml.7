Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CACC5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 06:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBBA621882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 06:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbfGCG4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 02:56:44 -0400
Received: from foss.arm.com ([217.140.110.172]:39196 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726684AbfGCG4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 02:56:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE7C02B;
        Tue,  2 Jul 2019 23:56:43 -0700 (PDT)
Received: from [10.162.42.95] (p8cg001049571a15.blr.arm.com [10.162.42.95])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02E933F718;
        Tue,  2 Jul 2019 23:58:34 -0700 (PDT)
Subject: Re: [PATCH] mm/page_isolate: change the prototype of
 undo_isolate_page_range()
To:     Pingfan Liu <kernelfans@gmail.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Qian Cai <cai@lca.pw>,
        linux-kernel@vger.kernel.org
References: <1562075604-8979-1-git-send-email-kernelfans@gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <ada46116-9c87-86ce-9015-351700439ea3@arm.com>
Date:   Wed, 3 Jul 2019 12:27:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1562075604-8979-1-git-send-email-kernelfans@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/02/2019 07:23 PM, Pingfan Liu wrote:
> undo_isolate_page_range() never fails, so no need to return value.
> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: linux-kernel@vger.kernel.org

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

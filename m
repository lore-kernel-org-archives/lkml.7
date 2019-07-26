Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8BAC76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 07:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10CAD229F9
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 07:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfGZH0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 03:26:41 -0400
Received: from outbound-smtp12.blacknight.com ([46.22.139.17]:49221 "EHLO
        outbound-smtp12.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726124AbfGZH0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 03:26:41 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp12.blacknight.com (Postfix) with ESMTPS id 961401C32A8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 08:26:39 +0100 (IST)
Received: (qmail 14945 invoked from network); 26 Jul 2019 07:26:39 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.19.7])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 26 Jul 2019 07:26:39 -0000
Date:   Fri, 26 Jul 2019 08:26:37 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Pengfei Li <lpf.vector@gmail.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
        cai@lca.pw, aryabinin@virtuozzo.com, osalvador@suse.de,
        rostedt@goodmis.org, mingo@redhat.com,
        pavel.tatashin@microsoft.com, rppt@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 00/10] make "order" unsigned int
Message-ID: <20190726072637.GC2739@techsingularity.net>
References: <20190725184253.21160-1-lpf.vector@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190725184253.21160-1-lpf.vector@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 02:42:43AM +0800, Pengfei Li wrote:
> Objective
> ----
> The motivation for this series of patches is use unsigned int for
> "order" in compaction.c, just like in other memory subsystems.
> 

Why? The series is relatively subtle in parts, particularly patch 5.
There have been places where by it was important for order to be able to
go negative due to loop exit conditions. If there was a gain from this
or it was a cleanup in the context of another major body of work, I
could understand the justification but that does not appear to be the
case here.

-- 
Mel Gorman
SUSE Labs

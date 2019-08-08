Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C68C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE5242173C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732662AbfHHRn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 13:43:29 -0400
Received: from foss.arm.com ([217.140.110.172]:36828 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727096AbfHHRn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 13:43:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF16815A2;
        Thu,  8 Aug 2019 10:43:28 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B55B33F575;
        Thu,  8 Aug 2019 10:43:27 -0700 (PDT)
Date:   Thu, 8 Aug 2019 18:43:25 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Daniel Axtens <dja@axtens.net>
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        aryabinin@virtuozzo.com, glider@google.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, dvyukov@google.com
Subject: Re: [PATCH v3 1/3] kasan: support backing vmalloc space with real
 shadow memory
Message-ID: <20190808174325.GD47131@lakrids.cambridge.arm.com>
References: <20190731071550.31814-1-dja@axtens.net>
 <20190731071550.31814-2-dja@axtens.net>
 <20190808135037.GA47131@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808135037.GA47131@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 02:50:37PM +0100, Mark Rutland wrote:
> Hi Daniel,
> 
> This is looking really good!
> 
> I spotted a few more things we need to deal with, so I've suggested some
> (not even compile-tested) code for that below. Mostly that's just error
> handling, and using helpers to avoid things getting too verbose.

FWIW, I had a quick go at that, and I've pushed the (corrected) results
to my git repo, along with an initial stab at arm64 support (which is
currently broken):

https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=kasan/vmalloc

Thanks,
Mark.

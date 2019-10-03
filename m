Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A614EC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A172133F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbfJCKDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 06:03:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:10494 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729896AbfJCKDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 06:03:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D18D81DBC;
        Thu,  3 Oct 2019 10:03:02 +0000 (UTC)
Received: from krava (unknown [10.43.17.55])
        by smtp.corp.redhat.com (Postfix) with SMTP id BAA04608C0;
        Thu,  3 Oct 2019 10:03:00 +0000 (UTC)
Date:   Thu, 3 Oct 2019 12:03:00 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Josh Hunt <johunt@akamai.com>
Cc:     john@metanate.com, jolsa@kernel.org,
        alexander.shishkin@linux.intel.com, khlebnikov@yandex-team.ru,
        namhyung@kernel.org, peterz@infradead.org, acme@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: 4.19 dwarf unwinding broken
Message-ID: <20191003100300.GA22784@krava>
References: <ab87d20b-526c-9435-0532-c298beeb0318@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab87d20b-526c-9435-0532-c298beeb0318@akamai.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Thu, 03 Oct 2019 10:03:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 12:54:09AM -0700, Josh Hunt wrote:
> The following commit is breaking dwarf unwinding on 4.19 kernels:

how?

jirka

> 
> commit e5adfc3e7e774ba86f7bb725c6eef5f32df8630e
> Author: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Date:   Tue Aug 7 12:09:01 2018 +0300
> 
>     perf map: Synthesize maps only for thread group leader
> 
> It looks like this was fixed later by:
> 
> commit e8ba2906f6b9054102ad035ac9cafad9d4168589
> Author: John Keeping <john@metanate.com>
> Date:   Thu Aug 15 11:01:45 2019 +0100
> 
>     perf unwind: Fix libunwind when tid != pid
> 
> but was not selected as a backport to 4.19. Are there plans to backport the
> fix? If not, could we have the breaking commit reverted in 4.19 LTS?
> 
> Thanks
> Josh

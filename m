Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46618C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DAC520693
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388188AbfDRIHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 04:07:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57096 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729497AbfDRIHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 04:07:22 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D5C7E308A102;
        Thu, 18 Apr 2019 08:07:21 +0000 (UTC)
Received: from localhost (holly.tpb.lab.eng.brq.redhat.com [10.43.134.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8535D1001DDE;
        Thu, 18 Apr 2019 08:07:20 +0000 (UTC)
Date:   Thu, 18 Apr 2019 10:07:10 +0200
From:   Miroslav Lichvar <mlichvar@redhat.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH] ntp: Allow TAI-UTC offset to be set to zero
Message-ID: <20190418080710.GE5984@localhost>
References: <20190417084833.7401-1-mlichvar@redhat.com>
 <CAFqZXNu_pc1BEGZJb=3Ez58uN+BfoECpSm2yVqv1MMx7iTLfRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqZXNu_pc1BEGZJb=3Ez58uN+BfoECpSm2yVqv1MMx7iTLfRw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 18 Apr 2019 08:07:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 11:00:23AM +0200, Ondrej Mosnacek wrote:
> On Wed, Apr 17, 2019 at 10:48 AM Miroslav Lichvar <mlichvar@redhat.com> wrote:
> > Change the ADJ_TAI check to accept zero as a valid TAI-UTC offset in
> > order to allow setting it back to the initial value.

> Thanks for sending the patch! Maybe you (or the committer) could
> consider adding:
> 
> Fixes: 153b5d054ac2 ("ntp: support for TAI")

To me the change looks more like an extension of the API, rather than
a bug fix, so I'd leave that up to the committer.

-- 
Miroslav Lichvar

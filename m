Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED6AC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF01820856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731086AbfCZHtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 03:49:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51762 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfCZHtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 03:49:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D3E2A2D7E6;
        Tue, 26 Mar 2019 07:49:49 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-32.pek2.redhat.com [10.72.12.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9408860A9F;
        Tue, 26 Mar 2019 07:49:46 +0000 (UTC)
Date:   Tue, 26 Mar 2019 15:49:42 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Petr Vorel <pvorel@suse.cz>, Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH v4a 1/2] selftests/kexec: make tests independent of IMA
 being enabled
Message-ID: <20190326074942.GA19708@dhcp-128-65.nay.redhat.com>
References: <1553283351-6310-1-git-send-email-zohar@linux.ibm.com>
 <20190325080935.GA12497@dhcp-128-65.nay.redhat.com>
 <1553546236.5561.7.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1553546236.5561.7.camel@linux.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 26 Mar 2019 07:49:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/25/19 at 04:37pm, Mimi Zohar wrote:
> On Mon, 2019-03-25 at 16:09 +0800, Dave Young wrote:
> > Hi Mimi
> > On 03/22/19 at 03:35pm, Mimi Zohar wrote:
> > > Verify IMA is enabled before failing tests or emitting irrelevant
> > > messages.  Also, don't skip the test if signatures are not required.
> > > 
> > > Suggested-by: Dave Young <dyoung@redhat.com>
> > > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > > ---
> > > Dave, if this patch resolves the outstanding issues, I can fold these
> > > changes into the original patches. (Reminder, these patches will need to
> > > be updated to support the "lockdown" patch set.)
> > 
> > They looks good to me, thanks for the update
> 
> I've folded the kexec_file_load changes into the kexec_file_load test.
>  The remaining kexec_load change is left as a separate patch, since it
> is dependent on the ikconfig change.
> 
> > Feel free to add my reviewed-by, I did some tests although not cover all
> > ima cases.
> 
> Thanks!  Is this meant as a general "reviewed-by" for all of the
> patches or just this specific one?

Thank you for taking this as a separate kexec tests, I think it can be used for these delta fixes

I read all the patches and reviewed the kexec stuff, but I do not
understand all the IMA logic yet although I did some simple ima
tests.

Thanks
Dave

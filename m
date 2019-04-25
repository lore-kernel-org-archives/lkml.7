Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A8EC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF89E2067C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbfDYNhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 09:37:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40304 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbfDYNhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 09:37:54 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 12BDD307EA92;
        Thu, 25 Apr 2019 13:37:53 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E34D01001DC0;
        Thu, 25 Apr 2019 13:37:52 +0000 (UTC)
Received: from zmail19.collab.prod.int.phx2.redhat.com (zmail19.collab.prod.int.phx2.redhat.com [10.5.83.22])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 901561803397;
        Thu, 25 Apr 2019 13:37:52 +0000 (UTC)
Date:   Thu, 25 Apr 2019 09:37:52 -0400 (EDT)
From:   Veronika Kabatova <vkabatov@redhat.com>
To:     Dhaval Giani <dhaval.giani@gmail.com>
Cc:     Sasha Levin <alexander.levin@microsoft.com>,
        shuah <shuah@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
        Tim Bird <tbird20d@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dan Carpenter <dan.carpenter@oracle.com>, willy@infradead.org,
        gustavo padovan <gustavo.padovan@collabora.co.uk>,
        Dmitry Vyukov <dvyukov@google.com>,
        knut omang <knut.omang@oracle.com>,
        Eliska Slobodova <eslobodo@redhat.com>
Message-ID: <199564879.15267174.1556199472004.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAPhKKr_uVTFAzne0QkZFUGfb8RxQdVFx41G9kXRY7sFN-=pZ6w@mail.gmail.com>
References: <CAPhKKr_uVTFAzne0QkZFUGfb8RxQdVFx41G9kXRY7sFN-=pZ6w@mail.gmail.com>
Subject: Re: Linux Testing Microconference at LPC
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.204.120, 10.4.195.30]
Thread-Topic: Linux Testing Microconference at LPC
Thread-Index: e9S1whfym86EDjnWz41Li3N4uBypIw==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 25 Apr 2019 13:37:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- Original Message -----
> From: "Dhaval Giani" <dhaval.giani@gmail.com>
> To: "Sasha Levin" <alexander.levin@microsoft.com>, "shuah" <shuah@kernel.org>, "Kevin Hilman" <khilman@baylibre.com>,
> "Tim Bird" <tbird20d@gmail.com>, "LKML" <linux-kernel@vger.kernel.org>
> Cc: "Steven Rostedt" <rostedt@goodmis.org>, "Dan Carpenter" <dan.carpenter@oracle.com>, willy@infradead.org, "gustavo
> padovan" <gustavo.padovan@collabora.co.uk>, "Dmitry Vyukov" <dvyukov@google.com>, "knut omang"
> <knut.omang@oracle.com>
> Sent: Thursday, April 11, 2019 7:37:51 PM
> Subject: Linux Testing Microconference at LPC
> 
> Hi Folks,
> 
> This is a call for participation for the Linux Testing microconference
> at LPC this year.
> 
> For those who were at LPC last year, as the closing panel mentioned,
> testing is probably the next big push needed to improve quality. From
> getting more selftests in, to regression testing to ensure we don't
> break realtime as more of PREEMPT_RT comes in, to more stable distros,
> we need more testing around the kernel.
> 
> We have talked about different efforts around testing, such as fuzzing
> (using syzkaller and trinity), automating fuzzing with syzbot, 0day
> testing, test frameworks such as ktests, smatch to find bugs in the
> past. We want to push this discussion further this year and are
> interested in hearing from you what you want to talk about, and where
> kernel testing needs to go next.
> 
> Please let us know what topics you believe should be a part of the
> micro conference this year.
> 

Hi,

as CKI team, we would like to join the Plumbers discussions about CI for
kernel. We obviously have our own working pipeline but would like to get
more involved with the other upstream projects working on the same and
collaborate on common solutions.

I already started some of these discussions on automated-testing mailing
list and got in contact with Kevin about the possibility of joining forces
with KernelCI project.

Our team planned to organize a 'hackfest' for upstream CI during the
conference but I heard that the Automated Testing Summit should likely take
place during that time too. If that's the case, we should meet up and
discuss everything there instead of organizing a separate event.


Information and links about CKI Project can be be found at [1] in case
people are curious. Some of the things we'd like to achieve is having a
single source for all upstream kernel test results where anyone doing the
testing can publish them and collaborate on solving common problems (like
interpreting test results, making build times faster, increasing the test
coverage, detecting regressions etc.)

With one of my colleagues, we will submit a microconference proposal that
could serve as the starting point for the followup discussions about these
topics.


We would like to get feedback from kernel developers and maintainers about
their expectations for testing and receiving results, as well as discuss
the collaboration with other testing/CI projects.



Veronika Kabatova
CKI Project


[1] https://cki-project.org/


> Thanks!
> Sasha and Dhaval
> 

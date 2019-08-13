Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DD0C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 16:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B748220840
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 16:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfHMQPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 12:15:06 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34502 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfHMQPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 12:15:03 -0400
Received: from [172.58.27.132] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1hxZRe-0000Cg-Ix; Tue, 13 Aug 2019 16:14:47 +0000
Date:   Tue, 13 Aug 2019 18:14:36 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v6 2/2] selftests: add tests for clone3()
Message-ID: <20190813161434.s7oqkvzkzvqr4lt4@wittgenstein>
References: <20190812200939.23784-1-areber@redhat.com>
 <20190812200939.23784-2-areber@redhat.com>
 <20190813144618.r57njm3maoh7epr3@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190813144618.r57njm3maoh7epr3@wittgenstein>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 04:46:18PM +0200, Christian Brauner wrote:
> On Mon, Aug 12, 2019 at 10:09:39PM +0200, Adrian Reber wrote:
> > This tests clone3() with and without set_tid to see if all desired PIDs
> > are working as expected. The test tries to clone3() with a set_tid of
> > -1, 1, pid_max, a PID which is already in use and an unused PID. The
> > same tests are also running in PID namespace.
> > 
> > In addition the clone3 test (without set_tid) tries to call clone3()
> > with different sizes of clone_args.
> > 
> > Signed-off-by: Adrian Reber <areber@redhat.com>
> 
> This is missing a .gitignore file for the new binaries. But no need to
> resend I'll just add that myself.

Oh, I see it now. :)

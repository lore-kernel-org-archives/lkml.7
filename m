Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F944C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 08:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3636D207FA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 08:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbfKHI3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 03:29:45 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59616 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbfKHI3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 03:29:44 -0500
Received: from [185.81.138.22] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iSzeG-0008J7-SS; Fri, 08 Nov 2019 08:29:41 +0000
Date:   Fri, 8 Nov 2019 09:29:39 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests: add tests for clone3()
Message-ID: <20191108082937.ypc5t2fcr2ffmlmm@wittgenstein>
References: <20191104131846.1076814-1-areber@redhat.com>
 <20191106155914.hzolyolz2w4hcn7w@wittgenstein>
 <20191108064416.GA153851@dcbz.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191108064416.GA153851@dcbz.redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 07:44:16AM +0100, Adrian Reber wrote:
> On Wed, Nov 06, 2019 at 04:59:15PM +0100, Christian Brauner wrote:
> > On Mon, Nov 04, 2019 at 02:18:46PM +0100, Adrian Reber wrote:

> Not sure myself. It was just to make sure clone3() does not something
> unexpected when given wrong and unexpected input. It is the opposite to
> setting everything to zero. Not sure how much sense it makes, but as it
> already exists I would say to just keep it.

If it serves no real purpose then please remove it. It's not clear from
thist test _why_ it it expected to fail. Is it because of invalid stack
and stack_size or invalid tls etc.

> 
> > > +		args.flags = 1;
> > > +		args.pidfd = 1;
> > > +		args.child_tid = 1;
> > > +		args.parent_tid = 1;
> > > +		args.exit_signal = 1;
> > > +		args.stack = 1;
> > > +		args.stack_size = 1;
> > > +		args.tls = 1;
> > > +		break;
> > > +	case CLONE3_ARGS_INVAL_EXIT_SIGNAL_BIG:
> [...]
> 
> Let me know if you think that the CLONE3_ARGS_ALL_1 should really be
> removed. I will fix the other two things you mentioned and resend a new
> version.

Yes, please.

	Christian

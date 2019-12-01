Return-Path: <SRS0=SILN=ZX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B158C432C3
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 16:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5150E20718
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 16:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfLAQnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 11:43:02 -0500
Received: from mailbackend.panix.com ([166.84.1.89]:55647 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfLAQnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 11:43:01 -0500
Received: from hp-x360n.lan (cpe-108-185-41-56.socal.res.rr.com [108.185.41.56])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 47QvDx08Mnz1Gtw;
        Sun,  1 Dec 2019 11:42:56 -0500 (EST)
Date:   Sun, 1 Dec 2019 08:42:55 -0800 (PST)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     Ingo Molnar <mingo@kernel.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>, mceier@gmail.com,
        Davidlohr Bueso <dave@stgolabs.net>,
        kernel test robot <rong.a.chen@intel.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [PATCH] x86/pat: Fix off-by-one bugs in interval tree search
In-Reply-To: <20191201144947.GA4167@gmail.com>
Message-ID: <alpine.DEB.2.21.1912010842310.4698@hp-x360n>
References: <20191127005312.GD20422@shao2-debian> <CAJTyqKPstH9PYk1nMuRJWnXUPTf9wAkphPFi9Yfz6PApLVVE0Q@mail.gmail.com> <20191130212729.ykxstm5kj2p5ir6q@linux-p48b> <CAJTyqKOp+mV1CfpasschSDO4vEDbshE4GPCB6+aX4rJOYSF=7A@mail.gmail.com>
 <CAHk-=wh--xwpatv_Rcp3WtCPQtg-RVoXYQj8O+1TSw8os7Jtvw@mail.gmail.com> <20191201104624.GA51279@gmail.com> <20191201144947.GA4167@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 1 Dec 2019, Ingo Molnar wrote:

> So it would be nice if everyone who is seeing this bug could test the
> patch below against Linus's latest tree - does it fix the regression?

I'll be sure to test it later today.

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley

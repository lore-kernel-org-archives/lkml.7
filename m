Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A1FC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCEC0214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388591AbfDRKWt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 06:22:49 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59396 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388044AbfDRKWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 06:22:49 -0400
Received: from turkeyburger.collabora.co.uk (turkeyburger.collabora.co.uk [46.235.227.230])
        by bhuna.collabora.co.uk (Postfix) with ESMTP id 6BFFA28261F;
        Thu, 18 Apr 2019 11:22:47 +0100 (BST)
Content-Type: text/plain; charset="utf-8"
In-Reply-To: <CAPhKKr_uVTFAzne0QkZFUGfb8RxQdVFx41G9kXRY7sFN-=pZ6w@mail.gmail.com>
From:   "Gustavo Padovan" <gustavo.padovan@collabora.com>
X-Forward: 2804:14c:6a:a762::1000
Date:   Thu, 18 Apr 2019 11:22:47 +0100
Cc:     "Sasha Levin" <alexander.levin@microsoft.com>,
        "shuah" <shuah@kernel.org>, "Kevin Hilman" <khilman@baylibre.com>,
        "Tim Bird" <tbird20d@gmail.com>,
        "LKML" <linux-kernel@vger.kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        =?utf-8?q?Carpenter=2CDan?= <dan.carpenter@oracle.com>,
        willy@infradead.org, "Dmitry Vyukov" <dvyukov@google.com>,
        knut.omang@oracle.com,
        "Guillaume Charles Tucker" <guillaume.tucker@collabora.com>
To:     "Dhaval Giani" <dhaval.giani@gmail.com>
MIME-Version: 1.0
Message-ID: <2dfb-5cb85000-7-65937800@86141034>
Subject: =?utf-8?q?Re=3A?= Linux Testing Microconference at LPC
User-Agent: SOGoMail 4.0.7
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
 
On Thursday, April 11, 2019 14:37 -03, Dhaval Giani <dhaval.giani@gmail.com> wrote: 
 
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

Guillaume would like to talk about the his work on kernelCI on automated bisection, functional testing and modular pipelines.

Regards,

Gustavo


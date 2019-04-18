Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8857C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD3CF217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389063AbfDRN02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:26:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:32778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388302AbfDRN02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 09:26:28 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 769B6217D7;
        Thu, 18 Apr 2019 13:26:26 +0000 (UTC)
Date:   Thu, 18 Apr 2019 09:26:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Gustavo Padovan" <gustavo.padovan@collabora.com>
Cc:     "Dhaval Giani" <dhaval.giani@gmail.com>,
        "Sasha Levin" <alexander.levin@microsoft.com>,
        "shuah" <shuah@kernel.org>, "Kevin Hilman" <khilman@baylibre.com>,
        "Tim Bird" <tbird20d@gmail.com>,
        "LKML" <linux-kernel@vger.kernel.org>,
        "Carpenter,Dan" <dan.carpenter@oracle.com>, willy@infradead.org,
        "Dmitry Vyukov" <dvyukov@google.com>, knut.omang@oracle.com,
        "Guillaume Charles Tucker" <guillaume.tucker@collabora.com>
Subject: Re: Linux Testing Microconference at LPC
Message-ID: <20190418092624.61b3611b@gandalf.local.home>
In-Reply-To: <2dfb-5cb85000-7-65937800@86141034>
References: <CAPhKKr_uVTFAzne0QkZFUGfb8RxQdVFx41G9kXRY7sFN-=pZ6w@mail.gmail.com>
        <2dfb-5cb85000-7-65937800@86141034>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Apr 2019 11:22:47 +0100
"Gustavo Padovan" <gustavo.padovan@collabora.com> wrote:

> Guillaume would like to talk about the his work on kernelCI on automated bisection, functional testing and modular pipelines.

Can you be more specific about what Guillaume wants to talk about for
those topics? I hope it's not just a "let everyone know what Guillaume
has done" talk. Plumbers is about discussions of on going and future
work. If these are all work-in-progress and Guillaume is looking for
input from other stakeholder developers, then that is exactly what
Plumbers is about. But if this is just to show developers what was done
and how to use the finished work, then save that for something like
Open Source Summit.

-- Steve

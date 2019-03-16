Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D93FC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 01:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB75218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 01:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfCPBTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 21:19:41 -0400
Received: from hurricane.the-brannons.com ([71.19.155.94]:51896 "EHLO
        hurricane.the-brannons.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726549AbfCPBTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 21:19:41 -0400
Received: from localhost (unknown [IPv6:2602:61:736a:f100::a00b:8ad9])
        by hurricane.the-brannons.com (Postfix) with ESMTPSA id 74427791FB;
        Fri, 15 Mar 2019 18:19:40 -0700 (PDT)
From:   Chris Brannon <chris@the-brannons.com>
To:     Okash Khawaja <okash.khawaja@gmail.com>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        "Samuel Thibault" <samuel.thibault@ens-lyon.org>,
        "William Hubbs" <w.d.hubbs@gmail.com>,
        "Christopher Brannon" <chris@the-brannons.com>,
        "Kirk Reiser" <kirk@reisers.ca>, linux-kernel@vger.kernel.org
Subject: Re: Staging status of speakup
References: <20190315130035.6a8f16e9@narunkot>
Date:   Fri, 15 Mar 2019 18:19:39 -0700
In-Reply-To: <20190315130035.6a8f16e9@narunkot> (Okash Khawaja's message of
        "Fri, 15 Mar 2019 13:01:27 +0000")
Message-ID: <87ef77obtg.fsf@cmbmachine.messageid.invalid>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Okash Khawaja <okash.khawaja@gmail.com> writes:

> Finally there is an issue where text in output buffer sometimes gets
> garbled on SMP systems, but we can continue working on it after the
> driver is moved out of staging, if that's okay. Basically we need a
> reproducer of this issue.

What kind of reproducer do you need here?  It's straightforward to
reproduce in casual use, at least with a software synthesizer.  I don't
know whether it affects hardware synths.

-- Chris

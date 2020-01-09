Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586FCC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 19:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ED35206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 19:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578598628;
	bh=j1R2qBJgefAVw/wmJo//yRMjgkVXasWhwHKHjs8kKSM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=ACmJFZoxl/7XF8Pu+tpXWfBDBsRVMMnkH3PvgCn8sZR8r5YKjb6teoGH6DXuIrgiU
	 8h1WJVy4ZNZZ6WKZfmiWg5QbwWyrEIsealn84paPXrwUk7/A9ki5YSfypV1v3Je7SK
	 e3cMC+U1jT6EuTafX7WO30y5anJ8E3gAfuY6Zkn8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731212AbgAIThH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 14:37:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:44610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730435AbgAIThG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 14:37:06 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98D0E206ED;
        Thu,  9 Jan 2020 19:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578598625;
        bh=j1R2qBJgefAVw/wmJo//yRMjgkVXasWhwHKHjs8kKSM=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=KWPp38CR+vjvwUB6BCQJlR5LlZSYcGDoLino1VhauHvAEYu22RHBtoGRg7FEFOqnX
         agYyuNSHibRDLQlyBrEZ2wmTwBR5v7dd7Zfd4Z+852OtUQAOs8Xs2bZaF1ZTNvKZJP
         YsAKS8RxGcV+XkdP95Gb/arePENQnLL+elQtbXQA=
Date:   Thu, 9 Jan 2020 20:37:02 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Marcel Holtmann <marcel@holtmann.org>
cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [GIT PULL] HID fixes
In-Reply-To: <CAHk-=wj+zyWsZGhiCiopkrnu1_bkNE1Ax+82sP4Donsv9pUZuw@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.2001092032430.31058@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2001091519080.31058@cbobk.fhfr.pm> <CAHk-=wj+zyWsZGhiCiopkrnu1_bkNE1Ax+82sP4Donsv9pUZuw@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jan 2020, Linus Torvalds wrote:

> I expect to see a fix, and I expect people to start thinking about it.
> And Marcel, since you were told it was buggy once, why didn't you then
> inform Jiri that you had sent *him* the same buggy code? How many
> other people have you sent that buggy patch to without then informing
> them that it was completely bogus?

Hm, right, the bug in this patch indeed escaped my attention (also I have 
not been aware of this being buggy in uinput before either), thanks for 
spotting this.

Marcel, will you please send me fixup ASAP? 

-- 
Jiri Kosina
SUSE Labs


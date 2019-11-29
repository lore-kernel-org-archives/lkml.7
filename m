Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70F7C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 20:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D262176D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 20:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfK2Uf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 15:35:56 -0500
Received: from mailbackend.panix.com ([166.84.1.89]:63029 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbfK2Uf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 15:35:56 -0500
Received: from hp-x360n (rrcs-98-153-158-222.west.biz.rr.com [98.153.158.222])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 47PmVd1m2pzm6L;
        Fri, 29 Nov 2019 15:35:53 -0500 (EST)
Date:   Fri, 29 Nov 2019 12:35:51 -0800 (PST)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] ACPI: PM: s2idle: Fix possible suspend lock-up
In-Reply-To: <2787005.CsmIKtZlk9@kreacher>
Message-ID: <alpine.DEB.2.21.1911291231510.6038@hp-x360n>
References: <2787005.CsmIKtZlk9@kreacher>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 28 Nov 2019, Rafael J. Wysocki wrote:

> Please test this series and let me know if it works for you too.

I've tested this quite a few times against the issues reported on the Linux-PM
mailing list ("resume failures if the charger is plugged in while suspended
and the battery is at < 90%" and "spurious wakeups from the EC for non-power
events") and this patchset has fixed both of these issues (the latter is
especially surprising and welcome).

I'm pretty happy with it; it's been a while since I've had a consistently
cold laptop while suspended. Much thanks!

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley

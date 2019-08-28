Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944BAC3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 09:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760FB214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 09:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfH1JGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 05:06:44 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:56300 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfH1JGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 05:06:44 -0400
Received: from 79.184.255.249.ipv4.supernova.orange.pl (79.184.255.249) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 454af4f2b3dfb6e0; Wed, 28 Aug 2019 11:06:41 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     myungjoo.ham@gmail.com
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: linux-next: build warning after merge of the devfreq tree
Date:   Wed, 28 Aug 2019 11:06:41 +0200
Message-ID: <1642617.PhSKYY5FVN@kreacher>
In-Reply-To: <CAJ0PZbRvDMW2EApVJ1aaP4O9P3SQTs6Urysm3g-89NrfvVqP-g@mail.gmail.com>
References: <20190826215017.02ab0d34@canb.auug.org.au> <CAJ0PZbRvDMW2EApVJ1aaP4O9P3SQTs6Urysm3g-89NrfvVqP-g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 26, 2019 2:46:08 PM CEST MyungJoo Ham wrote:
> Thank you for pointing this out!
> 
> I've added a fix to the tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git/log/?h=for-next
> (and shared the patch in a previous reply)
> 
> Rafael, could you please pull the fix from the git repo above?

Done, thanks!




Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82B0C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D0721924
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbfJAR1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 13:27:38 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:50464 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730365AbfJAR1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 13:27:38 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1D8F6154F3D76
        for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2019 10:27:38 -0700 (PDT)
Date:   Tue, 01 Oct 2019 10:27:37 -0700 (PDT)
Message-Id: <20191001.102737.269828508885775371.davem@davemloft.net>
To:     linux-kernel@vger.kernel.org
Subject: bad changes to object building recently
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 01 Oct 2019 10:27:38 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I don't know what has caused this but I am hitting two big problems
which are severely effecting my daily workflow:

1) Something is grinding like crazy when just building a single
   object like "make path/to/foo.o", it looks like make is churning
   on lots of work.

   This used to be instantaneous and is essential for my build sanity
   checking when I apply networking patches.

2) You no longer can do a "make path/to/foo.o" to force an object file
   to be built outside of your current config.  This is also essential
   for my workflow, I can force build objects only enable'able on
   other platforms and it works %95 of the time for basic build sanity
   checking.

Someone please track down these problems and fix them.

Thank you.

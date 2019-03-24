Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA1CC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 01:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0640120835
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 01:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbfCXBet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 21:34:49 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:35168 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbfCXBes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 21:34:48 -0400
Received: from localhost (unknown [50.233.106.125])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6C63614B479D1;
        Sat, 23 Mar 2019 18:34:48 -0700 (PDT)
Date:   Sat, 23 Mar 2019 21:34:48 -0400 (EDT)
Message-Id: <20190323.213448.1035073574825061002.davem@davemloft.net>
To:     alexandre.belloni@bootlin.com
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] rtc: sun4v: set range
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190322072256.17108-2-alexandre.belloni@bootlin.com>
References: <20190322072256.17108-1-alexandre.belloni@bootlin.com>
        <20190322072256.17108-2-alexandre.belloni@bootlin.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 23 Mar 2019 18:34:48 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Fri, 22 Mar 2019 08:22:55 +0100

> The Sun4v Hypervisor Core API Specification states:
> Time is described by a single unsigned 64-bit word equivalent to a time_t
> for the POSIX time(2) system call. The word contains the time since the
> Epoch (00:00:00 UTC, January 1, 1970), measured in seconds.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Acked-by: David S. Miller <davem@davemloft.net>

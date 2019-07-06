Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5682C5B578
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 10:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8814E21670
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 10:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562407405;
	bh=KjooE0wh5+NyC1Ywyhd1Fy7vdTyIgPOhlw2BiK38em8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wD68Z5jnH6Lx842QevbeLrWc1mCyAB2a5A0f/9OSxXLr0RC0WGzBFf0iJa2oWcBr5
	 wqGuWiCg9CoVfwTVFzuMLbqZhdydLMdlkyhK4OQARIghiIGxL6fVQEXnjAWLeQ+jr6
	 ofHzKuaaG9NaTB8v/cGo6Ih2lIymqK7mFAc7veMc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfGFKDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 06:03:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbfGFKDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 06:03:23 -0400
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C872620989;
        Sat,  6 Jul 2019 10:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562407402;
        bh=KjooE0wh5+NyC1Ywyhd1Fy7vdTyIgPOhlw2BiK38em8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cc0okKCgbvBnAN1uLzjEOLjaj4RoPGwHdPxpJ5d864DSXIcNwEQRTHRFbPnJRAyKG
         x6WZ91849sX9a9zs7yMISeGny9aSq1xEZ9Nsk1STfVgdNMPQ+KUUB1EoYr+C3x3vCb
         ifqSk9iifkYnKj2wlD4O9I2omAF7kRma82rtAc5E=
Date:   Sat, 6 Jul 2019 12:02:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Gromm <christian.gromm@microchip.com>,
        tglx@linutronix.de
Subject: Re: [PATCH 4/7] staging: most: Use spinlock_t instead of struct
 spinlock
Message-ID: <20190706100253.GA20497@kroah.com>
References: <20190704153803.12739-1-bigeasy@linutronix.de>
 <20190704153803.12739-5-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704153803.12739-5-bigeasy@linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 05:38:00PM +0200, Sebastian Andrzej Siewior wrote:
> For spinlocks the type spinlock_t should be used instead of "struct
> spinlock".

Why?

> Use spinlock_t for spinlock's definition.

Why?  I agree it makes the code smaller, but why is this required?

thanks,

greg k-h

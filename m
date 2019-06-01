Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509E9C28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 11:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E7CF244D4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 11:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfFALCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 07:02:50 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:33274 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfFALCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 07:02:50 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hX1mh-0001op-Aa; Sat, 01 Jun 2019 13:02:47 +0200
Date:   Sat, 1 Jun 2019 13:02:47 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Soeren Moch <smoch@web.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] Revert "usb: core: remove local_irq_save() around
 ->complete() handler"
Message-ID: <20190601110247.v4lzwvqhuwrjrotb@linutronix.de>
References: <20190531215340.24539-1-smoch@web.de>
 <20190531220535.GA16603@kroah.com>
 <6c03445c-3607-9f33-afee-94613f8d6978@web.de>
 <20190601105008.zfqrtu6krw4mhisb@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190601105008.zfqrtu6krw4mhisb@linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-01 12:50:08 [+0200], To Soeren Moch wrote:
> I will look into this. 

nothing obvious. If there is really blocken lock, could you please
enable lockdep
|CONFIG_LOCK_DEBUGGING_SUPPORT=y
|CONFIG_PROVE_LOCKING=y
|# CONFIG_LOCK_STAT is not set
|CONFIG_DEBUG_RT_MUTEXES=y
|CONFIG_DEBUG_SPINLOCK=y
|CONFIG_DEBUG_MUTEXES=y
|CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
|CONFIG_DEBUG_RWSEMS=y
|CONFIG_DEBUG_LOCK_ALLOC=y
|CONFIG_LOCKDEP=y
|# CONFIG_DEBUG_LOCKDEP is not set
|CONFIG_DEBUG_ATOMIC_SLEEP=y

and send me the splat that lockdep will report?
 
> > Thanks,
> > Soeren

Sebastian

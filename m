Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25F9C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB5FA20848
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfDOLEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:04:06 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45429 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbfDOLEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 07:04:06 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hFzP9-0005sN-VM; Mon, 15 Apr 2019 13:04:04 +0200
Date:   Mon, 15 Apr 2019 13:04:03 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Alleged fix for writer stall on -rcu branch dev
Message-ID: <20190415110403.4yivka4cofckgxwb@linutronix.de>
References: <20190409221426.GA11212@linux.ibm.com>
 <20190410181538.3ocva5lmh7ghrisr@linutronix.de>
 <20190410184105.GR14111@linux.ibm.com>
 <20190410191918.g2yqnsmuqukmzdfe@linutronix.de>
 <20190410203302.GT14111@linux.ibm.com>
 <20190411000610.GA3867@linux.ibm.com>
 <20190413142153.GA17704@linux.ibm.com>
 <20190415104047.mrtmv6w6kq5m44fp@linutronix.de>
 <20190415105645.GQ14111@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190415105645.GQ14111@linux.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-15 03:56:45 [-0700], Paul E. McKenney wrote:
> This is new in rcutorture as well.  It is complaining that we just got
> done with a stutter interval (in which torturing temporarily stops)
> but not everything has progressed through the callback chain to be freed.
> And in this case it is happening during rcutorture shutdown, so I need
> to check the callback -- I might need end-of-run checks in that WARN_ON().

good so nothing important so far. I hope the box gets to TREE08 soon.
Do you want to me retrigger the run with your newer dev branch once it
is done?

> 
> 							Thanx, Paul

Sebastian

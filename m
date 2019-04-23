Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAF4C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34EFF217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbfDWQpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:45:05 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49970 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbfDWQpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:45:05 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hIyXQ-0003zN-13; Tue, 23 Apr 2019 18:44:56 +0200
Date:   Tue, 23 Apr 2019 18:44:55 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [rcu:dev.2019.04.16a 38/72] kernel/rcu/tree.c:2408:36: sparse:
 sparse: incorrect type in initializer (different address spaces)
Message-ID: <20190423164455.gpaqksylv7ui3gxq@linutronix.de>
References: <201904231828.a3jAyl28%lkp@intel.com>
 <20190423124619.GH3923@linux.ibm.com>
 <20190423150814.4lhcavywthyiwipd@linutronix.de>
 <20190423163809.GQ3923@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190423163809.GQ3923@linux.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-23 09:38:09 [-0700], Paul E. McKenney wrote:
> Ah, thank you!  Shall I fold the above patch into your existing one,
> or are you looking to do something else here?

The problem (that has been reported) isn't introduced by the patch in
question but existed since the very beginning. I intend to post a patch
with proper description.

> 							Thanx, Paul

Sebastian

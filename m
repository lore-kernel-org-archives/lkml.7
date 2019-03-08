Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48BEC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 15:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D407205F4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 15:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfCHPxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 10:53:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:58910 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726254AbfCHPxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 10:53:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 35EA8AC24;
        Fri,  8 Mar 2019 15:53:53 +0000 (UTC)
Date:   Fri, 8 Mar 2019 16:53:52 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Calvin Owens <calvinowens@fb.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 3/4] printk: Add consoles to a virtual "console" bus
Message-ID: <20190308155352.g43mt44adau6cgh6@pathway.suse.cz>
References: <cover.1551486732.git.calvinowens@fb.com>
 <087b13f7812b32cc7c3f9efea71c9bcf324dd031.1551486732.git.calvinowens@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <087b13f7812b32cc7c3f9efea71c9bcf324dd031.1551486732.git.calvinowens@fb.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2019-03-01 16:48:19, Calvin Owens wrote:
> This patch embeds a device struct in the console struct, and registers
> them on a "console" bus so we can expose attributes in sysfs.
> 
> Early console structures must still be static, since they're required
> before we're able to allocate memory. The least ugly way I can come up
> with to handle this is an "is_static" flag in the structure which makes
> the gets and puts NOPs, and is checked in ->release() to catch mistakes.

I wonder if it might get detected by is_kernel_inittext().

Best Regards,
Petr

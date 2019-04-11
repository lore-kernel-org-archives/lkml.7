Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5271C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C2C82075B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfDKQ7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:59:55 -0400
Received: from muru.com ([72.249.23.125]:45352 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbfDKQ7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 12:59:55 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 5E63A810D;
        Thu, 11 Apr 2019 17:00:09 +0000 (UTC)
Date:   Thu, 11 Apr 2019 09:59:50 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Roger Quadros <rogerq@ti.com>
Cc:     s-anna@ti.com, t-kristo@ti.com, nsekhar@ti.com,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] bus: ti-sysc: Add generic enable/disable functions
Message-ID: <20190411165950.GR2839@atomide.com>
References: <20190408095239.30378-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408095239.30378-1-rogerq@ti.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Roger Quadros <rogerq@ti.com> [190408 02:53]:
> For non legacy cases, add generic sysc_enable_module()
> and sysc_disable_module() functions.
...

> - Add helper to get best idle mode.
> - Add comment about not preventing clockdomain autoidle
>   during enable/disable.

FYI I have a patch in works to populate clkdm_deny_idle/allow_idle
via platform data functions for ti-sysc driver for non-legacy
cases.

We still need to figure out what we want to do for cases where a
child device driver needs to manage rstctrl reset driver bits not
related for the module reset. Not sure if we need to call
clkdm_deny_idle/allow_idle for those cases too?

Regards,

Tony

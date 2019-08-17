Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24A1C3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 06:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B3DB21743
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 06:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfHQGzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 02:55:15 -0400
Received: from muru.com ([72.249.23.125]:58042 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbfHQGzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 02:55:15 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B8811812D;
        Sat, 17 Aug 2019 06:55:41 +0000 (UTC)
Date:   Fri, 16 Aug 2019 23:55:10 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>,
        Dan Williams <dan.j.williams@intel.com>,
        Lars Melin <larsm17@gmail.com>,
        Marcel Partap <mpartap@gmx.net>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Michael Scott <hashcode0f@gmail.com>,
        NeKit <nekit1000@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCHv2] USB: serial: option: Add Motorola modem UARTs
Message-ID: <20190817065510.GH52127@atomide.com>
References: <20190815082602.51765-1-tony@atomide.com>
 <20190815112737.GD32300@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815112737.GD32300@localhost>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Johan Hovold <johan@kernel.org> [190815 11:28]:
> On Thu, Aug 15, 2019 at 01:26:02AM -0700, Tony Lindgren wrote:
> > Tested-by: Pavel Machek <pavel@ucw.cz>
> > Signed-off-by: Tony Lingren <tony@atomide.com>
> 
> I fixed up the typo in your name here, which checkpatch caught.

Oopsie :)

> > Changes since v1:
> > - Leave out defines as suggested by Lars
> 
> Thanks, Tony. Now applied.

Thanks,

Tony

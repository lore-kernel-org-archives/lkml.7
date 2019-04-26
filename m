Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E52C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84C6B212F5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=haabendal.dk header.i=@haabendal.dk header.b="A3rfiIIc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfDZRPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 13:15:01 -0400
Received: from mailrelay3-1.pub.mailoutpod1-cph3.one.com ([46.30.210.184]:22151
        "EHLO mailrelay3-1.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726694AbfDZRNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 13:13:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=haabendal.dk; s=20140924;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:from;
        bh=0n0x+kUNbcfzfRlyD3K3sloHTqmwgDsJsWgQ0K2q26I=;
        b=A3rfiIIc6h+Lp3sWzHi/Fk5Hqgxn5sozsvFQ3wxFtJeQyHWLVf679Cgc8l6CBCvyaw1HOnmCn7z+M
         GNBOnXLQS7hrc1pZgeWHhA2yRowKHyRnOIppYbyhmk4i4bserLljQ/HwkfmpkYNwsDdTvnqdLet4/8
         HXPKT4dqFvuHpZdw=
X-HalOne-Cookie: 0672e957f43c17a3a2df973bcd2a61422d1516ba
X-HalOne-ID: 4ff49680-6844-11e9-9a3c-d0431ea8bb03
Received: from localhost (unknown [87.49.45.205])
        by mailrelay3.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 4ff49680-6844-11e9-9a3c-d0431ea8bb03;
        Fri, 26 Apr 2019 16:57:02 +0000 (UTC)
From:   Esben Haabendal <esben@haabendal.dk>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>,
        Florian Fainelli <f.fainelli@gmail.com>,
        He Zhe <zhe.he@windriver.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] serial: 8250: Add support for 8250/16550 as MFD function
References: <20190426084038.6377-1-esben@geanix.com>
        <20190426143521.GW9224@smile.fi.intel.com>
Date:   Fri, 26 Apr 2019 18:57:01 +0200
In-Reply-To: <20190426143521.GW9224@smile.fi.intel.com> (Andy Shevchenko's
        message of "Fri, 26 Apr 2019 17:35:21 +0300")
Message-ID: <87wojgemci.fsf@haabendal.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Fri, Apr 26, 2019 at 10:40:36AM +0200, Esben Haabendal wrote:
>> This series adds a driver for adding 8250/16550 UART ports as functions to
>> MFD devices.
>> 
>
> The patch 2/2 disappeared.

Yes, seems like that.  I have resent it by itself.  Or do I have to
resend the series as a whole?

/Esben

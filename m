Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF502C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE3222189E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfGCRZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 13:25:56 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:54796 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGCRZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 13:25:56 -0400
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id 6E4EF4D456; Wed,  3 Jul 2019 19:25:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id 6857B4D455;
        Wed,  3 Jul 2019 19:25:53 +0200 (CEST)
Date:   Wed, 3 Jul 2019 19:25:53 +0200 (CEST)
From:   Nikolaus Voss <nv@vosn.de>
X-X-Sender: nv@fox.voss.local
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drivers/usb/typec/tps6598x.c: fix portinfo width
In-Reply-To: <20190703163908.GB17160@kroah.com>
Message-ID: <alpine.DEB.2.20.1907031924190.23225@fox.voss.local>
References: <20190628083417.GA21701@kuha.fi.intel.com> <f8daf204d49fff00db33e2b417a20afcc58ad56e.1561712364.git.nikolaus.voss@loewensteinmedical.de> <20190628095843.GB21701@kuha.fi.intel.com> <alpine.DEB.2.20.1906281208190.21573@fox.voss.local>
 <20190703163908.GB17160@kroah.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jul 2019, Greg Kroah-Hartman wrote:
> On Fri, Jun 28, 2019 at 12:10:41PM +0200, Nikolaus Voss wrote:
>> On Fri, 28 Jun 2019, Heikki Krogerus wrote:
>>> On Fri, Jun 28, 2019 at 11:01:08AM +0200, Nikolaus Voss wrote:
>>>> Portinfo bit field is 3 bits wide, not 2 bits. This led to
>>>> a wrong driver configuration for some tps6598x configurations.
>>>>
>>>> Fixes: 0a4c005bd171 ("usb: typec: driver for TI TPS6598x USB Power Delivery controllers")
>>>> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
>>>
>>> Shouldn't this be applied to the stable trees as well?
>>
>> Oh, yes, forgot that again... Greg, could you...?
>
> It's not like I have anything else to do... :)

I know. Sorry. I'll repost if you want, just say ick or something then...

Nikolaus

Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2BCC17441
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 05:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A8E3206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 05:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfKKFmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 00:42:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:57618 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726164AbfKKFmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 00:42:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2E3A4ACC0;
        Mon, 11 Nov 2019 05:42:06 +0000 (UTC)
Subject: Re: [PATCH] base: soc: Export soc_device_to_device() helper
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-realtek-soc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20191103013645.9856-3-afaerber@suse.de>
 <20191111045609.7026-1-afaerber@suse.de> <20191111052741.GB3176397@kroah.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <586fa37c-6292-aca4-fa7c-73064858afaf@suse.de>
Date:   Mon, 11 Nov 2019 06:42:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191111052741.GB3176397@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Am 11.11.19 um 06:27 schrieb Greg Kroah-Hartman:
> On Mon, Nov 11, 2019 at 05:56:09AM +0100, Andreas Färber wrote:
>> Use of soc_device_to_device() in driver modules causes a build failure.
>> Given that the helper is nicely documented in include/linux/sys_soc.h,
>> let's export it as GPL symbol.
> 
> I thought we were fixing the soc drivers to not need this.  What
> happened to that effort?  I thought I had patches in my tree (or
> someone's tree) that did some of this work already, such that this
> symbol isn't needed anymore.

I do still see this function used in next-20191108 in drivers/soc/.

I'll be happy to adjust my RFC driver if someone points me to how!

Given the current struct layout, a type cast might work (but ugly).
Or if we stay with my current RFC driver design, we could use the
platform_device instead of the soc_device (which would clutter the
screen more than "soc soc0:") or resort to pr_info() w/o device.

Thanks,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)

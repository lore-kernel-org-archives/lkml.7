Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A37C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D43E1206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfHSOPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:15:08 -0400
Received: from 195-159-176-226.customer.powertech.no ([195.159.176.226]:33148
        "EHLO blaine.gmane.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfHSOPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:15:05 -0400
Received: from list by blaine.gmane.org with local (Exim 4.89)
        (envelope-from <glk-linux-kernel-4@m.gmane.org>)
        id 1hziR4-00148V-2L
        for linux-kernel@vger.kernel.org; Mon, 19 Aug 2019 16:15:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   James <bjlockie@lockie.ca>
Subject: Re: nouveau: System crashes with NVIDIA GeForce 8600 GT
Date:   Mon, 19 Aug 2019 09:55:20 -0400
Message-ID: <03ec19b7-0a54-39cc-5bb2-1b09bb8fccc6@lockie.ca>
References: <20190817125033.p3vdkq3xzz45aidz@alex-chromebook>
 <201908181727.04076.linux@zary.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <201908181727.04076.linux@zary.sk>
Content-Language: en-US
Cc:     nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-18 11:27 a.m., Ondrej Zary wrote:
> On Saturday 17 August 2019 14:50:33 Alex Dewar wrote:
>> Hi all,
>>
>> I'm getting frequent system crashes (every few hours or so) and it seems
>> that the nouveau driver is causing the issue (dmesg output below). I see it
>> with both v5.2.8 and the v4.19 LTS kernel. Sometimes the system
>> completely freezes and sometimes seemingly just the nouveau driver goes
>> down. The screen freezes and colours stream across it. Often after I
>> reboot the BIOS logo is mangled too until the first modeset. The crash
>> seems to be happening in nv50_fb_intr() in nv50.c.
>>
>> I'm not sure if this is related, but the system now often freezes on
>> suspend or resume since I switched from using the old (recently
>> abandoned) proprietry NVIDIA drivers, again both with 5.2 and 4.19
>> kernels. Blacklisting the nouveau driver doesn't seem to fix it however,
>> though I guess the graphics card could still be causing issues in some
>> other way? I never had problems with suspend and resume before.
>>
>> Any suggestions about how I could debug this further?
> 
> Is it really a software problem (does it still work fine with proprietary
> driver)?
> These nVidia chips are known to fail and corrupt BIOS logo suggests that.
> 

It's interesting the proprietary driver still seems to have support for 
series 6 and series 7 (just series 8 became unsupported).

I would try a live iso with a recent kernel.



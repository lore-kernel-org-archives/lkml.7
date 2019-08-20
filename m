Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD1FC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F388522DCC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566309445;
	bh=YtsY2og8yBaA7YM9T/8sS7w0ELILJjUl0401PMRABTo=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=GZa/87dRh6wSIs91VGqbSyYrfR+R1vz7TvG+FYxDVuNa6jhoLI8soswFZr2jtlKo0
	 5xDjXOPktmP0XvLiirKIFcDH9rKB7pE3e+stc/RbGbDOQSgA0pLkl9y9ZFqbvFmnQn
	 2q/039CMvqtUA20uNprLM6EdL/DyarSvGqfpYMGs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbfHTN5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:57:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:49660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730085AbfHTN5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:57:22 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A36FE22CF7;
        Tue, 20 Aug 2019 13:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566309441;
        bh=YtsY2og8yBaA7YM9T/8sS7w0ELILJjUl0401PMRABTo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dBSY1dum7cNiR0HrpujnmA6OGH+C++WMpFVl/Wii4IW+J7Xv/T7xJOmpHj/m5emJY
         lP4QOI60Ej/v1CR8VCw624O+3BKyOdf7NqUVghU/gxCBkqB+3OFlksRGs1WQ+xo094
         PTkaGhBmmJhE3/ruHrPHWJhckH11t3ezvjZAMEHM=
Subject: Re: Kernel 5.2.8 - au0828 - Tuner Is Busy
To:     Nathan Royce <nroycea+kernel@gmail.com>
Cc:     Brad Love <brad@nextdimension.cc>, sean@mess.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <CALaQ_hruPmgnE5yh_MJLLZ_7sPNEnzX8H-WfR=fBvcfEzfG9Fg@mail.gmail.com>
 <e616d881-25e2-c295-2a98-b51c8cbcbc81@nextdimension.cc>
 <CALaQ_hqEZ-kco1esyB4mk0z9Q9Xt1XZsgYKR7gSdF7COERKoOA@mail.gmail.com>
 <eada38a3-258b-52ff-94a7-b8877899267e@kernel.org>
 <da6a1b65-cbe5-4e5e-d61c-43644a23da34@kernel.org>
 <CALaQ_hrPZ7LMBvuHnCLayxHoVFi5U0gtxF-33-ehR=phRs3D5A@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <94bfd12e-e9d4-1e6a-a18f-742e251f5cd9@kernel.org>
Date:   Tue, 20 Aug 2019 07:56:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CALaQ_hrPZ7LMBvuHnCLayxHoVFi5U0gtxF-33-ehR=phRs3D5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/19 12:58 AM, Nathan Royce wrote:
> While your mention of quirks-table.h certainly had possibilities, I'm
> afraid adding the "AU0828_DEVICE(0x05e1, 0x0400, "Hauppauge",
> "Woodbury")," entry for my tuner did not make any difference regarding
> the "Tuner is busy. Error -19" message.
> 
> I don't know if this means anything, but I see
> https://patchwork.kernel.org/patch/97726/ from 2010 which contains
> changes for the 0x0400 model. I guess it never got pulled in.
> 
> Really, it's fine for me just to hang back at v5.1 for a year or two
> until ATSC 3.0 USB tuners come out at a reasonable price.
> 

Hi Nathan,

The tuner busy error code is ENODEV. It appears some devices aren't
created on your system. Would it be possible for you to send me your
config and a complete dmesg.

I am curious if /dev/media0 or /dev/media1 present on your system.
Not having this could explain the ENODEV you are seeing.

thanks,
-- Shuah


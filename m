Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3ADC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 16:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C246D2087E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 16:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389601AbfKGQnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 11:43:22 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:56281 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728965AbfKGQnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 11:43:21 -0500
Received: from [167.98.27.226] (helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iSksQ-0004rW-9m; Thu, 07 Nov 2019 16:43:18 +0000
Message-ID: <c065df06c9e5d351b4a33c473fd397f27680489f.camel@codethink.co.uk>
Subject: Re: [PATCH 4.19 00/93] 4.19.81-stable review
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@denx.de>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Date:   Thu, 07 Nov 2019 16:43:17 +0000
In-Reply-To: <20191106201818.GA105063@kroah.com>
References: <20191027203251.029297948@linuxfoundation.org>
         <20191029162419.cumhku6smn2x2bq4@ucw.cz>
         <20191029180233.GA587491@kroah.com> <20191106185932.GA2183@amd>
         <20191106201818.GA105063@kroah.com>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-11-06 at 21:18 +0100, Greg Kroah-Hartman wrote:
> On Wed, Nov 06, 2019 at 07:59:32PM +0100, Pavel Machek wrote:
[...]
> > I'm confused. You said "by Tue ... 08:27:02 PM UTC". That 8 PM is 20h,
> > but did the release on 10h GMT+1, or 9h UTC -- 9 AM.... so like 11
> > hours early, if I got the timezones right.
> > 
> > Does PM mean something else in the above context?
> 
> Ugh, no, you are right, I was ignoring the PM thing, I thought the -u
> option to date would give me a 24 hour date string, and so I thought
> that was 8:27 in the morning.
> 
> Let me mess around with 'date' to see if I can come up with a better
> string to use here.  I guess:
> 	date --rfc-3339=seconds -u
> would probably be best?

The --rfc-822 option should give you something close to the current
format, but with 24-hour numbering.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom


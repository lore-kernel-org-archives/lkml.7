Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C43EC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 16:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D382084E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 16:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="25p/E+Od"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbfDNQGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 12:06:48 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55940 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfDNQGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 12:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=crywcxngRvw/C/OSCNqTiUL9hFtkwWXtZllpq6kmLrQ=; b=25p/E+OdTk/5eFRAU7aerGvPw+
        4YUXUw5r2mR1Gwsuf5V/xypTzx84MgNQ6lkkNLwRNw2Y0iW/IvfKnB7FlNlO+V74gIIKlFmCfRK+q
        rDe7gOFnWNa8/oPai2o6DuJJi4/HNN5EOYIz8P1UiIC235dawp7SiK6PMInts4MT7NqXy7mBcRQ9C
        ztCOHiQ90TfWkkaPylcaTt5oR2SspF+SeSW7VsNk3z4dQZKcy66ooSixnE08i2+rGMhxjsjfecsIg
        nT+S7xeyHHOkK+21CvtbwZGql5mqB9beRJixDH2Bv2LqQAdwUbtMzQhN8uwt+L+AOfFXCL4hRcB66
        wMawIehg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hFheZ-0000RZ-07; Sun, 14 Apr 2019 16:06:47 +0000
Subject: Re: [PATCH] proc: fix map_files test on F29
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
References: <20190414123612.GB12971@avx2>
 <bb2991f8-323a-c835-0b04-ff8d565df0fa@infradead.org>
 <20190414155848.GA23418@avx2>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8f4ea187-67cc-fa5f-ea6d-5070e18b503c@infradead.org>
Date:   Sun, 14 Apr 2019 09:06:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190414155848.GA23418@avx2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/19 8:58 AM, Alexey Dobriyan wrote:
> On Sun, Apr 14, 2019 at 08:24:53AM -0700, Randy Dunlap wrote:
>> On 4/14/19 5:36 AM, Alexey Dobriyan wrote:
>>> F29 bans mapping first 64KB even for root making test fail.
>>
>> so there is an F29-only patch that prevents that?
>> something that is not in mainline?
> 
> Ehh, no. F29 ships stable kernels actually.
> 
> Test assumes mmap(0, MAP_FIXED) succeeds as root. F29 uses SELinux
> to ban that.
> 

Thanks for the clarification.

-- 
~Randy

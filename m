Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF9EC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 03:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97EAB2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 03:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfKKDJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 22:09:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:55512 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726742AbfKKDJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 22:09:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E95B9B169;
        Mon, 11 Nov 2019 03:09:26 +0000 (UTC)
Subject: Re: [PATCH] arm64: dts: realtek: Add Realtek rtd1619 and mjolnir
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
To:     James Tai <james.tai@realtek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>
References: <43B123F21A8CFE44A9641C099E4196FFCF91BEFA@RTITMBSVM04.realtek.com.tw>
 <25fdd8eb-f1a0-82ae-9c4b-22325b163b0e@suse.de>
 <43B123F21A8CFE44A9641C099E4196FFCF920024@RTITMBSVM04.realtek.com.tw>
 <7a05ac2c-00bc-b2ac-0a33-be0242d33188@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <63d61bcb-fba0-5890-e46b-306c6cd2aa1c@suse.de>
Date:   Mon, 11 Nov 2019 04:09:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <7a05ac2c-00bc-b2ac-0a33-be0242d33188@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 08.11.19 um 18:17 schrieb Andreas Färber:
> Hi James,
> 
> Am 08.11.19 um 16:36 schrieb James Tai:
>>> And double-check whether you actually need <2> - compare rtd129x.dtsi using
>>> <1> because nothing went beyond 32-bit address space. It was a review
>>> request back then. Can RTD1619 have more than 2 GiB RAM, with a second
>>> RAM region in high mem, requiring two cells for memory nodes?
>>>
>> The RTD1619 can support more than 2 GiB RAM.
> 
> How much? More than 0x98000000? The RTD1395 datasheet says up to 4 GB -
> does that mean it continues in a second region beyond 0xffffffff? Those
> locations should be excluded in the soc node ranges (which you sadly
> appear to have dropped in v2).
> 
> I'll try to post a patch for RTD1295 soon to demonstrate, it's just a
> little time-consuming with the 100+ commits on top of linux-next that
> need to be rebased then... RTD1195 may be quicker.

I've finished both and included patches for both in the RTD1395 series
just posted, along with other follow-up cleanups recently discussed.

Thanks,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)

Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF47C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 22:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8619622BEF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 22:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="DMvfoyob"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfGYWmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 18:42:16 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:5476 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfGYWmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 18:42:15 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d3a30470000>; Thu, 25 Jul 2019 15:42:15 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 25 Jul 2019 15:42:15 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 25 Jul 2019 15:42:15 -0700
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 25 Jul
 2019 22:42:12 +0000
Subject: Re: [PATCH 1/1] x86/boot: clear some fields explicitly
To:     "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <john.hubbard@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190724231528.32381-1-jhubbard@nvidia.com>
 <20190724231528.32381-2-jhubbard@nvidia.com>
 <B7DC31CA-E378-445A-A937-1B99490C77B4@zytor.com>
 <alpine.DEB.2.21.1907250848050.1791@nanos.tec.linutronix.de>
 <345add60-de4a-73b1-0445-127738c268b4@nvidia.com>
 <alpine.DEB.2.21.1907252343180.1791@nanos.tec.linutronix.de>
 <3DFA2707-89A6-4DD2-8DFB-0C2D1ABA1B3C@zytor.com>
 <alpine.DEB.2.21.1907252358240.1791@nanos.tec.linutronix.de>
 <e080b061-562f-568f-782d-b014556acdba@zytor.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <ffd7a9b6-8017-2d2c-c4f7-65563094ccd0@nvidia.com>
Date:   Thu, 25 Jul 2019 15:42:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e080b061-562f-568f-782d-b014556acdba@zytor.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564094535; bh=RiX4mAJljdifPyVO6+7OzeB0bHDkhMJBTzl+9eHMa28=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=DMvfoyobPcPVCraAnzpgbILuaU8HrfhcrmSr+V5mGYQrIzrAKIXfIOMSgfVhoZHYE
         6SblvQoZCReGUQYULsfPZLKHFfuyi/5ugQXjrWl4l+y3ipz/+RP9Sc19eDhHR+HvxA
         yH51TjoWkJtDKJ3zOw+hxJf62Nc4MeV5Klh66PK+DLgFQ/Wd1fRfBmn2EtrUEXIwGe
         3tfmQnw1Y+m450pn6vQsmu61cYSvj9LDd/tbjzXDPhe1Z7s/nuSY0tYz/f3Y5wudCl
         wKkdYQiBzdjCs5HsDWL8Q9x5SWD1XwritDhBLJskBIEormYNeFxst0UMwD6v2zqRiL
         R3PyOQK7A4/wg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/19 3:28 PM, H. Peter Anvin wrote:
> On 7/25/19 3:03 PM, Thomas Gleixner wrote:
>> On Thu, 25 Jul 2019, hpa@zytor.com wrote:
>>> On July 25, 2019 2:48:30 PM PDT, Thomas Gleixner <tglx@linutronix.de> wrote:
>>>>
>>>> But seriously I think it's not completely insane what they are doing
>>>> and the table based approach is definitely more readable and maintainable
>>>> than the existing stuff.
>>>
>>> Doing this table based does seem like a good idea.
>>
>> The question is whether we use a 'toclear' table or a 'preserve' table. I'd
>> argue that the 'preserve' approach is saner.
>>
> 
> I agree.
> 

OK, I can polish up something and post it, if you can help me with one more
quick question: how did you want "to preserve" to work?

a) copy out fields to preserve, memset the area to zero, copy back preserved
fields? This seems like it would have the same gcc warnings as we have now,
due to the requirement to memset a range of a struct... 

b) Iterate through all fields, memsetting to zero items that are *not*
marked "to preserve"?

c) Something else? Sorry for the naivete here.  I really did read 
Documentation/x86/boot.rst, honest. :)



thanks,
-- 
John Hubbard
NVIDIA

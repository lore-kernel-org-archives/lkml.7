Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94908C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2741A233A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="U76/hh62"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732149AbfHVJ2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 05:28:39 -0400
Received: from mx-rz-2.rrze.uni-erlangen.de ([131.188.11.21]:56681 "EHLO
        mx-rz-2.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727910AbfHVJ2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 05:28:39 -0400
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 46DfNP0bkFzPjw8;
        Thu, 22 Aug 2019 11:28:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1566466117; bh=d44JDFH3InZPZ5TSzwwuP5MCfcRoiCHapVX0nyM9lxc=;
        h=Subject:To:References:From:Date:In-Reply-To:From:To:CC:Subject;
        b=U76/hh62IFQeDiGCVGKYllk7fmkPE6L0KbW38oOHXSjSRl/mL3FAxlX8MpBzpGhQZ
         QWK0TDLlscYVhM/CPkMAvZr11lwmHsc4GdTz4MBduRsg0ixOlBHK2SeeKljomdfJVP
         3HMqkQCqU5JdJa2gxC+oAsOGyvkk6wCUuxN/+MqgQFy5y0AfWoOI7rvmSENFyxOjYh
         3yY5FUOKBaTJ6VXbHaZadGed5OULAeTQBawRyf7RLZv3DZWZuXwe2GwdPE81EmCBtS
         PTarj+4/iHZifKjPUMW1rh+fYzvzqaN+bLdXvNhz9/4f0z6QnnRT5iVxHIQ5RZH5KH
         3vHJc4YrEknGQ==
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 87.190.42.42
Received: from [10.0.0.25] (unknown [87.190.42.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX1/Sgw5AmoeNTMfU5GW/ZyvHStWkzmJX768=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 46DfNL1YzSzPjhQ;
        Thu, 22 Aug 2019 11:28:34 +0200 (CEST)
Subject: Re: Status of Subsystems
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
References: <2529f953-305f-414b-5969-d03bf20892c4@fau.de>
 <20190820131422.2navbg22etf7krxn@pali>
 <3cf18665-7669-a33c-a718-e0917fa6d1b9@fau.de>
 <20190820171550.GE10232@mit.edu>
From:   Sebastian Duda <sebastian.duda@fau.de>
Message-ID: <475ea59c-8942-c19d-c660-164fcb44d179@fau.de>
Date:   Thu, 22 Aug 2019 11:28:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820171550.GE10232@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ted,

On 20.08.19 19:15, Theodore Y. Ts'o wrote:
> On Tue, Aug 20, 2019 at 03:56:24PM +0200, Sebastian Duda wrote:
>>
>> so the status of the files is inherited from the subsystem `INPUT MULTITOUCH
>> (MT) PROTOCOL`?
>>
>> Is it the same with the subsystem `NOKIA N900 POWER SUPPLY DRIVERS`
>> (respectively `POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS`)?
> 
> Note that the definitions of "subsystems" is not necessarily precise.
> So assuming there is a strict subclassing and inheritance might not be
> a perfect assumption.  There are some files which have no official
> owner, and there are also some files which may be modified by more
> than one subsystem.
> 
> We certainly don't talk about "inheritance" when we talk about
> maintainers and sub-maintainers.  Furthermore, the relationships,
> processes, and workflows between a particular maintainer and their
> submaintainers can be unique to a particular maintainer.
> 
> We define these terms to be convenient for Linux development, and like
> many human institutions, they can be flexible and messy.  The goal was
> *not* define things so it would be convenient for academics writing
> papers --- like insects under glass.
> 
> Cheers,
> 
> 						- Ted
> 

This is completely understood. The purpose of the MAINTAINERS is to
determine the right recipients for a patch and the status should make
expectations on certain code parts clear to contributors and users.

We have seen some incidents of developers sending patches to wrong
recipients, missing recipients or sending patches to orphaned
subsystems. Consequently, some of those patches never make it to a
reviewer or a maintainer (or only after some further adjustments on
the list of recipients).
Whereas that cannot be avoided entirely, as it is a human, social and
flexible process and not everything can be encoded in simple rules,
the maintainer, reviewer, list information in MAINTAINERS and
get_maintainer.pl does a good job at assisting that these hickups
happen rather seldomly.
Similarly, the status can already indicate:
  - to a contributor fixing an issues or providing a patch, that the
code is possibly already orphaned and not maintained, set expectations
on the possible responses, or to focus on other parts of the code.
  - to a user that certain drivers are orphaned and one should not
expect open issues to be quickly fixed by others.

I am simply spending some time to identify the few entries that are
just a bit unclear and I try to improve the file by sending patches
for MAINTAINERS once I understood what it intends to say.

 From what the kernel community has been documenting in MAINTAINERS,
the organization of the Linux development is not messy at all:

The MAINTAINERS files contains 2088 entries [1].
12 of these entries have no status and fall into different categories:
- Additionally Reviewed
   - ALPS PS/2 TOUCHPAD DRIVER
   - NOKIA N900 POWER SUPPLY DRIVERS
   - RENESAS ETHERNET DRIVERS
   - SPMI SUBSYSTEM
   - TI BQ27XXX POWER SUPPLY DRIVER
- Maintained
   - ABI/API
   - ACPI APEI
   - CONTROL GROUP - BLOCK IO CONTROLLER (BLKIO)
   - I2C/SMBUS ISMT DRIVER
   - IFE PROTOCOL
   - MICROCHIP SAMA5D2-COMPATIBLE PIOBU GPIO
- Obsolete
   - NETWORKING [WIRELESS]
     This is an old entry, which can be omitted

The previous mail discussion helped to understand that.

I aim to provide patches for those few entries that can be improved;
it is hopefully not just an academic exercise, but actually serves to
support contributors and users using MAINTAINERS and get_maintainer.pl.

Kind regards
Sebastian

[1] MAINTAINERS without header, count matches of r'\n\n' + 1

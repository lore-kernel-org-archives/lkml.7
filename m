Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379ABCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1133121872
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388488AbfJVImO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 04:42:14 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:44653 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388415AbfJVImO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:42:14 -0400
Received: from [167.98.27.226] (helo=[10.35.5.173])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iMpk4-0003Fl-9q; Tue, 22 Oct 2019 09:42:12 +0100
Subject: Re: [PATCH] RFC: cpu-topology: declare parse_acpi_topology in
 <linux/arch_topology.h>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@lists.codethink.co.uk, linux-kernel@vger.kernel.org
References: <20191021162530.13611-1-ben.dooks@codethink.co.uk>
 <20191021165224.GA8066@bogus>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <89b6bac1-11d5-d7ee-cee4-fb907638b9aa@codethink.co.uk>
Date:   Tue, 22 Oct 2019 09:42:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191021165224.GA8066@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2019 17:52, Sudeep Holla wrote:
> On Mon, Oct 21, 2019 at 05:25:30PM +0100, Ben Dooks (Codethink) wrote:
>> The parse_acpi_topology() is not declared anywhere which
>> causes the following sparse warning:
>>
>> drivers/base/arch_topology.c:522:19: warning: symbol 'parse_acpi_topology' was not declared. Should it be static?
>>
>> RFC: is this the best place to put it?
>>
>> Signed-off-by: Ben Dooks (Codethink) <ben.dooks@codethink.co.uk>
>> ---
>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>   include/linux/arch_topology.h | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
>> index 42f2b5126094..7ae32900d9a2 100644
>> --- a/include/linux/arch_topology.h
>> +++ b/include/linux/arch_topology.h
>> @@ -59,4 +59,6 @@ void remove_cpu_topology(unsigned int cpuid);
>>   void reset_cpu_topology(void);
>>   #endif
>>   
>> +extern int parse_acpi_topology(void);
>> +
> 
> Can we drop extern like other declarations here ?
> Also move this inside CONFIG_GENERIC_ARCH_TOPOLOGY ?
> 
> Please cc Greg with these changes, I will ack and ask Greg to pick up. Thanks.

Ok, thank you for the input.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

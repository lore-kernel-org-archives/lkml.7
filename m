Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C51EC04A6B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 01:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A17420675
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 01:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfEIBsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 21:48:46 -0400
Received: from gateway33.websitewelcome.com ([192.185.146.80]:11720 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725832AbfEIBsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 21:48:46 -0400
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id EC31A22545
        for <linux-kernel@vger.kernel.org>; Wed,  8 May 2019 20:48:44 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id OYAuhxyOt2qH7OYAuhFaDv; Wed, 08 May 2019 20:48:44 -0500
X-Authority-Reason: nr=8
Received: from [189.250.119.7] (port=58166 helo=[192.168.1.76])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hOYAu-004A0S-Hb; Wed, 08 May 2019 20:48:44 -0500
To:     Darren Hart <dvhart@infradead.org>
Cc:     "Lee, Chun-Yi" <jlee@suse.com>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
References: <20190508164934.GA20064@embeddedor> <20190508230645.GB32286@wrath>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gustavo@embeddedor.com; keydata=
 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
 VtSixD1uOgytAP7RWS474w==
Subject: Re: [PATCH] platform/x86: acer-wmi: Mark expected switch
 fall-throughs
Message-ID: <b1869c7f-0927-9a30-a195-a188719c748c@embeddedor.com>
Date:   Wed, 8 May 2019 20:48:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508230645.GB32286@wrath>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.119.7
X-Source-L: No
X-Exim-ID: 1hOYAu-004A0S-Hb
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.119.7]:58166
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Darren,

Please, see my comments below...

On 5/8/19 6:06 PM, Darren Hart wrote:
> On Wed, May 08, 2019 at 11:49:34AM -0500, Gustavo A. R. Silva wrote:
>> In preparation to enabling -Wimplicit-fallthrough, mark switch
>> cases where we are expecting to fall through.
>>
>> This patch fixes the following warnings:
>>
>> drivers/platform/x86/acer-wmi.c: In function ‘set_u32’:
>> drivers/platform/x86/acer-wmi.c:1378:33: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>     if (cap == ACER_CAP_WIRELESS ||
>>                                  ^
>> drivers/platform/x86/acer-wmi.c:1386:3: note: here
>>    case ACER_WMID:
>>    ^~~~
>> drivers/platform/x86/acer-wmi.c:1393:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>     else if (wmi_has_guid(WMID_GUID2))
>>             ^
>> drivers/platform/x86/acer-wmi.c:1395:3: note: here
>>    default:
>>    ^~~~~~~
>> drivers/platform/x86/acer-wmi.c: In function ‘get_u32’:
>> drivers/platform/x86/acer-wmi.c:1340:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>    if (cap == ACER_CAP_MAILLED) {
>>       ^
>> drivers/platform/x86/acer-wmi.c:1344:2: note: here
>>   case ACER_WMID:
>>   ^~~~
>> drivers/platform/x86/acer-wmi.c: In function ‘WMID_get_u32’:
>> drivers/platform/x86/acer-wmi.c:1013:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>    if (quirks->mailled == 1) {
>>       ^
>> drivers/platform/x86/acer-wmi.c:1018:2: note: here
>>   default:
>>   ^~~~~~~
>>
>> Warning level 3 was used: -Wimplicit-fallthrough=3
>>
>> This patch is part of the ongoing efforts to enable
>> -Wimplicit-fallthrough.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>  drivers/platform/x86/acer-wmi.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
>> index fcfeadd1301f..bd87f9037f95 100644
>> --- a/drivers/platform/x86/acer-wmi.c
>> +++ b/drivers/platform/x86/acer-wmi.c
>> @@ -1015,6 +1015,7 @@ static acpi_status WMID_get_u32(u32 *value, u32 cap)
>>  			*value = tmp & 0x1;
>>  			return 0;
>>  		}
>> +		/* fall through */
>>  	default:
>>  		return AE_ERROR;
>>  	}
>> @@ -1341,6 +1342,7 @@ static acpi_status get_u32(u32 *value, u32 cap)
>>  			status = AMW0_get_u32(value, cap);
>>  			break;
>>  		}
>> +		/* fall through */
> 
> This doesn't strike me as obviously the right thing to do here. If the interface
> type is AMW0_V2, why is it the right thing to do to use WMID_get_u32 if the cap
> isn't ACER_CAP_MAILLED?
> 
In commit commit 745a5d2126926808295742932d0e36d485efa485 case ACER_AMW0_V2 falls
through to case ACER_WMID deliberately in function set_u32(), without reporting
any error or warning. So, I thought it was fair to assume that the fall-through
is intentional in both functions get_u32() and set_u32(). Otherwise I would
expect to see a message indicating that interface ACER_AMW0_V2 is unavailable
in function set_u32().

This is also complemented by the following...

>>  	case ACER_WMID:
>>  		status = WMID_get_u32(value, cap);
>>  		break;
>> @@ -1383,6 +1385,7 @@ static acpi_status set_u32(u32 value, u32 cap)
>>  
>>  				return AMW0_set_u32(value, cap);
>>  			}
>> +			/* fall through */
> 
> Similarly here.
> 
> Are we documenting intended behavior, or covering up a bug.
> 

Commit 5c742b45dd5fbbb6cf74d3378341704f4b23c5e8 mentions that "This was fixed
in acer_acpi some time ago, but I forgot to port the patch over to acer-wmi
when it was merged." Notice that this driver (acer-wmi) is based on the
no-longer existing acer_acpi driver. But after googling for a while I could
found the fix the original author talks about:

https://repo.or.cz/acer_acpi.git/commitdiff/74c08a38875ffa9989c3100947650ac8a388c189

So, the fix is indeed similar and contains the same fall-throughs from case
ACER_AMW0_V2 to case ACER_WMID in both functions get_u32() and set_u32().

Thanks
--
Gustavo






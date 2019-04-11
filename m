Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3B9C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A492083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C97W+qdw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfDKPhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:37:21 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36928 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbfDKPhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 11:37:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oOURSwCQzYHjCoWuviV6JN5WKBACWN2+BGUQwrDDGG0=; b=C97W+qdwrd8dhyPJgG/FxIeLYe
        CQG3TprFv+xhLUyhGfb/srjOOgEoVfkPG9RCTKEFufhJcmGtygI4mdM2T9+NcQnrxOJ1bvOx34A41
        ccUwv3WnXeENs7OJKxEzi3PGjH0xL4Gyy4dropbDug2ceUy6GbZpQiL1mOvMuIR93ON8nv1Ofp74t
        cGUS3k35OuZkrx0uY++e1WL24UCe2iDrBkdo49b0orF0Dt1ffTrDTejzg9bBR+6NLMHBL5o4EWNaY
        slsSoBg8NEven8+M9Lqq4TTot9X7lYbx6xWJSAzcfr0I4fS7K6exwJueCHpOGxJxyyk14B1MFGOmX
        xOfeKVxg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEblP-0003XR-Ep; Thu, 11 Apr 2019 15:37:19 +0000
Subject: Re: [GIT PULL] <global> global spelling corrections for v5.1.0-rc5
To:     Kenny Van de Maele <kenny.vandemaele@inuits.eu>,
        torvalds@linux-foundation.org
Cc:     torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <0b6539fe5b2741b1327119236ea0e401d02003e6.camel@inuits.eu>
 <0885bbf9-ccb1-280e-dde1-ffa40282df09@infradead.org>
 <a07c9008ece0a7584cd1e1762d57673ee3de8fed.camel@inuits.eu>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b75168c1-c99e-abd8-fc22-c26c7927d9ce@infradead.org>
Date:   Thu, 11 Apr 2019 08:37:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <a07c9008ece0a7584cd1e1762d57673ee3de8fed.camel@inuits.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/19 8:00 AM, Kenny Van de Maele wrote:
> On Thu, 2019-04-11 at 07:58 -0700, Randy Dunlap wrote:
>> On 4/11/19 2:12 AM, Kenny Van de Maele wrote:
>>> are available in the Git repository at:
>>>
>>>   git://github.com/vdmkenny/linux-spelling-fix.git tags/common-
>>> spelling-fixes-5.1.0-rc5
>>>
>>> for you to fetch changes up to
>>> 6ee0055f3414a64133228e82004ea60d0e659d6d:
>>>
>>>   fix common spelling mistakes (2019-04-11 10:22:24 +0200)
>>>
>>> ----------------------------------------------------------------
>>> This PR contains a set of global spelling fixes of commonly miss-
>>> spelled
>>
>> misspelled
> 
> Bad joke :)
> 
>>
>>
>> Is there a way for me to review the diff on github?
> 
> https://github.com/vdmkenny/linux-spelling-fix/commit/6ee0055f3414a64133228e82004ea60d0e659d6d
> 
>>
>> thanks.
>>
>>
>>> words. Mostly documentation and comments were impacted, but a few
>>> lines
>>> of code were affected as well.
>>>
>>> ----------------------------------------------------------------
>>> Kenny Van de Maele (1):
>>>       fix common spelling mistakes
>>
>>


recheck this one also:

 drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h
@@ -204,7 +204,7 @@ enum {
 * notification the status is always success. There is no start/end fragment
 * notification for monolithic events.
 *
- * @TE_V2_DEFAULT_POLICY: independent, social, present, unoticable
+ * @TE_V2_DEFAULT_POLICY: independent, social, present, unoticeable
 * @TE_V2_NOTIF_HOST_EVENT_START: request/receive notification on event start
 * @TE_V2_NOTIF_HOST_EVENT_END:request/receive notification on event end
 * @TE_V2_NOTIF_INTERNAL_EVENT_START: internal FW use



-- 
~Randy

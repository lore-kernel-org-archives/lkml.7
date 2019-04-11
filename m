Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8C4C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 961CA2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Oxbb4eQf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfDKPjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:39:36 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36996 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfDKPjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 11:39:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+5zfJBqxbiTZB9u+oKxzByfv5rPAjRhODA7C7rJ4j/c=; b=Oxbb4eQfAe5XClqKOTdXS5zOrw
        dYnp/3g+UGFdOSVUL6IpOWypW6X8E/SKQ5RM9cxGGIpIqmfw/L8cEcX80wpU+29jOo8vf/02w/ijy
        gYlbXPBJDkWQGNA72NcNjCPXdcxFRvBOO3L5Mwbiu6pbXbeAszT609FzuYnALFAOONR1dg8stnkIX
        RwpiZxv50I0OGvcssT24drCreEEqxswItAk8s/zpKJipYwWR6UFe92QPvA/x7LVva4rPTmLSPHp2a
        udsiPz6hdAuc2iTSWtRy07LnEcMEfxXXPam8CBfdeauzGArKXaz/rc0iwCLHuaaHORdi7w/UlZAaB
        T/5S8dlw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEbna-0003kT-PH; Thu, 11 Apr 2019 15:39:35 +0000
Subject: Re: [GIT PULL] <global> global spelling corrections for v5.1.0-rc5
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Kenny Van de Maele <kenny.vandemaele@inuits.eu>,
        torvalds@linux-foundation.org
Cc:     torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <0b6539fe5b2741b1327119236ea0e401d02003e6.camel@inuits.eu>
 <0885bbf9-ccb1-280e-dde1-ffa40282df09@infradead.org>
Message-ID: <1a423b4e-16e7-8884-54ef-50833d472ca4@infradead.org>
Date:   Thu, 11 Apr 2019 08:39:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <0885bbf9-ccb1-280e-dde1-ffa40282df09@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/19 7:58 AM, Randy Dunlap wrote:
> On 4/11/19 2:12 AM, Kenny Van de Maele wrote:
>> are available in the Git repository at:
>>
>>   git://github.com/vdmkenny/linux-spelling-fix.git tags/common-
>> spelling-fixes-5.1.0-rc5
>>
>> for you to fetch changes up to
>> 6ee0055f3414a64133228e82004ea60d0e659d6d:
>>
>>   fix common spelling mistakes (2019-04-11 10:22:24 +0200)
>>
>> ----------------------------------------------------------------
>> This PR contains a set of global spelling fixes of commonly miss-
>> spelled
> 
> misspelled
> 
> 
> Is there a way for me to review the diff on github?
> 
> thanks.
> 
> 
>> words. Mostly documentation and comments were impacted, but a few lines
>> of code were affected as well.
>>
>> ----------------------------------------------------------------
>> Kenny Van de Maele (1):
>>       fix common spelling mistakes
> 
> 


recheck:

drivers/net/wireless/ralink/rt2x00/rt2x00link.c
@@ -203,7 +203,7 @@ void rt2x00link_update_stats(struct rt2x00_dev *rt2x00dev,
		return;

	/*
-	 * Frame was received successfully since non-succesfull
+	 * Frame was received successfully since non-successfull
	 * frames would have been dropped by the hardware.
	 */
	qual->rx_success++;


-- 
~Randy

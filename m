Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB977C432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 20:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A017C2071E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 20:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cndXVvKy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfLBUY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 15:24:58 -0500
Received: from linux.microsoft.com ([13.77.154.182]:60272 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbfLBUY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 15:24:58 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9574020B7185;
        Mon,  2 Dec 2019 12:24:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9574020B7185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1575318297;
        bh=bOCSq0wgnyPh/YMpBDbZgZBHSNjtFB5ruPODpAQ5zfM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cndXVvKyzotxrBEJ3AcVcHU8063YDBfogOEV+3cuAPiSNdNDSG5VDppRfQx72p74U
         OepRpddT3jXJHPzFAGR9Y5NZdlNvlmn2hmhBlVtvdfTjT58mYoN0eQOZe1tY46beon
         K8+3GrH8E5606oJc9omTbSRl69GICRLMCbXSWigU=
Subject: Re: [PATCH v0 1/2] IMA: Defined queue functions
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, Janne Karhunen <janne.karhunen@gmail.com>
References: <20191127025212.3077-1-nramas@linux.microsoft.com>
 <20191127025212.3077-2-nramas@linux.microsoft.com>
 <1574887137.4793.346.camel@linux.ibm.com>
 <ea2fafb8-a97f-5365-debd-d90143e549bf@linux.microsoft.com>
 <1575309622.4793.413.camel@linux.ibm.com>
 <6ec16f9d-b4f4-bb85-3496-be110fa68f6b@linux.microsoft.com>
 <1575313891.4793.423.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <d7632326-05be-d116-8b60-3b131495acf5@linux.microsoft.com>
Date:   Mon, 2 Dec 2019 12:24:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <1575313891.4793.423.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/19 11:11 AM, Mimi Zohar wrote:

>> How can I have ima_update_policy() called before a custom policy is loaded?
> 
> Oops, you're right.  My concern was ima_init_policy(), but it calls
> ima_update_policy_flag() directly.
> 
> Mimi

Thanks Mimi.

Please let me know if you have any concerns with respect to the deferred 
key processing implementation in this patch set.

Also, if you think Janne Karhunen work queue implementation can be used 
for deferred key measurement also, please post the patch set. I'll take 
a look.

thanks,
  -lakshmi



Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C0ECA9ECE
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 15:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6816D2087E
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 15:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Fa/YkIQw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfJaPJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 11:09:46 -0400
Received: from linux.microsoft.com ([13.77.154.182]:43536 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfJaPJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 11:09:45 -0400
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id F0A4D20B7192;
        Thu, 31 Oct 2019 08:09:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F0A4D20B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1572534585;
        bh=+nkYwFVY0vK5WMFbXDaAwGnWgtkOJOw+VlYbJtk1B1c=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Fa/YkIQwABSG9ZpAEDRzY7bS3wmtN9uKqqU57qXN1Tk0/AW5M+PzXni7A29Jw8QG4
         Dvizn8FTi+WdLFwimQL0g7PYHv73IjaAP/y3S2H4jnbQSYPQkEhqcZzRViiZMmAlhw
         aVLSdIhyY0exA1JaVlDrGXUh0QQkhnCnNptzxYcQ=
Subject: Re: [PATCH v3 2/9] KEYS: Defined functions to queue and dequeue keys
 for measurement
To:     Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Cc:     prsriva@linux.microsoft.com
References: <20191031011910.2574-1-nramas@linux.microsoft.com>
 <20191031011910.2574-3-nramas@linux.microsoft.com>
 <1572523841.5028.44.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <7ab62644-0465-ecaf-26e1-852d4ac66d94@linux.microsoft.com>
Date:   Thu, 31 Oct 2019 08:09:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1572523841.5028.44.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/19 5:10 AM, Mimi Zohar wrote:

> On Wed, 2019-10-30 at 18:19 -0700, Lakshmi Ramasubramanian wrote:
>> Key measurements cannot be done if the IMA hook to measure keys is
>> called before IMA is initialized. Key measurement needs to be deferred
>> if IMA is not yet initialized. Queued keys need to be processed when
>> IMA initialization is completed.
>>
>> This patch defines functions to queue and de-queue keys for measurement.
> 
> I would defer this patch until later in the patch set, after having
> the basic measuring of keys in place.

Ok - I'll move this this patch.

thanks,
  -lakshmi




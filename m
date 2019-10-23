Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6016CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 14:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE3F2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 14:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="X4+56uDi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392382AbfJWOt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 10:49:59 -0400
Received: from linux.microsoft.com ([13.77.154.182]:38078 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfJWOt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 10:49:59 -0400
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2CE94200871E;
        Wed, 23 Oct 2019 07:49:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2CE94200871E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1571842198;
        bh=+C5+bhNnD7pzxcmG6vCE01JLf4+lf37TlNKFCBVtvdQ=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=X4+56uDiAnB6BoGJ5irwf3LQa0b/HK4HKfD0vjgpgqiOPG+NfPlrpyHXT0xZ1F2z3
         jSwjVV1/eFGJKz9lLYBxju5qyeAMp/twtGkxYeTkoTmPBjyoxQdY3Z625iUifj4dh6
         8v7iI8EwzlyhxqqKyBPFuo8MzAmimeyJgLowHJFI=
Subject: Re: [PATCH v1 3/6] KEYS: ima hook to measure builtin_trusted_keys
To:     Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com,
        casey@schaufler-ca.com, sashal@kernel.org,
        jamorris@linux.microsoft.com,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
References: <20191023001818.3684-1-nramas@linux.microsoft.com>
 <20191023001818.3684-4-nramas@linux.microsoft.com>
 <1571836931.5104.95.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <6a3f2efa-fc05-7bfd-368a-910dd4525f4c@linux.microsoft.com>
Date:   Wed, 23 Oct 2019 07:49:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1571836931.5104.95.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/19 6:22 AM, Mimi Zohar wrote:

Thanks for reviewing the changes Mimi.
I'll address your comments and post an updated patch set shortly.

>> Add a new ima hook to measure keys added to builtin_trusted_keys
>> keyring.
> 
> There is no IMA hook in this patch.
> 

>> +			else if (strcmp(args[0].from,
>> +					"BUILTIN_TRUSTED_KEYS") == 0)
>> +				entry->func = BUILTIN_TRUSTED_KEYS;
>>   			else
>>   				result = -EINVAL;
>>   			if (!result)
> 
> Any new options need to be displayed as well.

Not that I can think of. Please correct me if I am wrong.

Thanks,
  -lakshmi


Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CFDC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 00:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D227920885
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 00:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sYQwijFj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfKUACn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 19:02:43 -0500
Received: from linux.microsoft.com ([13.77.154.182]:60960 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfKUACn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 19:02:43 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3CFAA20B7185;
        Wed, 20 Nov 2019 16:02:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3CFAA20B7185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1574294562;
        bh=Nx7FpAeREdfQqZZz2uLZtOiIJYjK6fek5qV+toHpBaI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=sYQwijFj6MBhFH/urC2eZ2vc15KxWA4yf3qIPx8OQIrpGoSj2oRh/VJuzflpff9sx
         Ai2tcsobEKccZSRUJRVLLpf0HdjVsJ1SmgWT8kpytCUcogKsVZKKskzOzwK4PSkzT6
         F0iLGnTJgiMGLT2QRjPFeoAVyKUEeJmK1Y2TdfCw=
Subject: Re: [PATCH v8 4/5] IMA: Add support to limit measuring keys
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
References: <20191118223818.3353-1-nramas@linux.microsoft.com>
 <20191118223818.3353-5-nramas@linux.microsoft.com>
 <1574291957.4793.144.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <fef8fc67-643d-e579-9628-6516fd02b4db@linux.microsoft.com>
Date:   Wed, 20 Nov 2019 16:03:05 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1574291957.4793.144.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/2019 3:19 PM, Mimi Zohar wrote:

Hi Mimi,

>> The above can be used to correlate the key measurement IMA entry,
>> ima-sig and ima-modsig entries using the same key.
> 
> True, but associating the public key measurement with the file
> signature requires information from the certificate (e.g. issuer,
> serial number, and/or subject, subject keyid).
> 
> For a regression test, it would be nice if the key measurement,
> itself, contained everything needed in order to validate the file
> signatures in the measurement list.

I am just trying to understand your asks - Please clarify:

1, My change includes only the public key and not the entire certificate 
information in the measured buffer.

Should I update this current patch set to measure the entire cert. Or, 
can that be done as a separate patch set?

2, Should a regression test be part of this patch set for the key 
measurement changes to be accepted?

thanks,
  -lakshmi

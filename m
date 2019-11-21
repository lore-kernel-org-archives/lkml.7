Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03735C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 17:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF05A206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 17:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VGaFauFc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfKURQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 12:16:28 -0500
Received: from linux.microsoft.com ([13.77.154.182]:34234 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfKURQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 12:16:28 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id B562520B7185;
        Thu, 21 Nov 2019 09:16:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B562520B7185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1574356587;
        bh=qat8oBu3lTpPZCIADeKrXEqOEeEglX6sCbk/08Ye0xY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VGaFauFcEmscLAjXlvBoPG6FNb9b6UeymvFXF+EQpSkm8a204R9K5/dRwB8i7ByXO
         IPsj4qI/xFmN+MsLo+Z3rItTS07qprkf6SicjtbaE0kiOckYtSZ20ADfNFi8GRuDnG
         Y/loVCfZiNEAxN1oRlrt1AB467Af9y5pmeeAPo1Y=
Subject: Re: [PATCH v8 2/5] IMA: Define an IMA hook to measure keys
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Eric Snowberg <eric.snowberg@oracle.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
References: <20191118223818.3353-1-nramas@linux.microsoft.com>
 <20191118223818.3353-3-nramas@linux.microsoft.com>
 <ED63593E-BE9B-40B7-B7FD-9DE772DC2EB1@oracle.com>
 <98eeec95-cc19-2900-b96e-eadaac1b4a68@linux.microsoft.com>
 <1574299330.4793.158.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <2dfe3a9b-8a24-5da4-f889-9ac3db44c50b@linux.microsoft.com>
Date:   Thu, 21 Nov 2019 09:16:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1574299330.4793.158.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/19 5:22 PM, Mimi Zohar wrote:

>> I had the following check in process_buffer_measurement() as part of my
>> patch, but removed it since it is being upstreamed separately (by Mimi)
>>
>>    if (!ima_policy_flag)
>>    	return;
> 
> Did you post it as a separate patch?  I can't seem to find it.
> 
> Mimi
> 

I have sent a separate patch with just this change (to check 
ima_policy_flag in process_buffer_measurement()).

thanks,
  -lakshmi

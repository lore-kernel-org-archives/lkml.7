Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C47EC2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 20:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25172082E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 20:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="P0+F991o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfLTUug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 15:50:36 -0500
Received: from linux.microsoft.com ([13.77.154.182]:45136 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbfLTUuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 15:50:35 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id CCD0120106BA;
        Fri, 20 Dec 2019 12:50:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CCD0120106BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1576875035;
        bh=nCXI723Paiou2qhM6Iep4RO6p6kZcLH60+OZE/A0Wj0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=P0+F991oIoc1uIRq2J/OZoa8NNdiJNVhpC3IYKHSoWeKEVzWoyGJpgn/IA0hfphjZ
         nCpVTpTjTT/XO4EE8LWgHUL/5WmRvhOHCWBTF224K04MJRhQJqoH9udQdNhI5h6Cbx
         THFVWApuNdTRqU0hXUxLvUP+mtueX23TYjvW8Ibo=
Subject: Re: [PATCH v5 0/2] IMA: Deferred measurement of keys
To:     Mimi Zohar <zohar@linux.ibm.com>,
        James.Bottomley@HansenPartnership.com,
        linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
References: <20191218164434.2877-1-nramas@linux.microsoft.com>
 <1576868506.5241.65.camel@linux.ibm.com>
 <589b893b-52e4-783c-0f32-608ed1cfd7f9@linux.microsoft.com>
 <1576870595.5241.83.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <9f346e6d-04f2-b8cd-bf67-f1cee59d9630@linux.microsoft.com>
Date:   Fri, 20 Dec 2019 12:50:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1576870595.5241.83.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/19 11:36 AM, Mimi Zohar wrote:

>>
>> Shall I create a new patch set to address that and have that be reviewed
>> independent of this patch set?
> 
> If it is just a single additional patch, feel free to post it without
> a cover letter.

Sure

>>
>> Like you'd suggested earlier, we can wait for a certain time, after IMA
>> is initialized, and free the queue if a custom policy was not loaded.
> 
> Different types of systems vary in boot time, but perhaps a certain
> amount of time after IMA is initialized would be consistent.  This
> would need to work for IoT devices/sensors to servers.
> 
> Mimi
> 

Yes - I agree.

thanks,
  -lakshmi

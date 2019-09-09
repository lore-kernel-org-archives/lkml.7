Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A766CC4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 23:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C1BE20863
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 23:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389088AbfIIXTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 19:19:00 -0400
Received: from linux.microsoft.com ([13.77.154.182]:50680 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfIIXTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 19:19:00 -0400
Received: from [10.200.156.146] (unknown [167.220.2.18])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5FAD420B7186;
        Mon,  9 Sep 2019 16:18:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5FAD420B7186
Subject: Re: [RFC][PATCH 1/1] Carry ima measurement log for arm64 via
 kexec_file_load
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-integrity@vger.kernel.org, jmorris@namei.org
References: <20190829200532.13545-1-prsriva@linux.microsoft.com>
 <20190829200532.13545-2-prsriva@linux.microsoft.com>
 <87r252kxc8.fsf@morokweng.localdomain>
 <0c7453d4-620d-2d98-3fda-f902b18da535@linux.microsoft.com>
 <1567985476.4614.224.camel@linux.ibm.com>
From:   prsriva <prsriva@linux.microsoft.com>
Message-ID: <cb7840de-b26b-7e56-9d9a-dac5ccd8692f@linux.microsoft.com>
Date:   Mon, 9 Sep 2019 16:18:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1567985476.4614.224.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/8/19 4:31 PM, Mimi Zohar wrote:
> Hi Prakhar,
> "Carrying over the ima log during kexec_file_load" was originally
> posted on 5/10 and 5/31 without a cover letter. On 8/29 it was
> reposted as an RFC with a cover letter.  The cover letter was v1, but
> the patch itself was not.  In the future, please use the "git format-
> patch "-subject-prefix" option to add the version number to both the
> cover letter and the patches.
>
> The comments you received were based on the 8/29 version.  I haven't
> seen anything after that.
>
> Mimi

Added the correct subject prefix, resent patches.

I resent the patches sent at 5/31, since i had no response.

v1 version addresses the comments in the RFC patch.

I have cc-ed you to the email, hopefully its not missed again.

Thankyou for pointing it out.

Thanks,

Prakhar Srivastava


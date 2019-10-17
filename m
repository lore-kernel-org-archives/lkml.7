Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53871ECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 18:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E2721848
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 18:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571335608;
	bh=prHm7NxUgWw6gtKYHx0XzUtdQBFWGrcBtG2xHXdLPQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1uRJquzlZXXtaDTsxQnwG6+FowtsKvsF4k7Q8tQn3qjaTknJYllJ+QvcVbtNGtB6T
	 Sre8BSmkQxXe70lv7cDiBloEZ5xg8eYzOVCi2+7OXLJF6s8VSJcqxhiW7lQWrwI10f
	 DjgwJy6W/1MO7ZaQcxwwFAtVcPrxSUv974CoNcY4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395231AbfJQSGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 14:06:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:54524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388188AbfJQSGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 14:06:47 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0627321835;
        Thu, 17 Oct 2019 18:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571335606;
        bh=prHm7NxUgWw6gtKYHx0XzUtdQBFWGrcBtG2xHXdLPQM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K873WHE6VcGhA8uNvdeW9swkfr+2AlTEaX+xQxVuKi1yemH8bI9ac1G5vErI/GOgs
         O2Hy+8/NWM03Iat1y2dlU6racEQbU0eL9CyiltxPgRdio1hRk9dzB1DLlYROnoYscS
         xm55KPRgKpoWHMl7E9rQ7rrPfJ/JIPgr28TP39bU=
Date:   Thu, 17 Oct 2019 14:06:44 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Pavel Tatashin <pasha.tatashin@soleen.com>, jmorris@namei.org,
        peterhuewe@gmx.de, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@microsoft.com, thiruan@microsoft.com,
        bryankel@microsoft.com, tee-dev@lists.linaro.org,
        ilias.apalodimas@linaro.org, sumit.garg@linaro.org,
        rdunlap@infradead.org
Subject: Re: [PATCH v3] tpm/tpm_ftpm_tee: add shutdown call back
Message-ID: <20191017180644.GW31224@sasha-vm>
References: <20191016163114.985542-1-pasha.tatashin@soleen.com>
 <20191017162251.GB6667@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191017162251.GB6667@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 07:22:51PM +0300, Jarkko Sakkinen wrote:
>On Wed, Oct 16, 2019 at 12:31:14PM -0400, Pavel Tatashin wrote:
>> Add shutdown call back to close existing session with fTPM TA
>> to support kexec scenario.
>>
>> Add parentheses to function names in comments as specified in kdoc.
>>
>> Signed-off-by: Thirupathaiah Annapureddy <thiruan@microsoft.com>
>> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
>
>LGTM
>
>Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>
>I have no means to test this though. It still needs a tested-by.

We've been running this patch internally for the past few months,
testing kexec scenarios, so I guess it could have mine :)

Tested-by: Sasha Levin <sashal@kernel.org>

-- 
Thanks,
Sasha

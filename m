Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A65C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 21:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9516120675
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 21:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skogtun.org header.i=@skogtun.org header.b="YaqSJ+eL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfDRVtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 17:49:39 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:50591 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfDRVtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 17:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=skogtun.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=1mfHy1hHSXj1pNqlvRLK/Ct3VBKFV9sGfyJOz5wACnM=;
        b=YaqSJ+eLkOMmXJeEg9nYk7vf2yhkITXj5w77s8iMBBwHYYdTMO3XBN8pEeESy6B5pZdcSpqyXd1c24XLU7mdFXbk1FG9QGtnTWlKzMp+3t1/Nq3D+BfDxWR1v0pQ80UQMnMy+2yTcR155DQjqLFKu/dPyigcxDve1hjTHrXLf9Xe0Fv1pBW+CKtwAccwCttmNE0kytFngxWB+7/kHGfCF4CYZe39pmKdZRLxIKV4q/jzJd2IYSW/iAb4oshb7Gg2dOHkWVAvxugGYasUT/GOcAfkQKJFvMVRJRFSyuQszyLvUIsxAEq/Z/YZSXG0sxrl759+YaG/zpAbMBLl5MLoOg==;
Received: from [2a01:79c:cebe:b88c:caff:28ff:fe94:90a0] (port=53494)
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <harald@skogtun.org>)
        id 1hHEuW-0004wc-A7; Thu, 18 Apr 2019 23:49:36 +0200
Subject: Re: [REGRESSION 5.0.x] Windows XP broken on KVM
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Takashi Iwai <tiwai@suse.de>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org
References: <s5hy347pxtf.wl-tiwai@suse.de> <20190418075328.GA19532@kroah.com>
From:   Harald Arnesen <harald@skogtun.org>
Message-ID: <110c1a56-da41-25b6-7901-ee1c5a90f937@skogtun.org>
Date:   Thu, 18 Apr 2019 23:49:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418075328.GA19532@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: nb-NO
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman [18.04.2019 09:53]:

> On Thu, Apr 18, 2019 at 09:38:52AM +0200, Takashi Iwai wrote:
>> Hi,
>> 
>> we've got a regression report on the recent 5.0.x kernel, starting
>> from 5.0.6, where Windows XP can't boot on KVM any longer.
>> 
>> The culprit seems to be the patch
>>    KVM: x86: update %rip after emulating IO
>> with the upstream commit 45def77ebf79e2e8942b89ed79294d97ce914fa0.
>> Reverting this alone fixed the problem.
>> 
>> The report is found at openSUSE bugzilla:
>>   https://bugzilla.suse.com/show_bug.cgi?id=1132694
>> 
>> Is there already a followup fix?  If not, we need to revert it from
>> stable, at least.
> 
> Is this also a problem in 5.1-rc5?

My previously installed Windows XP boots and runs fine in 5.1-rc5.
-- 
Hilsen Harald

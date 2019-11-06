Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E716C5DF65
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 15:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B09C21848
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 15:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573053850;
	bh=VUTzf4qtGo6qJYOG+eaBMUYtLeYz7gpHCSj8+XTZTCU=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=IStlibgahwLMZKXEd39QTAZtTjQYUWsqoKmUuLjdDiF47ZgqFLCx/RsR1Z5fUxNti
	 dNussFT2ByKRo6y6PI8vSzBCby32nMxiCw1PMerW9cuw6zFfYnUxMi2l9P1IKqtCMT
	 45/8w6EjgHX8gClKMWB1JIjy+BtLGbV1QT1gDWfE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732121AbfKFPYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 10:24:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:46916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727548AbfKFPYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 10:24:09 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D86BB2173B;
        Wed,  6 Nov 2019 15:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573053848;
        bh=VUTzf4qtGo6qJYOG+eaBMUYtLeYz7gpHCSj8+XTZTCU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gRVQCCRyiU0nJlcsa8lE0AnkSUILMTNdkIxyifK2A65g3lq7XFcnQ3GjWzW0xg0ox
         S1fKrcrLXZ5NqyulmAUH3Z7Z7EbtnhcwZi2ZsZMVz/BdaMkBmM2BfeBKt46VGlom0S
         drYbYQRVB/V4XDi7FlV/s9VxzQRuXywJQTrUG21Q=
Subject: Re: [PATCHv3 0/4] Update cpupower and make it more accurate
To:     Thomas Renninger <trenn@suse.de>,
        "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pu Wen <puwen@hygon.com>, Borislav Petkov <bp@suse.de>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>, shuah <shuah@kernel.org>
References: <cover.1572972259.git.Janakarajan.Natarajan@amd.com>
 <2247236.ip1NsGyfdn@skinner.arch.suse.de>
From:   shuah <shuah@kernel.org>
Message-ID: <dee1383b-850c-122b-7466-0b705a213853@kernel.org>
Date:   Wed, 6 Nov 2019 08:23:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <2247236.ip1NsGyfdn@skinner.arch.suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/19 4:32 AM, Thomas Renninger wrote:
> Thanks Natarajan,
> 
> Shuah: I would be ok to queue this up...
> 
> Thanks,
> 
>     Thomas
> 
> 
> 


Thomas,

Already queued up in

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?h=cpupower

Will send pull request o Rafael today to get these into pm tree.

thanks,
-- Shuah

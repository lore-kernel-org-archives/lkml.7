Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67ACAC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33ABB20674
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FrIDlC46";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="n9jhW7Nu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732882AbfDQQ6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:58:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38598 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729512AbfDQQ6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 12:58:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 768E360779; Wed, 17 Apr 2019 16:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555520290;
        bh=PEWeQz2FscZAVdhG0YIbtiOsZnfi+COBFLh4acycfPQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FrIDlC46NNLx+Lwwkq8y5L3df9oC3fqaY8yoVnFFCJ8fStLq6Bt01g1FDWF6sHukq
         KQM28qaI8lsScOohc14706wqU+GZsnTUP19mM9e4hh0Ae+4eIUdA+hfdVH5QVW4bbV
         YTRnyL2HokXW65Cb+/xRtFnOD+kGUjsZjHuY8QMw=
Received: from [192.168.1.9] (unknown [171.49.248.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: shajit@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1844060392;
        Wed, 17 Apr 2019 16:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555520289;
        bh=PEWeQz2FscZAVdhG0YIbtiOsZnfi+COBFLh4acycfPQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=n9jhW7Nu2dLHUg5248XWjYYZv4RNCzwult4Ac3i29tcVsaUZc7NoitsUiCW+xThj2
         ditM6CpCbM/qkNhLVTIATkMN4tajcuLaw2kvY/kRmD4WrWIihUo8RAQQuzuft7OlPR
         F/QGTgy+j9GhQfersMMns4jk3QOG5UXsADLgN6Qw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1844060392
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=shajit@codeaurora.org
Subject: Re: fs/proc: Crash observed in next_tgid (fs/proc/base.c)
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <b5b9df7b-324c-8286-3a7c-e7812511772d@codeaurora.org>
 <4cb1d095-54a1-a7aa-762f-df77dddc4621@free.fr>
From:   Jitendra Sharma <shajit@codeaurora.org>
Message-ID: <e347f9fa-824d-bfe6-055c-1582c42d76e8@codeaurora.org>
Date:   Wed, 17 Apr 2019 22:28:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4cb1d095-54a1-a7aa-762f-df77dddc4621@free.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Marc and Kees for replying.
Answer to your queries:
Kernel version: 4.14.83
Test case: Not some specific test case. Issue reproduced while doing 
monkey testing for very long hours.

Thanks,
Jitendra

On 4/17/2019 5:41 PM, Marc Gonzalez wrote:
> On 15/04/2019 14:58, Jitendra Sharma wrote:
> 
>> We are observing one kernel crash in next_tgid function through
>> getdents64 path. Call stack is as shown below:
> 
> It might help if you specify the exact kernel version you are discussing,
> as in which tag or commit hash you are running.
> 
> Also, what are you doing to trigger the issue?
> 
> Regards.
> 

-- 

QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC31C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B975620857
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554749513;
	bh=i2BJDOSY0b5UXb7M++mJ77uoRA2A/8QacAzIny/TqpM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=kqOvqzUQ28cL9ALnsyhKQDuv4ABitcR6N4VoyIJWjcjNelBUK+kDmgo5o5SN9rhYQ
	 B8aAEje4x4Goz60Jg5bdNHRWEn1u8+/J2YhpS+DZ2b644oYdVmatYVOWlAAghgKnZO
	 VG8rMuXMH/sQO4Y7s0ICOvKWUKQmReDGFfBWWZaQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbfDHSvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 14:51:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:35054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726993AbfDHSvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 14:51:50 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C64302083E;
        Mon,  8 Apr 2019 18:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554749510;
        bh=i2BJDOSY0b5UXb7M++mJ77uoRA2A/8QacAzIny/TqpM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WT6LHNmMsHJaSuhHLAf11muVySdh39Bvdiu0FkZWfQLDJpesryzYq2BMROcy1MZiZ
         A67D4wJBKdCFiyjyQ+3BgwedEsog08TsCIk6CDc6dX2Gd1X5YV4VQ+xp72D3dQ+dqp
         e46B/VCt4QFOe9m/EIFNIJE6CHDT0rZo588FTlZU=
Subject: Re: [GIT PULL] Kselftest update for Linux 5.1-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <ea18a3f7-721e-0234-11e5-f91bf3ef1415@kernel.org>
From:   shuah <shuah@kernel.org>
Message-ID: <7cab83da-76d5-4498-f2dc-9cb5d2a0a723@kernel.org>
Date:   Mon, 8 Apr 2019 12:51:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ea18a3f7-721e-0234-11e5-f91bf3ef1415@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/19 7:34 PM, shuah wrote:
> Hi Linus,
> 
> Please pull the following Kselftest update for Linux 5.1-rc4
> 
> This Kselftest update for Linux 5.1-rc4 consists of fixes to rseq,
> cgroup, and efivarfs tests.
> 
> diff is attached.
> 
> thanks,
> -- Shuah
> 

Hi Linus,

I just noticed that one commit in this pull request has mismatched
author and signed-off. Please disregard the pull request.

I will fix this and send a new pull request. Sorry for the noise.

thanks,
-- Shuah


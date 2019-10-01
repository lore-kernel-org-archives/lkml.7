Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EBEC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E09C221783
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569946007;
	bh=0RzHcpIp8kHgQy1Vby8VC5pq+t/GZT8SixnyxreFcmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ztmU3ntWtvKsjKybhY4aqQcSd/T/JP+FBzWYvCVLpx4djJNkaILbWd6/tocDMVZAP
	 MUW4x1tfv4CljhykRZc8xlLM2L89sKBRffqm7rZn8+Mho1vteBr9S8BxNn+otj+TOk
	 goptJFfhhYuW+JReOXKvWyUBw2bCR+jMcCQznp7w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733137AbfJAQGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:06:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:40468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728322AbfJAQGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:06:45 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F0A02053B;
        Tue,  1 Oct 2019 16:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569946004;
        bh=0RzHcpIp8kHgQy1Vby8VC5pq+t/GZT8SixnyxreFcmU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R2BqFGXkj1YsJJ/S75G5ZolBb6lVRxcbe9cxkjMTSxNl9MGuV+ta/UMHrfHMYv15S
         Axc+j4gq6XO/9RdoMaG5IVSruT0rXoPpFujoH4ZTTlwXZwx531BUheQhl3zvxIM2PW
         FWbKIIRI1r/U0EjoidGcz+9/VU/UZRqm4Uq5Rcek=
Date:   Tue, 1 Oct 2019 12:06:43 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: Re: [PATCH AUTOSEL 5.3 173/203] ASoC: es8316: support fixed and
 variable both clock rates
Message-ID: <20191001160643.GY8171@sasha-vm>
References: <20190922184350.30563-1-sashal@kernel.org>
 <20190922184350.30563-173-sashal@kernel.org>
 <20190923182250.GW2036@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190923182250.GW2036@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 11:22:50AM -0700, Mark Brown wrote:
>On Sun, Sep 22, 2019 at 02:43:19PM -0400, Sasha Levin wrote:
>> From: Katsuhiro Suzuki <katsuhiro@katsuster.net>
>>
>> [ Upstream commit ebe02a5b9ef05e3b812af3d628cdf6206d9ba610 ]
>>
>> This patch supports some type of machine drivers that set 0 to mclk
>> when sound device goes to idle state. After applied this patch,
>> sysclk == 0 means there is no constraint of sound rate and other
>> values will set constraints which is derived by sysclk setting.
>
>This is a new feature and clearly out of scope for stable.

I've dropped it, thanks!

--
Thanks,
Sasha

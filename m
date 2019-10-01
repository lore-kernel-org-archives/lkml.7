Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520E3ECE58A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB5721783
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569946340;
	bh=fjJratraWrht8XM8r7DLelU71kxZL5FcDSRAnGg+4UY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Sc2jRWpFqVQ7PFQBY7Sugml9JyN24+xnqmojkDLXDRnkV3mr/Nn+jfEwvfIrhLd21
	 IxC5BvGiW2I9nG9yNU6ME5FL+JLqvdZklZCZq479A5ugEdj5YlNlxm6TX1yiNQyjQN
	 IYDI/rjH3aGIZkHjwXVqlAL3JLMqtWL1Wk0JU+1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730975AbfJAQMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:12:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:42498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbfJAQMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:12:19 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3ECD52168B;
        Tue,  1 Oct 2019 16:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569946338;
        bh=fjJratraWrht8XM8r7DLelU71kxZL5FcDSRAnGg+4UY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vvdGV6VJJLtyzpC45d4rnpqgyuPazs4fdYGmze1rkqTbflqSSEQbsPqmMSmwrju36
         ccJLZZU9xidBvhTdADYntDgI9UjMinsnxMGHcyeoQEcNmxqzjw2hrYix2kHOKlzyip
         fGMvL+f4mbP/VAhBIMhKmv0KaVPkWszj8ea65yaE=
Date:   Tue, 1 Oct 2019 12:12:16 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH AUTOSEL 4.19 075/128] PM / devfreq: passive: Use non-devm
 notifiers
Message-ID: <20191001161216.GZ8171@sasha-vm>
References: <20190922185418.2158-1-sashal@kernel.org>
 <20190922185418.2158-75-sashal@kernel.org>
 <VI1PR04MB7023BD0451C047D6A59D986EEE850@VI1PR04MB7023.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <VI1PR04MB7023BD0451C047D6A59D986EEE850@VI1PR04MB7023.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 08:38:53PM +0000, Leonard Crestez wrote:
>On 22.09.2019 21:56, Sasha Levin wrote:
>> From: Leonard Crestez <leonard.crestez@nxp.com>
>>
>> [ Upstream commit 0ef7c7cce43f6ecc2b96d447e69b2900a9655f7c ]
>
>This will introduce an "unused variable warning" unless you also
>cherry-pick commit 0465814831a9 ("PM / devfreq: passive: fix compiler
>warning").

I've grabbed it too, thanks!

--
Thanks,
Sasha

Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F5FC3A5A4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 01:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 406322173E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 01:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566783318;
	bh=Vp5Sd/fNd2QJf6+/oGbbZfALGGP8JFzPvrUMi36Y4eM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j7yF7Af05FLT5AYomJ13an1s2RNdbjhVYhJ6PcYurHYreRtnGs/DmdpW6ozLMQRZW
	 ++mgpflVm7Y4QZw+/LsLKsimqhUCS12Qr+7q4P1C0xbTrA0x9kHkXltBF0oRgIi7pK
	 yjKmp6Wc8RufVT9YK9skk3ty6L9YFliRHwwWW+iA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfHZBfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 21:35:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbfHZBfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 21:35:17 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A0F320673;
        Mon, 26 Aug 2019 01:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566783316;
        bh=Vp5Sd/fNd2QJf6+/oGbbZfALGGP8JFzPvrUMi36Y4eM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TxRYpjBS1iwvsFpWodULpItgjW/SeZ6ObRwTCH3qB9X5M/wCt/M4LoB3SX/pGWPjx
         qgrFkWZxJaM2wacKB4D5DCZtGF/TjpKFOwy48ogcAy2Q2AIGVBimpQ6GV1Phw4juG6
         TYdXTPPWVBiD9QAPcTpDCf6K7VU8PBUXXr/CzEOw=
Date:   Sun, 25 Aug 2019 21:35:15 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ricard Wanderlof <ricard.wanderlof@axis.com>,
        Ricard Wanderlof <ricardw@axis.com>
Subject: Re: [PATCH AUTOSEL 5.2 040/123] ASoC: Fail card instantiation if DAI
 format setup fails
Message-ID: <20190826013515.GG5281@sasha-vm>
References: <20190814021047.14828-1-sashal@kernel.org>
 <20190814021047.14828-40-sashal@kernel.org>
 <20190814092213.GC4640@sirena.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190814092213.GC4640@sirena.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 10:22:13AM +0100, Mark Brown wrote:
>On Tue, Aug 13, 2019 at 10:09:24PM -0400, Sasha Levin wrote:
>> From: Ricard Wanderlof <ricard.wanderlof@axis.com>
>>
>> [ Upstream commit 40aa5383e393d72f6aa3943a4e7b1aae25a1e43b ]
>>
>> If the DAI format setup fails, there is no valid communication format
>> between CPU and CODEC, so fail card instantiation, rather than continue
>> with a card that will most likely not function properly.
>
>This is another one where if nobody noticed a problem already and things
>just happened to be working this might break things, it's vanishingly
>unlikely to fix anything that was broken.

Same as the other patch: this patch suggests it fixes a real bug, and if
this patch is broken let's fix it.

--
Thanks,
Sasha

Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6E3C06513
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F8CF218A6
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562163650;
	bh=z+ceB3wIw2kFLTpFQ/DuTnqEHlSgoBJLYsU0/PM4rVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=o7WF2UiH8UFQJvW/pUX48vqjrqSa+okKsSMV2yShbdbttIAgWAluun8ZSnhtpMl1p
	 YqM/A7MwlN0WiX9IZMRPkYicwOQq0aA7kk0vCJREQTcNIIZBXjXPx2xFe4Qj+/Oe0M
	 bD2UM3Ck+CdOlQ5Ac93GSkxhJ+lfZHqU4YqmMGRo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfGCOUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:20:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:55738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbfGCOUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:20:49 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F47C21881;
        Wed,  3 Jul 2019 14:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562163648;
        bh=z+ceB3wIw2kFLTpFQ/DuTnqEHlSgoBJLYsU0/PM4rVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T4gcmT7AzNF+/+X+C1zP1wccnSIWXIXb6RN3zmRbL5pG18qE3EQUo1/2Q0wRH56Mb
         Is/oGwE3tmZ29jswNXVC8DT6Kn0w1bj6vneC0Xyrd/3MLyi7+zO2pYbAcivKaeo28R
         DLwPKKiA+J8ZG2W+hdUgTvGEYyCJQ8mtQt1g3M6I=
Date:   Wed, 3 Jul 2019 10:20:47 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Georgii Staroselskii <georgii.staroselskii@emlid.com>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH AUTOSEL 5.1 11/51] ASoC: sun4i-codec: fix first delay on
 Speaker
Message-ID: <20190703142047.GX11506@sasha-vm>
References: <20190626034117.23247-1-sashal@kernel.org>
 <20190626034117.23247-11-sashal@kernel.org>
 <20190626103741.GU5316@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190626103741.GU5316@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 11:37:41AM +0100, Mark Brown wrote:
>On Tue, Jun 25, 2019 at 11:40:27PM -0400, Sasha Levin wrote:
>> From: Georgii Staroselskii <georgii.staroselskii@emlid.com>
>>
>> [ Upstream commit 1f2675f6655838aaf910f911fd0abc821e3ff3df ]
>>
>> Allwinner DAC seems to have a delay in the Speaker audio routing. When
>> playing a sound for the first time, the sound gets chopped. On a second
>> play the sound is played correctly. After some time (~5s) the issue gets
>> back.
>
>This is inserting a big delay in the startup and might disrupt some
>production system.

But that would be a problem upstream as well, no?

--
Thanks,
Sasha

Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7171C47E49
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 15:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C28620663
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 15:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572103797;
	bh=7bDy0tt9zpS5NCLVgX24iEPWYoUYIoqUv866wtEpd/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JI9hCcHR+kpxS216FksPmLU9zj5cLzZCFGJB5Y1x1AiSJ7KSA0lHPVl+VApPbxZsW
	 AwoAksEQYoLjgVYk1rYlr/NbCiEHUOayUr6F9fi1gqjrYNMiY8a742LYFk4BVuy2+v
	 9JUEtar/iFNgC0QDyO7NEmIEdRAY1GkHP93YY1bk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfJZP34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 11:29:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbfJZP34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 11:29:56 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 775FA20663;
        Sat, 26 Oct 2019 15:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572103795;
        bh=7bDy0tt9zpS5NCLVgX24iEPWYoUYIoqUv866wtEpd/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h1Mo0hA83F+IruKPal8A7Xt3eFcA0MqHKmxIQ5j2hA5QUG7QM9FDJyOcc8jzXeIhE
         vnsEE3AwlW3Q9GlEz/p0jpZc3xXDTgDWKE48aPhKIiAENNcVc2fl06cKuP0S9pTBgK
         icQMuLGggXG/AnD4PWMorLAK9+KPgbJyZIGj/zD4=
Date:   Sat, 26 Oct 2019 11:29:54 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Micah Morton <mortonm@chromium.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Please pick ("LSM: SafeSetID: Stop releasing uninitialized
 ruleset") to 5.3 stable
Message-ID: <20191026152954.GI31224@sasha-vm>
References: <CAD=FV=Uui+a6TS85VNv3XVApq7xYifd8m_ZTmShTC2jeGEO4jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAD=FV=Uui+a6TS85VNv3XVApq7xYifd8m_ZTmShTC2jeGEO4jg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 09:44:09AM -0700, Doug Anderson wrote:
>If you're still taking things for 5.3 stable, I humbly request picking
>up commit 21ab8580b383 ("LSM: SafeSetID: Stop releasing uninitialized
>ruleset").  While bisecting other problems this crash tripped me up
>and I would have been able to bisect faster had the fix been in
>linux-stable.  Only kernel 5.3 is affected.

Queued up, thanks!

-- 
Thanks,
Sasha

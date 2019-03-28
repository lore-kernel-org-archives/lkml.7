Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2570C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B84C2173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfC1KEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 06:04:32 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36919 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfC1KEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 06:04:32 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 0A361808AE; Thu, 28 Mar 2019 11:04:22 +0100 (CET)
Date:   Thu, 28 Mar 2019 11:04:21 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH AUTOSEL 5.0 070/262] drm/amd/display: Pass app_tf by
 value rather than by reference
Message-ID: <20190328100421.GA19456@atrey.karlin.mff.cuni.cz>
References: <20190327180158.10245-1-sashal@kernel.org>
 <20190327180158.10245-70-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327180158.10245-70-sashal@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Nathan Chancellor <natechancellor@gmail.com>
> 
> [ Upstream commit 672e78cab819ebe31e3b9b8abac367be8a110472 ]
> 
> Clang warns when an expression that equals zero is used as a null
> pointer constant (in lieu of NULL):

Fixes warning, with unsupported compiler; not a serious bug. Plus, not
a minimal fix.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

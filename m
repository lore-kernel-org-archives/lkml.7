Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A08C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D3D4205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfC1KI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 06:08:58 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:37365 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfC1KI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 06:08:58 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 120DA806E6; Thu, 28 Mar 2019 11:08:48 +0100 (CET)
Date:   Thu, 28 Mar 2019 11:08:48 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.0 010/262] apparmor: fix double free when
 unpack of secmark rules fails
Message-ID: <20190328100847.GC19456@atrey.karlin.mff.cuni.cz>
References: <20190327180158.10245-1-sashal@kernel.org>
 <20190327180158.10245-10-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327180158.10245-10-sashal@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: John Johansen <john.johansen@canonical.com>
> 
> [ Upstream commit d8dbb581d4f86a2ac669c056fc71a28ebeb367f4 ]
> 
> if secmark rules fail to unpack a double free happens resulting in
> the following oops

> 
> Fixes: 9caafbe2b4cf ("apparmor: Parse secmark policy")
> Reported-by: Alex Murray <alex.murray@canonical.com>
> Signed-off-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Acked-for-stable: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

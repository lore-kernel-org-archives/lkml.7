Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A7CC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0829B2196F
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568809665;
	bh=HZfKqpXATJ2Mk7AOQjnmWNalFips6BC2suOT9IuhEhA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VgQCGfd/g0Hdv0WXpkLiysPdvCnGh19wCQBBIARqlp/wHwBsQp2o5GN6aCAc7lk91
	 3iYT14j/3VzhzT8bLgdUpmR3Yy8PZfVy7QkBFiS8HQprTVW3Nc4EZzTUhzCyHid/R4
	 jHa+6WP6Ioxfnxjh9Qf/+z9yK5N+KcJVNdyrCxfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731113AbfIRM1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 08:27:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:34802 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731103AbfIRM1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 08:27:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2E57EAD78;
        Wed, 18 Sep 2019 12:27:41 +0000 (UTC)
Date:   Wed, 18 Sep 2019 14:27:38 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Lin Feng <linf@wangsu.com>
Cc:     corbet@lwn.net, mcgrof@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        keescook@chromium.org, mchehab+samsung@kernel.org,
        mgorman@techsingularity.net, vbabka@suse.cz, ktkhai@virtuozzo.com,
        hannes@cmpxchg.org, willy@infradead.org,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] [RESEND] vmscan.c: add a sysctl entry for controlling
 memory reclaim IO congestion_wait length
Message-ID: <20190918122738.GE12770@dhcp22.suse.cz>
References: <20190918095159.27098-1-linf@wangsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918095159.27098-1-linf@wangsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please do not post a new version with a minor compile fixes until there
is a general agreement on the approach. Willy had comments which really
need to be resolved first. And I do agree with him. Having an explicit
tunable seems just wrong.

Also does this
[...]
> Reported-by: kbuild test robot <lkp@intel.com>

really hold? Because it suggests that the problem has been spotted by
the kbuild bot which is kinda unexpected... I suspect you have just
added that for the minor compilation issue that you have fixed since the
last version.
-- 
Michal Hocko
SUSE Labs

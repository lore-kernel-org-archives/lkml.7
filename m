Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B70CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5762F21929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572005468;
	bh=RC4m44U2RjATUcBbMcNoEI6IKTjcw0kghPHOG0C8HlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qWq553h11YUcBhZDhQFuAZ0nGA7XXv9UTAedTMnj6qnfIHlaEBI5RGSwfOAwsDX0a
	 JseSY3AjwPfyFqXN0/O2TwB4TNPxoZB8iDoXExz+5lgd61LxeBzilvIdXEGqNQDrXY
	 97xRm+lqPm7bMgya67VEjRM7RKgZf4Ok7yUBzeQo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504224AbfJYMLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 08:11:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:56582 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2409923AbfJYMLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:11:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5BF6DB21D;
        Fri, 25 Oct 2019 12:11:05 +0000 (UTC)
Date:   Fri, 25 Oct 2019 14:11:04 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     snazy@snazy.de
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>
Subject: Re: mlockall(MCL_CURRENT) blocking infinitely
Message-ID: <20191025121104.GH17610@dhcp22.suse.cz>
References: <4576b336-66e6-e2bb-cd6a-51300ed74ab8@snazy.de>
 <b8ff71f5-2d9c-7ebb-d621-017d4b9bc932@infradead.org>
 <20191025092143.GE658@dhcp22.suse.cz>
 <70393308155182714dcb7485fdd6025c1fa59421.camel@gmx.de>
 <20191025114633.GE17610@dhcp22.suse.cz>
 <d740f26ea94f9f1c2fc0530c1ea944f8e59aad85.camel@gmx.de>
 <20191025120505.GG17610@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025120505.GG17610@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 25-10-19 14:05:05, Michal Hocko wrote:
[...]
> This smells like something that could be runtime specific. Could you
> post strace output of your testcase?

Ohh and /proc/<pid>/smaps while the strace is hung on mlockall please.
-- 
Michal Hocko
SUSE Labs

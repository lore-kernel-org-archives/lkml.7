Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6C6C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B60B208C4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgAFQ2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 11:28:06 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:49098 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgAFQ2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 11:28:06 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 8277F80536;
        Mon,  6 Jan 2020 17:28:03 +0100 (CET)
Date:   Mon, 6 Jan 2020 17:28:02 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Christian Gmeiner <christian.gmeiner@gmail.com>
Cc:     David Airlie <airlied@linux.ie>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>
Subject: Re: [PATCH v2 0/6] update hwdw for gc400
Message-ID: <20200106162802.GA20675@ravnborg.org>
References: <20200106151655.311413-1-christian.gmeiner@gmail.com>
 <20200106153643.GA8535@ravnborg.org>
 <CAH9NwWd7C+DzAKe97kURm=sGjDH+KQJOif3j=w6K+99xmYGncQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH9NwWd7C+DzAKe97kURm=sGjDH+KQJOif3j=w6K+99xmYGncQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=D19gQVrFAAAA:8
        a=xMcAtTC5Z7CYE8FbCH0A:9 a=CjuIK1q_8ugA:10 a=JZBxSqCIBzwA:10
        a=W4TVW4IDbPiebHqcZpNg:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian.

> To be honest.. I forgot the change log thing this time - sorry.
It was small changes - so no worries.

> So the rule
> is to have the change log in the normal commit message?
This is what Danial Vetter tell people - but it is not documented as
far as I can tell.

> Funny - Lucas told me something different:
> 
> "Please move those changelogs below the 3 dashes, so they don't end up
> in the commit message. They don't really add any value to the
> persistent kernel history."
> https://lkml.org/lkml/2019/9/13/107
Lucas is maintainer of etnaviv driver - so do as he says.

Keep up the good work on etnaviv in mesa too!

	Sam

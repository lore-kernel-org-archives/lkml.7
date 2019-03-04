Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9A1C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D00DB20675
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="hqWZKdZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfCDSNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 13:13:09 -0500
Received: from one.firstfloor.org ([193.170.194.197]:51644 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfCDSNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 13:13:09 -0500
Received: by one.firstfloor.org (Postfix, from userid 503)
        id 3028F86862; Mon,  4 Mar 2019 19:13:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1551723186;
        bh=qe6Rc1Tef+skM85VLiwx5GehyqVd6DWNrvvaBn9uytA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hqWZKdZVw/+DbhFzQ/v1LnJGrZAGJTj0RH15ebqheVR6KYZrNzKnxHNay/PfXVe3v
         KQy96xZMyO0ppY8cVn4Md8+p5Ix6oODQwaTUWkpM0nyeZUh1ben4mqdXH4Sv9S93V+
         52eA0ND3uR23/QlWqzVgUn0J4rwqkUod4sKzA2Ws=
Date:   Mon, 4 Mar 2019 10:13:06 -0800
From:   Andi Kleen <andi@firstfloor.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <andi@firstfloor.org>, acme@kernel.org,
        jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v3 10/11] perf tools report: Implement browsing of
 individual samples
Message-ID: <20190304181305.vrauc44yxv43rwir@two.firstfloor.org>
References: <20190228183550.14126-1-andi@firstfloor.org>
 <20190228183550.14126-11-andi@firstfloor.org>
 <20190304144855.GL30476@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304144855.GL30476@krava>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +--samples=N::
> > +	Save N individual samples for each histogram entry to show context in perf
> > +	report tui browser.
> 
> maybe we could set some default value (50?)

50 wouldn't fit on the screen.

I turned it off by default intentionally because it will increase the
memory consumption of perf report quite a bit.

It might be possible to set some small default though, but right
now I guess whoever wants it can enable it.

-Andi

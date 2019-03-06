Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13739C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D887320684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="Qw3lzvIg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbfCFVIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 16:08:32 -0500
Received: from one.firstfloor.org ([193.170.194.197]:39168 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfCFVIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 16:08:32 -0500
Received: by one.firstfloor.org (Postfix, from userid 503)
        id 5D80D86862; Wed,  6 Mar 2019 22:08:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1551906509;
        bh=ivSSK4z/CfdclTZrEmcom9QoXWFr0EBzuUhKtuW9QYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qw3lzvIghiK3io0sbkrBelX8yOyrBqcJ4Cn3Mv+nGcDBdJeag/WmsBX4MF+TPFbuA
         yH6TkQmb2zitlP65hHqf09oNA8CM6hRkuC4ChJhWHnqYdBGwwX96+mAl18h1Dcya8S
         7+IInmi1c3M/dRWBT6fWYAUO2TG1W2d18NcM9OHw=
Date:   Wed, 6 Mar 2019 13:08:29 -0800
From:   Andi Kleen <andi@firstfloor.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v4 01/15] perf tools: Add utility function to fetch
 executable
Message-ID: <20190306210828.yvhifeczc7mfloqi@two.firstfloor.org>
References: <20190305144758.12397-1-andi@firstfloor.org>
 <20190305144758.12397-2-andi@firstfloor.org>
 <20190306205337.GK30734@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190306205337.GK30734@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> . No need to cast around, make 'buf' be a void pointer
> 
> . Rename it to thread__memcpy() to reflect the fact it is about copying
>   a chunk of memory from a thread, i.e. from its address space.
> 
> . No need to have it in a separate object file, move it to thread.[ch]
> 
> . Check the return of map__load(), the original code didn't do it, but
>   since we're moving this around, check that as well, could be moved to
>   a separate patch tho.

Changes look good. Thanks Arnaldo.

-Andi

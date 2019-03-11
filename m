Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302BEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0328020643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="FTU2X5Uo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbfCKTE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:04:57 -0400
Received: from one.firstfloor.org ([193.170.194.197]:38158 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbfCKTE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:04:56 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
        id 083448684A; Mon, 11 Mar 2019 20:04:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1552331094;
        bh=iT2lCMbDjwATqPItGUx3J64+Qa6ZHdcHMkPbP/exwpg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FTU2X5UoPP5lwrWSECitEyZ/ze1GHY9PVUFoYVvHiLrmSeUmPVL68bfXT79P79IwL
         2evQCJjBrIHH1rVCPiOwiT9hXQ7eg8zkEuWgY6YXMuwrSiVwErzeLDW3QyQ+fEdTZN
         YmeWrrYDrnF2MXch29AzKbnpxIMAd1Fww8vd1vqw=
Date:   Mon, 11 Mar 2019 12:04:53 -0700
From:   Andi Kleen <andi@firstfloor.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 07/11] perf tools report: Implement browsing of
 individual samples
Message-ID: <20190311190453.f2m245zqsomh63me@two.firstfloor.org>
References: <20190311144502.15423-1-andi@firstfloor.org>
 <20190311144502.15423-8-andi@firstfloor.org>
 <20190311172420.GC9664@krava>
 <20190311174605.GA29294@tassilo.jf.intel.com>
 <20190311183545.GY10690@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311183545.GY10690@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> And here is the diff to what was before. Replaced the previous patch
> with this one and I'm adding Jiri's Acked-by to the whole series, as he
> provided me privately, thanks guys!

Great. Thanks everyone!


-Andi

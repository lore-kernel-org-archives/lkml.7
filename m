Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FA0C2D0D3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 18:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B7E206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 18:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfL3SRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 13:17:43 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:29877 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727389AbfL3SRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 13:17:42 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id xBUIH8fv018873;
        Mon, 30 Dec 2019 19:17:08 +0100
Date:   Mon, 30 Dec 2019 19:17:08 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.4 000/434] 5.4.7-stable review
Message-ID: <20191230181708.GB14939@1wt.eu>
References: <20191229172702.393141737@linuxfoundation.org>
 <20191230174336.GA1498696@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230174336.GA1498696@kroah.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, Dec 30, 2019 at 06:43:36PM +0100, Greg Kroah-Hartman wrote:
> I have pushed out -rc2:
>  	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.7-rc2.gz
> 
> to resolve some reported issues.

OK, running right now on my netbook. So far, so good:

Linux eeepc 5.4.7-rc2-eeepc #1 SMP Mon Dec 30 18:55:14 CET 2019 i686 Intel(R) Atom(TM) CPU N2800   @ 1.86GHz GenuineIntel GNU/Linux

Also not sure what is supposed not to work with perf, but at least I've
built it and it seems to work as expected at first glance.

Hoping this helps,
Willy

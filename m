Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9340FC3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 07:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69D082077C
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 07:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbfHQHWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 03:22:55 -0400
Received: from smtprelay0197.hostedemail.com ([216.40.44.197]:45243 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725784AbfHQHWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 03:22:55 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id BF910181D33FC;
        Sat, 17 Aug 2019 07:22:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fish56_5354f57556556
X-Filterd-Recvd-Size: 1469
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Sat, 17 Aug 2019 07:22:52 +0000 (UTC)
Message-ID: <74b4a00b524cf8dd11631692dee65ccbba34b8cb.camel@perches.com>
Subject: Re: [PATCH] clk: Remove extraneous 'for' word in comments
From:   Joe Perches <joe@perches.com>
To:     Rishi Gupta <gupt21@gmail.com>, sboyd@kernel.org,
        kernel-janitors <kernel-janitors@vger.kernel.org>
Cc:     mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 17 Aug 2019 00:22:51 -0700
In-Reply-To: <1566023759-7880-1-git-send-email-gupt21@gmail.com>
References: <1566023759-7880-1-git-send-email-gupt21@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-08-17 at 12:05 +0530, Rishi Gupta wrote:
> An extra 'for' word is grammatically incorrect in the comment
> 'verifying ops for multi-parent clks'. This commit removes
> this extra for word.

A few other repeated word typos in comments are 
common in the kernel and most could be changed.

$ git grep -P '^\s*/?\*.*\bthe the\b' | wc -l
285
$ git grep -P '^\s*/?\*.*\bto to\b' | wc -l
62
$ git grep -P '^\s*/?\*.*\bfor for\b' | wc -l
31
$ git grep -P
'^\s*/?\*.*\bfrom from\b' | wc -l
22
$ git grep -P '^\s*/?\*.*\bare are\b'
| wc -l
16



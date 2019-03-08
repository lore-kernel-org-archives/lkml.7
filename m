Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00FBC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF4020811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfCHIkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 03:40:09 -0500
Received: from smtp1.goneo.de ([85.220.129.30]:38936 "EHLO smtp1.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbfCHIkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 03:40:08 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp1.goneo.de (Postfix) with ESMTP id 0110223F44D;
        Fri,  8 Mar 2019 09:40:10 +0100 (CET)
X-Virus-Scanned: by goneo
Received: from smtp1.goneo.de ([127.0.0.1])
        by localhost (smtp1.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id J9ny2Pl301hD; Fri,  8 Mar 2019 09:40:08 +0100 (CET)
Received: from [192.168.1.127] (dyndsl-091-248-065-152.ewe-ip-backbone.de [91.248.65.152])
        by smtp1.goneo.de (Postfix) with ESMTPSA id 9B09723F062;
        Fri,  8 Mar 2019 09:40:08 +0100 (CET)
Subject: Re: [PATCH 0/9] docs: Fix various build warnings/errors
To:     "Tobin C. Harding" <tobin@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190307211153.28400-1-tobin@kernel.org>
From:   Markus Heiser <markus.heiser@darmarit.de>
Message-ID: <2b5f55e5-79d6-2538-5054-b34e4b93e721@darmarit.de>
Date:   Fri, 8 Mar 2019 09:40:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190307211153.28400-1-tobin@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 07.03.19 um 22:11 schrieb Tobin C. Harding:
> Hi,
> 
> I had a few hours to spare so I thought I'd clear some Sphinx build
> warnings/errors.  There isn't anything too controversial here.  The only
> interesting thing I hit was in patch 7 (docs: Remove unknown 'hint'
> directive), I couldn't work out if this was a serious directive, a joke,
> or a typo.  

Hi Tobin,

the problem was a missing empty line (see my comment on this patch).

The reST primer from sphinx-doc is always a good reference for the daily work

   http://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#directives

-- Markus --

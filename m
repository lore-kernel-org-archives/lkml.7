Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85E1CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE90A20578
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=firemail.cc header.i=@firemail.cc header.b="zpgn0jd0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbfKDSUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 13:20:49 -0500
Received: from mx1.cock.li ([185.10.68.5]:45545 "EHLO cock.li"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728216AbfKDSUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 13:20:49 -0500
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firemail.cc; s=mail;
        t=1572891647; bh=qkasHMBgDg6iO9CdM753A+3VB9fjbontl7Ks74KCzHQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zpgn0jd0OM1+tU9z9WbPzXHm7DY/ZofYqNa6vB9GKdL6Hl5MAw5DcF1Frza0BzAma
         j9i/22gMKw3+mEb2cz6mc2r0ISF+zmT31PgWqeUWuwTSB+R4wmZv+tvdXQWxHOUGXV
         Uy4bEDbixSIbih0RQhiYD2ggvY68E5HhxdjIhJXSfX5KRVzNjW4GC8ZTqFcQQafavu
         0O8XqUh8LKopkXEd7i5CymLbeICQzl/RZ+f/Uixfui2S0JoQAbMG+R6f2lmk9N3u88
         puVO81ZlyO8QYF2WYBIdzjb70u0WBBtbUQvgodlUCUE8Xmox/mgBq6YcOidrJebsfD
         YeEWYAVtslV+A==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 04 Nov 2019 18:20:46 +0000
From:   nipponmail@firemail.cc
To:     linux-kernel@vger.kernel.org
Cc:     ruben@mrbrklyn.com, mrbrklyn@panix.com
Subject: Re: Will no-one sue GrSecurity for their blatant GPL violation (of
 GCC and the linux kernel)? - He is violating, but you can also rescind the
 license
In-Reply-To: <E1iRgHg-0007e0-Gd@fencepost.gnu.org>
References: <b0668893d6fbfeca10a724e1c5846e92@firemail.cc>
 <E1iRgHg-0007e0-Gd@fencepost.gnu.org>
Message-ID: <217b99f456fb178603a9cece07a7d8ee@firemail.cc>
X-Sender: nipponmail@firemail.cc
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You do know, correct?, that the Copyright holder can simply rescind the 
license if he is displeased with the way the licensee is behaving - 
since the license is not supported by a contract.

The licensee would then rush to the Federal Court in his district to 
seek a declaratory judgement regarding his rights, and then you're in a 
diversity and federal-question suit.

But that is an option where the licensee paid no consideration for the 
non-exclusive licensee grant (and no: obeying a pre-existing legal duty 
is not sufficient for consideration)

I would like to note that in the Kasner(sp)? decision in the 9th circuit 
the uneducated like to bandy about; the Artistic License was found NOT 
to be a contract but a simple copyright license.

Also in the lower-court (California) Artifex decision the court didn't 
even identify the "GPL" correctly, conflating it with the 
offer-to-do-paying-bushiness preliminary writing (pay us, or accept the 
GPL), but the court then allowed the Copyright holder to choose which 
theory to go ahead with: Contract damages for the price of the 
proprietary license OR pure Federal Copyright damages under the GPL 
(because the GPL is not a contract: it's only a license. If the court 
found it to be a contract it would limit the recovery to contract 
damages under state law: which is WHY in Kasner the violator wanted the 
Artistic license to be deemed a contract: damages of 0 (free))

However, GrSecurity is violating the GPL so you can just sue for 
Copyright damages off the bat (as my other 2 posts quickly explain, I 
haven't repeated the arguments here).

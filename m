Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC00C282E2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 03:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0451D21855
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 03:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfDTDt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 23:49:29 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45929 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725911AbfDTDt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 23:49:28 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x3K3nJh5028479
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Apr 2019 23:49:20 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 80929420497; Fri, 19 Apr 2019 23:49:19 -0400 (EDT)
Date:   Fri, 19 Apr 2019 23:49:19 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     George Spelvin <lkml@sdf.org>
Cc:     linux-kernel@vger.kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH] random: Document get_random_int() family
Message-ID: <20190420034919.GB5539@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        George Spelvin <lkml@sdf.org>, linux-kernel@vger.kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
References: <201903260426.x2Q4QsgN023352@sdf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201903260426.x2Q4QsgN023352@sdf.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 04:26:54AM +0000, George Spelvin wrote:
> Explain what these functions are for and when they offer
> an advantage over get_random_bytes().
> 
> (We still need documentation on rng_is_initialized(), the
> random_ready_callback system, and early boot in general.)
> 
> Signed-off-by: George Spelvin <lkml@sdf.org>

Applied, thanks.

					- Ted

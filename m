Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265E6C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 19:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05BF32133D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 19:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbfFMT5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 15:57:11 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55327 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726379AbfFMT5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 15:57:11 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x5DJv68X008670
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jun 2019 15:57:06 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D73F0420484; Thu, 13 Jun 2019 15:57:05 -0400 (EDT)
Date:   Thu, 13 Jun 2019 15:57:05 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "R.F. Burns" <burnsrf@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: PC speaker
Message-ID: <20190613195705.GC9609@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        "R.F. Burns" <burnsrf@gmail.com>, linux-kernel@vger.kernel.org
References: <CABG1boNKq4Q49t2tFA863hi=jrFnJLarER5nyyGSpFPMbT1Qvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABG1boNKq4Q49t2tFA863hi=jrFnJLarER5nyyGSpFPMbT1Qvg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 12:16:37PM -0400, R.F. Burns wrote:
> Is it possible to write a kernel module which, when loaded, will blow
> the PC speaker?

Yes; in fact, it's already been done.  See sound/drivers/pcsp/ in the
Linux kernel sources.

						- Ted

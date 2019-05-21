Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5BCC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 18:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B6C204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 18:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbfEUS5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 14:57:22 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36023 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727990AbfEUS5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 14:57:22 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4LIvGTu021736
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 May 2019 14:57:17 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 89CD9420481; Tue, 21 May 2019 14:57:16 -0400 (EDT)
Date:   Tue, 21 May 2019 14:57:16 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     ksummit-discuss@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: First round of Maintainer's Summit invites have gone out
Message-ID: <20190521185716.GA6339@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first round of invites to the Maintainer's Summit have gone out,
going out to 15 out of the 30 slots available.  This list was drawn
from a list which Linus generated, based on git statistics.  The
second round will be drawn from a list generated via nominations and
suggestions, as documented in the Maintainer's Summit / Kernel Summit
track CFP:

	https://lwn.net/Articles/788378/

Also, as a reminder, submissions of proposals for the Kernel Summit
received before May 31st, will, if accepted, give you a free invite to
the Plumbers Conference.

The list of people on the first round of invites are:

Alexei Starovoitov
Andrew Morton
Dave Airlie
David Miller
Greg Kroah-Hartman
Ingo Molnar
Jens Axboe
Jiri Kosina
Jonathan Corbet
Linus Torvalds
Linus Walleij
Rafael Wysocki
Stephen Rothwell,sfr@canb.auug.org.au
Takashi Iwai
Theodore Ts'o
Thomas Gleixner

Cheers,

					- Ted

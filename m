Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1162C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F015214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbfHTRQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 13:16:02 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49301 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725971AbfHTRQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 13:16:02 -0400
Received: from callcc.thunk.org (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7KHFpXU001417
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Aug 2019 13:15:53 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 75AC9420843; Tue, 20 Aug 2019 13:15:50 -0400 (EDT)
Date:   Tue, 20 Aug 2019 13:15:50 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Sebastian Duda <sebastian.duda@fau.de>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
Subject: Re: Status of Subsystems
Message-ID: <20190820171550.GE10232@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Sebastian Duda <sebastian.duda@fau.de>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
References: <2529f953-305f-414b-5969-d03bf20892c4@fau.de>
 <20190820131422.2navbg22etf7krxn@pali>
 <3cf18665-7669-a33c-a718-e0917fa6d1b9@fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cf18665-7669-a33c-a718-e0917fa6d1b9@fau.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 03:56:24PM +0200, Sebastian Duda wrote:
> 
> so the status of the files is inherited from the subsystem `INPUT MULTITOUCH
> (MT) PROTOCOL`?
> 
> Is it the same with the subsystem `NOKIA N900 POWER SUPPLY DRIVERS`
> (respectively `POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS`)?

Note that the definitions of "subsystems" is not necessarily precise.
So assuming there is a strict subclassing and inheritance might not be
a perfect assumption.  There are some files which have no official
owner, and there are also some files which may be modified by more
than one subsystem.

We certainly don't talk about "inheritance" when we talk about
maintainers and sub-maintainers.  Furthermore, the relationships,
processes, and workflows between a particular maintainer and their
submaintainers can be unique to a particular maintainer.

We define these terms to be convenient for Linux development, and like
many human institutions, they can be flexible and messy.  The goal was
*not* define things so it would be convenient for academics writing
papers --- like insects under glass.

Cheers,

						- Ted


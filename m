Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB831C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 05:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD3C8217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 05:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731740AbfEXFBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 01:01:23 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45827 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726150AbfEXFBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 01:01:23 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4O51GKi008389
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 May 2019 01:01:17 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 33A28420481; Fri, 24 May 2019 01:01:16 -0400 (EDT)
Date:   Fri, 24 May 2019 01:01:16 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     walter harms <wharms@bfs.de>
Cc:     Aung <aung.aungkyawsoe@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: need company for kernel upgrade
Message-ID: <20190524050116.GI2532@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        walter harms <wharms@bfs.de>, Aung <aung.aungkyawsoe@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>
References: <5CE53BA9.4070906@bfs.de>
 <CABC7EG8NiiPycthdfb7Ng3MsxTvmmxk_LjcosM8ZD1F0CnuDFw@mail.gmail.com>
 <5CE64BC7.4010803@bfs.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5CE64BC7.4010803@bfs.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 09:29:11AM +0200, walter harms wrote:
> 
> No,
> the company i am working for has a custom build arm-board.
> We bought the kernel from the assembler but found it has
> some problems that need fixing.
> Basically we want to improve the linux-kernel so it can run
> native on our boards.
> 
> >> Hi developers,
> >> i am in search of a company that can help upgrading
> >> a running linux-kernel on custom hardware.
> >> Est. time 10 days.

Have you tried contacting Linutronix (https://linutronix.de) or
Collabora (https://collabora.com)?

Both have EU offices --- well Collabora does for now, until Brexit
happens.  :-)

						- Ted

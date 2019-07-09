Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F57C73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 15:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81B1F20656
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 15:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfGIPbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 11:31:00 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36107 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726444AbfGIPa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 11:30:58 -0400
Received: from callcc.thunk.org ([199.116.118.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x69FUe61012204
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 9 Jul 2019 11:30:42 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D86D942002E; Tue,  9 Jul 2019 11:30:39 -0400 (EDT)
Date:   Tue, 9 Jul 2019 11:30:39 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: Re: Procedure questions - new filesystem driver..
Message-ID: <20190709153039.GA3200@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
References: <21080.1562632662@turing-police>
 <20190709045020.GB23646@mit.edu>
 <20190709112136.GI32320@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709112136.GI32320@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 04:21:36AM -0700, Matthew Wilcox wrote:
> How does
> https://www.zdnet.com/article/microsoft-open-sources-its-entire-patent-portfolio/
> change your personal opinion?

According to SFC's legal analysis, Microsoft joining the OIN doesn't
mean that the eXFAT patents are covered, unless *Microsoft*
contributes the code to the Linux usptream kernel.  That's because the
OIN is governed by the Linux System Definition, and until MS
contributes code which covered by the exFAT patents, it doesn't count.

For more details:

https://sfconservancy.org/blog/2018/oct/10/microsoft-oin-exfat/

(This is not legal advice, and I am not a lawyer.)

						- Ted

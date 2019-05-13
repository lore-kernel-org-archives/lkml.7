Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23608C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 23:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0DD72084D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 23:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfEMX6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 19:58:12 -0400
Received: from smtprelay0165.hostedemail.com ([216.40.44.165]:42088 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726541AbfEMX6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 19:58:11 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id A0001180A8877;
        Mon, 13 May 2019 23:58:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: truck57_817ac89ed1b4e
X-Filterd-Recvd-Size: 1598
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Mon, 13 May 2019 23:58:09 +0000 (UTC)
Message-ID: <1b9e57cb7544f1edbef9a142663e8f71874b204d.camel@perches.com>
Subject: Re: [Proposal] end of file checks by checkpatch.pl
From:   Joe Perches <joe@perches.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>
Date:   Mon, 13 May 2019 16:58:08 -0700
In-Reply-To: <CAK7LNAROgRBuZOVb5+NZd10+z=SaRhvJZ5eQ09pcknbdEJ+Gng@mail.gmail.com>
References: <CAK7LNAR5j1ygbq9TLqUhbJ+tkMdrtD3BgQoUWZErUrnEoWKYMw@mail.gmail.com>
         <b5e2a4d9eb49290d6dc3449c90cdf07797b1aba6.camel@perches.com>
         <CAK7LNAQxsUheo2dHn5E=4ACafcYL9zNubgiVkJkANuZkx2RgpA@mail.gmail.com>
         <a28b0616aca51aed38fd99fb85632628e6fd8d60.camel@perches.com>
         <CAK7LNAROgRBuZOVb5+NZd10+z=SaRhvJZ5eQ09pcknbdEJ+Gng@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-05-14 at 08:46 +0900, Masahiro Yamada wrote:
> So, I think these two checks can be done for
> all file types.
[]
> checkpatch.pl misses to report most of them.
> (the majority of the warning source is *.json)

Perhaps the json files should be ignored as more than
half of the .json files in the tree are missing the
newline at EOF.

And at least some of those json files use spaces for
indentation and not tabs.


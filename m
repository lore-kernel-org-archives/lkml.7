Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39817C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 11:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A4C22CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 11:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfH3LJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 07:09:20 -0400
Received: from smtprelay0043.hostedemail.com ([216.40.44.43]:43654 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726660AbfH3LJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 07:09:19 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 5FEE4182CF668;
        Fri, 30 Aug 2019 11:09:18 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: comb79_33fd188898c22
X-Filterd-Recvd-Size: 1235
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Fri, 30 Aug 2019 11:09:17 +0000 (UTC)
Message-ID: <ccc65bd29747f8ad4d0ba1b3eda6c9d230f03c70.camel@perches.com>
Subject: Re: [PATCH] Makefile: Convert -Wimplicit-fallthrough to
 -Wimplicit-fallthrough=2
From:   Joe Perches <joe@perches.com>
To:     Michal Suchanek <msuchanek@suse.de>, linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Date:   Fri, 30 Aug 2019 04:09:15 -0700
In-Reply-To: <20190829120215.1977-1-msuchanek@suse.de>
References: <20190829120215.1977-1-msuchanek@suse.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-29 at 14:02 +0200, Michal Suchanek wrote:
> In particular the default value of 3 does not match the comments like
> /* falls through to do foobar */

How many comments are there like this in the kernel?

Also you have to deal with gcc/clang differences.
As far as I know, clang doesn't take a value for this.



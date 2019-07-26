Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCF7C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E4FC216F4
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbfGZSVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 14:21:41 -0400
Received: from smtprelay0147.hostedemail.com ([216.40.44.147]:57285 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726103AbfGZSVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 14:21:41 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 8B0CE18225DE2;
        Fri, 26 Jul 2019 18:21:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: crate84_2b5cc4a52181d
X-Filterd-Recvd-Size: 1705
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Fri, 26 Jul 2019 18:21:37 +0000 (UTC)
Message-ID: <0440fc0b1e8599df3cf0728261f74faf25fc4408.camel@perches.com>
Subject: Re: [PATCH 1/6] staging: rtl8188eu: add spaces around '+' in
 usb_halinit.c
From:   Joe Perches <joe@perches.com>
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 26 Jul 2019 11:21:36 -0700
In-Reply-To: <20190726180448.2290-1-straube.linux@gmail.com>
References: <20190726180448.2290-1-straube.linux@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-07-26 at 20:04 +0200, Michael Straube wrote:
> Add spaces around '+' to improve readability and follow kernel
> coding style. Reported by checkpatch.

My preference would be to do all the horizontal whitespace
changes for the entire driver in one go without worrying
about long lines.

$ git ls-files -- 'drivers/staging/rtl8188eu/*.[ch]' | \
  xargs ./scripts/checkpatch.pl -f --types=SPACING --fix-inplace
$ git diff -w drivers/staging/rtl8188eu/
$ git diff --shortstat drivers/staging/rtl8188eu
 35 files changed, 603 insertions(+), 603 deletions(-)

Mention that git diff -w shows no difference and
verify that object files are unchanged and mention
both in the changelog.

Subject could be something like:

staging: rtl8188eu: Use typical kernel horizontal whitespace



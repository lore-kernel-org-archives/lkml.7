Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AA2C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 09:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B2A216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 09:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfK1JfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 04:35:17 -0500
Received: from smtprelay0084.hostedemail.com ([216.40.44.84]:60116 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726252AbfK1JfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 04:35:17 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 4BACA4DCF;
        Thu, 28 Nov 2019 09:35:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: touch72_681114d104324
X-Filterd-Recvd-Size: 1652
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Thu, 28 Nov 2019 09:35:15 +0000 (UTC)
Message-ID: <ab3309596fac1c5a0cb4e0abed0cf1ee7ac13a3d.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Look for Kconfig indentation errors
From:   Joe Perches <joe@perches.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date:   Thu, 28 Nov 2019 01:34:47 -0800
In-Reply-To: <87a78gnyaz.fsf@intel.com>
References: <1574906800-19901-1-git-send-email-krzk@kernel.org>
         <87a78gnyaz.fsf@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-11-28 at 11:29 +0200, Jani Nikula wrote:
> On Thu, 28 Nov 2019, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > Kconfig should be indented with one tab for first level and tab+2 spaces
> > for second level.  There are many mixups of this so add a checkpatch
> > rule.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> I agree unifying the indentation is nice, and without something like
> this it'll start bitrotting before Krzysztof's done fixing them all... I
> think there's been quite a few fixes merged lately.
> 
> I approve of the idea, but I'm clueless about the implementation.

I think that a grammar, or a least an array of words
that are supposed to start on a tab should be used here.



Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07A4C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 21:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9388120838
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 21:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfCBVde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 16:33:34 -0500
Received: from hurricane.the-brannons.com ([71.19.155.94]:42730 "EHLO
        hurricane.the-brannons.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726529AbfCBVdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 16:33:33 -0500
X-Greylist: delayed 380 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 Mar 2019 16:33:33 EST
Received: by hurricane.the-brannons.com (Postfix, from userid 1000)
        id E32277B0CF; Sat,  2 Mar 2019 13:27:12 -0800 (PST)
From:   Christopher Brannon <chris@the-brannons.com>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>
cc:     Colin King <colin.king@canonical.com>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: speakup: i18n: fix spelling mistake "phoneticly" -> "phonetically"
In-reply-to: <20190302194211.4aj6r3dr4hahbnqi@function>
References: <20181128161232.14907-1-colin.king@canonical.com> <20190302194211.4aj6r3dr4hahbnqi@function>
Comments: In-reply-to Samuel Thibault <samuel.thibault@ens-lyon.org>
   message dated "Sat, 02 Mar 2019 11:42:11 -0800."
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <18281.1551562032.1@localhost.localdomain>
Date:   Sat, 02 Mar 2019 13:27:12 -0800
Message-Id: <20190302212712.E32277B0CF@hurricane.the-brannons.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Thibault writes:
> Hello,
>
> Colin King, le mer. 28 nov. 2018 16:12:32 +0000, a ecrit:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > There is a spelling mistake in array speakup_default_msgs at index
> > MSG_FUNCNAME_SPELL_WORD_PHONETICALLY, fix this.
> > 
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
>
> We never got any feedback from the speakup mailing list, I guess fixing
> the typo is fine.

I'm sure there were deliberate mis-spellings in Speakup error
messages to accomodate pronunciation issues with older synths, but I
have no idea whether this is one of them.  It's probably fine either way.

-- Chris

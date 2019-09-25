Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5915C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 19:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0378222C0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 19:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392448AbfIYTrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 15:47:35 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43078 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387882AbfIYTrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 15:47:35 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iDDG8-0000Sl-3b; Wed, 25 Sep 2019 19:47:32 +0000
Date:   Wed, 25 Sep 2019 20:47:32 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, sndirsch@suse.com,
        tzimmermann@suse.com
Subject: Re: 4f5368b5541a902f6596558b05f5c21a9770dd32 causes regression
Message-ID: <20190925194732.GM26530@ZenIV.linux.org.uk>
References: <1569439345.3084.5.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569439345.3084.5.camel@suse.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 09:22:25PM +0200, Oliver Neukum wrote:
> Hi,
> 
> I am seeing a hard lockup during boot with this patch.
> I am using only the laptop's internal display.
> The last message I see is:
> 
> kvm: disabled by BIOS
> 
> 	Regards
> 		Oliver

	Shocking as it might seem, most of us do not remember the
sha1 of commits by heart.  So it's generally a good idea to
accompany such with something like "drm/kms: Catch mode_object
lifetime errors" (in this case) - makes life easier for folks
trying to decide whether to skip a particular piece of mail/thread
or look into it...

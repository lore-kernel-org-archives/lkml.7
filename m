Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764BCC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 17:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5645821897
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 17:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730189AbfICRdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 13:33:02 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:32900 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728854AbfICRdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 13:33:02 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.1 #3 (Red Hat Linux))
        id 1i5Cfh-0003V8-Rg; Tue, 03 Sep 2019 17:32:49 +0000
Date:   Tue, 3 Sep 2019 18:32:49 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Valentin Vidic <vvidic@valentin-vidic.from.hr>
Cc:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: exfat: cleanup braces for if/else statements
Message-ID: <20190903173249.GL1131@ZenIV.linux.org.uk>
References: <20190903164732.14194-1-vvidic@valentin-vidic.from.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903164732.14194-1-vvidic@valentin-vidic.from.hr>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 06:47:32PM +0200, Valentin Vidic wrote:
> +			} else if (uni == 0xFFFF) {
>  				skip = TRUE;

While we are at it, could you get rid of that 'TRUE' macro?
Or added

#define THE_TRUTH_AND_THATS_CUTTIN_ME_OWN_THROAT true

if you want to properly emphasize it...

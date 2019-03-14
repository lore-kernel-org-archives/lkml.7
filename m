Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67A5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FAD121019
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfCNMen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 08:34:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:47822 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726688AbfCNMem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 08:34:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4EDD5ADC8;
        Thu, 14 Mar 2019 12:34:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BE42BDA875; Thu, 14 Mar 2019 13:35:52 +0100 (CET)
Date:   Thu, 14 Mar 2019 13:35:51 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <JSlaby@suse.com>, pakki001@umn.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: ipwireless: fix missing checks for ioremap
Message-ID: <20190314123550.GI31119@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Kangjie Lu <kjlu@umn.edu>,
        Jiri Kosina <jikos@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <JSlaby@suse.com>, pakki001@umn.edu,
        linux-kernel@vger.kernel.org
References: <20190314070534.17819-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190314070534.17819-1-kjlu@umn.edu>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 02:05:32AM -0500, Kangjie Lu wrote:
> ipw->attr_memory and ipw->common_memory are assigned with the
>  return value of ioremap. ioremap may fail, but not checks
> are enforced. The fix insertss the checks.

Please fix the typos and resend, otherwise ok. Thanks.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Reviewed-by: David Sterba <dsterba@suse.com>

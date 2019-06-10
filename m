Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7801C28D16
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 12:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB1D320679
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 12:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389899AbfFJMdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 08:33:45 -0400
Received: from ms.lwn.net ([45.79.88.28]:43790 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388373AbfFJMdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 08:33:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 059399B0;
        Mon, 10 Jun 2019 12:33:43 +0000 (UTC)
Date:   Mon, 10 Jun 2019 06:33:40 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.1 56/85] doc: Cope with the deprecation of
 AutoReporter
Message-ID: <20190610063340.051ee13b@lwn.net>
In-Reply-To: <20190610074840.GB24746@kroah.com>
References: <20190607153849.101321647@linuxfoundation.org>
        <20190607153855.717899507@linuxfoundation.org>
        <1fbb40df-d420-9f10-34a9-340b3156eb7c@suse.cz>
        <20190610073119.GB20470@kroah.com>
        <f20b3005-53f8-607a-e995-741836b3f5f0@suse.cz>
        <20190610074840.GB24746@kroah.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jun 2019 09:48:40 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> Hm, 2.1 here:
> 	Running Sphinx v2.1.0
> perhaps Tumbleweed needs to update?  :)

Heh...trying 2.1 is still on my list of things to do ... :)

> Anyway, this should not be breaking, if Jon doesn't have any ideas, I'll
> just drop these changes.

The fix for that is 551bd3368a7b (drm/i915: Maintain consistent
documentation subsection ordering) which was also marked for stable.  Jiri,
do you somehow not have that one?

Thanks,

jon

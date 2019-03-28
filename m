Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8B6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F972082F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbfC1QjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:39:04 -0400
Received: from ms.lwn.net ([45.79.88.28]:43802 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbfC1QjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:39:04 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5DDCE9AC;
        Thu, 28 Mar 2019 16:39:03 +0000 (UTC)
Date:   Thu, 28 Mar 2019 10:39:02 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 00/23] Include linux ACPI docs into Sphinx TOC tree
Message-ID: <20190328103902.1084337d@lwn.net>
In-Reply-To: <20190328162721.26138-1-changbin.du@gmail.com>
References: <20190328162721.26138-1-changbin.du@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Mar 2019 00:26:58 +0800
Changbin Du <changbin.du@gmail.com> wrote:

> The kernel now uses Sphinx to generate intelligent and beautiful documentation
> from reStructuredText files. I converted most of the Linux ACPI docs to rst
> format in this serias.

Thanks for doing this.  I've only looked quickly at this point, so I just
have a couple of high-level comments.

 - If at all possible, I would really rather this not be placed in the
   top-level of the document tree.  Things are far too cluttered there
   already; I would prefer to take stuff out instead.

   That said, I'm not at this point sure of where I think it should go.
   We may want to consider splitting it up; some of it appears to be
   suitable for the driver API manual, while some of it might be best in
   the admin guide.  And some probably doesn't fit either.  I'll try to
   ponder on this a bit more.

 - It would be a good idea to add SPDX tags to the files while you're
   working through them.

Thanks,

jon

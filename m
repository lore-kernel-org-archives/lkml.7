Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47373C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C0B120862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfEOQ4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 12:56:50 -0400
Received: from ms.lwn.net ([45.79.88.28]:51964 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbfEOQ4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 12:56:50 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 971E6316;
        Wed, 15 May 2019 16:56:49 +0000 (UTC)
Date:   Wed, 15 May 2019 10:56:48 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     "Thomas Hellstrom" <thellstrom@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "minyard@acm.org" <minyard@acm.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Tobin C. Harding" <tobin@kernel.org>
Subject: [TRIVIA] Re: [PATCH] docs: Move kref.txt to core-api/kref.rst
Message-ID: <20190515105648.61164eab@lwn.net>
In-Reply-To: <f48e76f7-6b95-4cf0-82af-424119bb2eb4@www.fastmail.com>
References: <20190510001747.8767-1-tobin@kernel.org>
        <a3db1384695bbaa051d93c18ac30175fb95165e3.camel@vmware.com>
        <f48e76f7-6b95-4cf0-82af-424119bb2eb4@www.fastmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 May 2019 16:45:45 -0400
"Tobin C. Harding" <me@tobin.cc> wrote:

> I read once that they used 72 characters on punch cards at times because
> the other 8 characters got mangled for some reason.

Those of use who worked in Fortran understand these things... columns
73-80 were ignored by the compiler.  The normal use was to put line
numbers in there to help recovery when you dropped your card deck on the
floor and had to unshuffle things.  A diagonal line drawn across the
top of deck helped a lot, but it was good to have verification for the
marginal cases.

Kids today just don't have any culture at all...:)

jon

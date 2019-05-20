Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636D3C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 18:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F362173C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 18:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbfETSXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 14:23:15 -0400
Received: from ms.lwn.net ([45.79.88.28]:35472 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbfETSXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 14:23:14 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B42CB2DC;
        Mon, 20 May 2019 18:23:13 +0000 (UTC)
Date:   Mon, 20 May 2019 12:23:12 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     Thomas Hellstrom <thellstrom@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "minyard@acm.org" <minyard@acm.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Tobin C. Harding" <tobin@kernel.org>
Subject: Re: [TRIVIA] Re: [PATCH] docs: Move kref.txt to core-api/kref.rst
Message-ID: <20190520122312.589f5c7a@lwn.net>
In-Reply-To: <20190516231949.GA5056@eros.localdomain>
References: <20190510001747.8767-1-tobin@kernel.org>
        <a3db1384695bbaa051d93c18ac30175fb95165e3.camel@vmware.com>
        <f48e76f7-6b95-4cf0-82af-424119bb2eb4@www.fastmail.com>
        <20190515105648.61164eab@lwn.net>
        <20190516231949.GA5056@eros.localdomain>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 May 2019 09:19:49 +1000
"Tobin C. Harding" <me@tobin.cc> wrote:

> I was just going through my editors init file and I see I have default
> column width for kernel RST files set to 75.  Did you tell me that some
> time Jon, I vaguely remember?

Don't think it was me, but who knows what I might have said way back
when...  75 doesn't seem outlandish, anyway.

jon

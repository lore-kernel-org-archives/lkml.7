Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8ADCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 20:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B7A721A4C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 20:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbfJXU5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 16:57:14 -0400
Received: from ms.lwn.net ([45.79.88.28]:43254 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727924AbfJXU5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 16:57:13 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 31C33536;
        Thu, 24 Oct 2019 20:57:13 +0000 (UTC)
Date:   Thu, 24 Oct 2019 14:57:12 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] docs/core-api: memory-allocation: remove uses of
 c:func:
Message-ID: <20191024145712.165556c1@lwn.net>
In-Reply-To: <1ddbd3045d6a989b32065c0bd5b3a3c0ef525953.camel@alliedtelesis.co.nz>
References: <20191024195016.11054-1-chris.packham@alliedtelesis.co.nz>
        <20191024195016.11054-3-chris.packham@alliedtelesis.co.nz>
        <20191024142902.6bd413f6@lwn.net>
        <1ddbd3045d6a989b32065c0bd5b3a3c0ef525953.camel@alliedtelesis.co.nz>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Oct 2019 20:51:23 +0000
Chris Packham <Chris.Packham@alliedtelesis.co.nz> wrote:

> When I do actually get a series that applies to docs-next it'll
> conflict with 59bb47985c1d ("mm, sl[aou]b: guarantee
> natural alignment for kmalloc(power-of-two)") in Linus's tree.

Alternatively, if I sync up to -rc4, does the problem go away?  I should
be able to explain that to Linus without too much trouble...

Thanks,

jon

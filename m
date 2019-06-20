Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65678C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 20:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49DB220652
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 20:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfFTUHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 16:07:51 -0400
Received: from ms.lwn.net ([45.79.88.28]:47574 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727108AbfFTUHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 16:07:49 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 945E5536;
        Thu, 20 Jun 2019 20:07:48 +0000 (UTC)
Date:   Thu, 20 Jun 2019 14:07:47 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        George Spelvin <lkml@sdf.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrey Abramov <st5pub@yandex.ru>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 3/6] lib: list_sort.c: add a blank line to avoid
 kernel-doc warnings
Message-ID: <20190620140747.67e600c1@lwn.net>
In-Reply-To: <019c38a60bdc87124e58f8acd541b484fc9893bb.1560883872.git.mchehab+samsung@kernel.org>
References: <a83ea390bc28784518fce772b4c961ea1c976f14.1560883872.git.mchehab+samsung@kernel.org>
        <019c38a60bdc87124e58f8acd541b484fc9893bb.1560883872.git.mchehab+samsung@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2019 15:51:19 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> In order for a list to be recognized as such, blank lines
> are required.
> 
> Solve those Sphinx warnings:
> 
> ./lib/list_sort.c:162: WARNING: Unexpected indentation.
> ./lib/list_sort.c:163: WARNING: Block quote ends without a blank line; unexpected unindent.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Applied, thanks.

jon

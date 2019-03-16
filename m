Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20519C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 03:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E65F6218D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 03:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfCPDtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 23:49:41 -0400
Received: from mx.sdf.org ([205.166.94.20]:60961 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbfCPDtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 23:49:41 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id x2G3nBMP014953
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO);
        Sat, 16 Mar 2019 03:49:12 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id x2G3n98Q022778;
        Sat, 16 Mar 2019 03:49:09 GMT
Date:   Sat, 16 Mar 2019 03:49:09 GMT
From:   George Spelvin <lkml@sdf.org>
Message-Id: <201903160349.x2G3n98Q022778@sdf.org>
To:     andriy.shevchenko@linux.intel.com, st5pub@yandex.ru
Subject: Re: [PATCH 4/5] lib/list_sort: Simplify and remove MAX_LIST_LENGTH_BITS
Cc:     akpm@linux-foundation.org, daniel.wagner@siemens.com,
        dchinner@redhat.com, don.mullis@gmail.com, geert@linux-m68k.org,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        lkml@sdf.org
In-Reply-To: <20190315195635.GI9224@smile.fi.intel.com>
References: <20190314091041.GU9224@smile.fi.intel.com>,
    <201903150433.x2F4X9oT024601@sdf.org>,
    <CAMuHMdVF6pQ_-vidvtAyacOHw8WsJp4esu7o7o9DoR_GLahnzA@mail.gmail.com>,
    <201903151023.x2FANDVY013031@sdf.org>,
    <CAMuHMdVgmb8eZ7bD+jye8DG7cQRywvVmwo_XNJ00f198pDcwxQ@mail.gmail.com>,
    <201903151659.x2FGxi3R012970@sdf.org>,
    <CAMuHMdV_Y8COyhExkf-rj1oC39iDyf3iPrN2FxH8tQnmpi6D3g@mail.gmail.com>,
    <23331552675987@myt2-66bcb87429e6.qloud-c.yandex.net>,
    <20190315190614.GH9224@smile.fi.intel.com>,
    <69031552677833@myt1-e20b74e6250c.qloud-c.yandex.net>,
    <20190315195635.GI9224@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Indeed, thanks to everyone who commented.  The extra conceptual
complexity and reduced readbility is Just Not Worth It.

v2 (and final, as far as I'm concerned) follows.

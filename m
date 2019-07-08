Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC24C606CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 20:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED911216F4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 20:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404919AbfGHUQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 16:16:11 -0400
Received: from ms.lwn.net ([45.79.88.28]:53336 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728764AbfGHUQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 16:16:10 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3517A2EF;
        Mon,  8 Jul 2019 20:16:10 +0000 (UTC)
Date:   Mon, 8 Jul 2019 14:16:09 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christian Brauner <christian@brauner.io>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] Documentation/filesystems: add binderfs
Message-ID: <20190708141609.7bbe9cfa@lwn.net>
In-Reply-To: <20190702175729.GF1729@bombadil.infradead.org>
References: <20190111134100.24095-1-christian@brauner.io>
        <20190114172401.018afb9c@lwn.net>
        <20190702175729.GF1729@bombadil.infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jul 2019 10:57:29 -0700
Matthew Wilcox <willy@infradead.org> wrote:

> I think you added it in the wrong place.
> 
> From 8167b80c950834da09a9204b6236f238197c197b Mon Sep 17 00:00:00 2001
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Date: Tue, 2 Jul 2019 13:54:38 -0400
> Subject: [PATCH] docs: Move binderfs to admin-guide
> 
> The documentation is more appropriate for the administrator than for
> the internal kernel API section it is currently in.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Fine...applied...

jon

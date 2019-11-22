Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52B2C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 17:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 873DE20714
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 17:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfKVRBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 12:01:30 -0500
Received: from ms.lwn.net ([45.79.88.28]:41316 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfKVRBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 12:01:30 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E857B6D9;
        Fri, 22 Nov 2019 17:01:29 +0000 (UTC)
Date:   Fri, 22 Nov 2019 10:01:29 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     will@kernel.org, paulmck@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/7] docs: Update ko_KR translations
Message-ID: <20191122100129.68febb2d@lwn.net>
In-Reply-To: <20191121234125.28032-1-sj38.park@gmail.com>
References: <20191121234125.28032-1-sj38.park@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Nov 2019 00:41:18 +0100
SeongJae Park <sj38.park@gmail.com> wrote:

> This patchset contains updates of Korean translation documents and a fix
> of original document.
> 
> First 4 patches update the Korean translation of memory-barriers.txt.
> Fifth patch fixes a broken section reference in the original
> memory-barriers.txt.
> 
> Sixth and seventh patches update the Korean translation of howto.rst.

I've applied the set, thanks.

jon

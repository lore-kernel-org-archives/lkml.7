Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D84C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 20:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FF382082C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 20:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbfFRUpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 16:45:12 -0400
Received: from ms.lwn.net ([45.79.88.28]:52308 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730341AbfFRUpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 16:45:12 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8B4672E5;
        Tue, 18 Jun 2019 20:45:11 +0000 (UTC)
Date:   Tue, 18 Jun 2019 14:45:10 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs/vm: hwpoison.rst: Fix quote formatting
Message-ID: <20190618144510.7493ab7d@lwn.net>
In-Reply-To: <1b60185d-1fb4-b8f0-c7c2-9fb50f550566@arm.com>
References: <20190618145605.21208-1-valentin.schneider@arm.com>
        <20190618093159.26352aed@lwn.net>
        <1b60185d-1fb4-b8f0-c7c2-9fb50f550566@arm.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2019 16:51:06 +0100
Valentin Schneider <valentin.schneider@arm.com> wrote:

> I'm afraid this was only a "drive-by" patch, as I just happened to skim
> through this page on my phone while waiting for a meeting - I'm quite
> clueless about page poisoning.

No worries.  Thanks for the patch; it makes things better than they were
before, and I can't complain about that!

jon

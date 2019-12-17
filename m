Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3CAC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 06:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 273D6206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 06:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfLQGnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 01:43:09 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:35018 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbfLQGnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 01:43:08 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 4E1DA20074B;
        Tue, 17 Dec 2019 06:43:06 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 488A120AFD; Tue, 17 Dec 2019 07:38:46 +0100 (CET)
Date:   Tue, 17 Dec 2019 07:38:46 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org, rafael@kernel.org,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH 3/3] init: use do_mount() instead of ksys_mount()
Message-ID: <20191217063846.GA3247@light.dominikbrodowski.net>
References: <20191212135724.331342-4-linux@dominikbrodowski.net>
 <20191216211228.153485-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216211228.153485-1-ndesaulniers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 01:12:28PM -0800, Nick Desaulniers wrote:
> Shouldn't patches bake for a while in -next? (That way we catch regressions
> before they hit mainline?)
> 
> This lit up our CI this morning.
> 
> https://travis-ci.com/ClangBuiltLinux/continuous-integration/builds
> 
> (Apologies for missing context, replying via lore.kernel.org directions.)
> https://lore.kernel.org/lkml/20191212135724.331342-4-linux@dominikbrodowski.net/

A fix for this issue is already upstream, 7de7de7ca0ae .

Thanks,
	Dominik

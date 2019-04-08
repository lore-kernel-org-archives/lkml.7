Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EABCC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6B152084F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfDHVpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:45:45 -0400
Received: from ms.lwn.net ([45.79.88.28]:38156 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726517AbfDHVpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:45:45 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7CEF52CC;
        Mon,  8 Apr 2019 21:45:44 +0000 (UTC)
Date:   Mon, 8 Apr 2019 15:45:43 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] kernel-doc: Revert "scripts/kernel-doc: Processing
 -nofunc for functions only"
Message-ID: <20190408154543.7c0ac253@lwn.net>
In-Reply-To: <20190405214453.18768-2-sean.j.christopherson@intel.com>
References: <20190405214453.18768-1-sean.j.christopherson@intel.com>
        <20190405214453.18768-2-sean.j.christopherson@intel.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  5 Apr 2019 14:44:50 -0700
Sean Christopherson <sean.j.christopherson@intel.com> wrote:

> Now that Docbook has been deprecated in favor of Sphinx, the -nofunction
> option in kernel-doc is defunct, e.g. Sphinx doesn't currently support
> it.  Furthermore, "functions only" behavior was used by Docproc to avoid
> duplicating exported symbols, which is now handled by -export and
> -internal.
> 
> The end goal is to enable using :nofunction: in .rst files to split
> documentation of structures into separate categories.
> 
> This reverts commit 23aebb3c05f3b3fb06a68bf6b1539a05a5f8aaab.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>

It seems strange to express this as a revert - it's far from a clean
revert of the original patch.  I think it's probably better to just merge
this series into a single patch that implements the functionality you're
after.

As for the single/plural question, let's go with singular to match
--function.

Thanks,

jon

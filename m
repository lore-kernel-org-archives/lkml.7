Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E56C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 16:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C85206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 16:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfGBQLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 12:11:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:41488 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725922AbfGBQLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 12:11:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C9DABB023;
        Tue,  2 Jul 2019 16:11:36 +0000 (UTC)
Date:   Tue, 2 Jul 2019 09:11:30 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Michel Lespinasse <walken@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] augmented rbtree: add comments for
 RB_DECLARE_CALLBACKS macro
Message-ID: <20190702161130.7uu4yk3rzqiyfbab@linux-r8p5>
References: <20190702075819.34787-1-walken@google.com>
 <20190702075819.34787-2-walken@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190702075819.34787-2-walken@google.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Jul 2019, Michel Lespinasse wrote:

>Add a short comment summarizing the arguments to RB_DECLARE_CALLBACKS.
>The arguments are also now capitalized. This copies the style of the
>INTERVAL_TREE_DEFINE macro.
>
>No functional changes in this commit, only comments and capitalization.
>
>Signed-off-by: Michel Lespinasse <walken@google.com>

Acked-by: Davidlohr Bueso <dbueso@suse.de>

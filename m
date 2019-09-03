Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CDBC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC4622CF8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbfICLRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 07:17:17 -0400
Received: from nautica.notk.org ([91.121.71.147]:57090 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727667AbfICLRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 07:17:17 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id B341BC01B; Tue,  3 Sep 2019 13:17:15 +0200 (CEST)
Date:   Tue, 3 Sep 2019 13:17:00 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Bharath Vedartham <linux.bhar@gmail.com>
Cc:     ericvh@gmail.com, lucho@ionkov.net,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 9p/vfs_super.c: Remove unused parameter data in
 v9fs_fill_super
Message-ID: <20190903111700.GA32644@nautica>
References: <20190523165619.GA4209@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190523165619.GA4209@bharath12345-Inspiron-5559>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bharath Vedartham wrote on Thu, May 23, 2019:
> v9fs_fill_super has a param 'void *data' which is unused in the
> function.
> 
> This patch removes the 'void *data' param in v9fs_fill_super and changes
> the parameters in all function calls of v9fs_fill_super.
> 
> Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>

I just realized I had never replied to this patch - queued it today, as
well as the other you had sent around the same period.

Sorry for the delay, and thanks for sending patches - I don't
particularily care for cleanup like this one but it's always good to
take.

-- 
Dominique

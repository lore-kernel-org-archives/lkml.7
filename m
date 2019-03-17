Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208A0C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 23:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71A520854
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 23:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfCQXt6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 19:49:58 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:36566 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbfCQXt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 19:49:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 6F29460F6D9D;
        Mon, 18 Mar 2019 00:49:55 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id FhSxPuLmJ_6D; Mon, 18 Mar 2019 00:49:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 1108660F6D9F;
        Mon, 18 Mar 2019 00:49:55 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hbuX3O0PXK3d; Mon, 18 Mar 2019 00:49:54 +0100 (CET)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id A074160F6D9D;
        Mon, 18 Mar 2019 00:49:54 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Colin King <colin.king@canonical.com>
Cc:     Jeff Dike <jdike@addtoit.com>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hostfs: fix mismatch between link_file definition and declaration
Date:   Mon, 18 Mar 2019 00:49:53 +0100
Message-ID: <1760676.zAVrM27zAz@blindfold>
In-Reply-To: <20190317230909.7373-1-colin.king@canonical.com>
References: <20190317230909.7373-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 18. März 2019, 00:09:09 CET schrieb Colin King:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The function link_file declaration in the header file has the order
> of the two arguments (from, to) swapped when compared to the definition
> arguments of (to, from).  Fix this by swapping them around to match
> the definition.
> 
> This error predates the git history, so no idea when this error
> was introduced.

commit bf4f804738544a95b8bc8d6a7e2629c3fc0240dd
Author: jdike <jdike>
Date:   Sat Dec 9 22:52:44 2000 +0000

    hostfs now mostly works.  Almost all of the common operations are now
    implemented, the main exceptions being mknod and executing files from
    a hostfs filesystem.

Enough archaeology for today. :-)

Thanks,
//richard



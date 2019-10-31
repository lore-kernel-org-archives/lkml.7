Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA40CA9EC7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 01:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5392920862
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 01:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572484867;
	bh=TpbLYvw5k9v7RgUc6u2ZsQ/ZK12i/LjMSg0yFJ5O2CA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=dRsnoOTbRQStvNta8odQkBib9YDicX/fkP4MHPiMB/4pVi7e07sWYaduPrF2R+y2W
	 yQrzk1WtBqxaP7Xfm4FUBbynsXL/gkTYc96BnS0YWuvYo0KYe+BFZKfFdEbo+7gJ7A
	 RflEXkT9C9pDRtvALl0FZZqX+EG2azz9UFqDN3iI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfJaBVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 21:21:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbfJaBVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 21:21:06 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3B6020862;
        Thu, 31 Oct 2019 01:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572484865;
        bh=TpbLYvw5k9v7RgUc6u2ZsQ/ZK12i/LjMSg0yFJ5O2CA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BgtZm25B7y8dU6T/ihxtOtLEKskMyq0k5fHpbne7eSiuAAa995qcxNrNtfO9PDeTm
         9FR7BmMCq9pCQ688EEEOxDa2/cE3O3Y0aGd3uRinPxLlgM2Z++s1hEopMdWxi/87+q
         HYTOml3aT0YmScG2JId68rB7zVw9GWFaEJ+Pf5VM=
Date:   Wed, 30 Oct 2019 18:21:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] MAINTAINERS: update information for "MEMORY MANAGEMENT"
Message-Id: <20191030182104.13847e8563105be6cd0a9dfe@linux-foundation.org>
In-Reply-To: <20191030202217.3498133-1-songliubraving@fb.com>
References: <20191030202217.3498133-1-songliubraving@fb.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Oct 2019 13:22:17 -0700 Song Liu <songliubraving@fb.com> wrote:

> I was trying to find the mm tree in MAINTAINERS by searching "Morton".
> Unfortunately, I didn't find one. And I didn't even locate the MEMORY
> MANAGEMENT section quickly, because Andrew's name was not listed there.
> 
> Thanks to Johannes who helped me find the mm tree.

Oh all right ;)

If I listed everything I "maintain" in MAINTAINERS, I'd double the size
of the dang thing.

q:/usr/src/25> grep "^#NEXT_PATCHES_START" series | wc -l
364

(Those are the identifiable "trees" which I do (or did) "maintain").

But mm/ is special.

> Let save other's time searching around by adding:
> 
> M:	Andrew Morton <akpm@linux-foundation.org>
> T:	git git://github.com/hnaz/linux-mm.git

Also:

--- a/MAINTAINERS~maintainers-update-information-for-memory-management-fix
+++ a/MAINTAINERS
@@ -10523,6 +10523,8 @@ M:	Andrew Morton <akpm@linux-foundation.
 L:	linux-mm@kvack.org
 W:	http://www.linux-mm.org
 T:	git git://github.com/hnaz/linux-mm.git
+T:	quilt https://ozlabs.org/~akpm/mmotm/
+T:	quilt https://ozlabs.org/~akpm/mmots/
 S:	Maintained
 F:	include/linux/mm.h
 F:	include/linux/gfp.h
_


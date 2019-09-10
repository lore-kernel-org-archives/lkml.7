Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24808C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A5820872
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393813AbfIJKcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 06:32:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:33772 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726869AbfIJKck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 06:32:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D1B74ABED;
        Tue, 10 Sep 2019 10:32:39 +0000 (UTC)
Date:   Tue, 10 Sep 2019 12:32:37 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     n-horiguchi@ah.jp.nec.com
Cc:     mhocko@kernel.org, mike.kravetz@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] Hwpoison soft-offline rework
Message-ID: <20190910103233.GA14370@linux>
References: <20190910103016.14290-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910103016.14290-1-osalvador@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 12:30:06PM +0200, Oscar Salvador wrote:
> 
> This patchset was based on Naoya's hwpoison rework [1], so thanks to him
> for the initial work.
> 
> This patchset aims to fix some issues laying in soft-offline handling,
> but it also takes the chance and takes some further steps to perform 
> cleanups and some refactoring as well.

Of course, this was meant to be a "RFC PATCH" and not a "PATCH", but
fat-fingers...

Sorry for the inconvenience.

-- 
Oscar Salvador
SUSE L3

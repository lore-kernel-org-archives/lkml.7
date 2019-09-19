Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD090C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 12:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F81121929
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 12:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390133AbfISMHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 08:07:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:59678 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388712AbfISMHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 08:07:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AD906AB9B;
        Thu, 19 Sep 2019 12:07:22 +0000 (UTC)
Date:   Thu, 19 Sep 2019 05:07:03 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        David Bolvansky <david.bolvansky@gmail.com>
Subject: Re: [PATCH] hugetlbfs: hugetlb_fault_mutex_hash cleanup
Message-ID: <20190919120703.ixuv2itnui5ofhhr@linux-p48b>
Mail-Followup-To: Mike Kravetz <mike.kravetz@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        David Bolvansky <david.bolvansky@gmail.com>
References: <20190919011847.18400-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190919011847.18400-1-mike.kravetz@oracle.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Sep 2019, Mike Kravetz wrote:

>A new clang diagnostic (-Wsizeof-array-div) warns about the calculation
>to determine the number of u32's in an array of unsigned longs. Suppress
>warning by adding parentheses.
>
>While looking at the above issue, noticed that the 'address' parameter
>to hugetlb_fault_mutex_hash is no longer used. So, remove it from the
>definition and all callers.
>
>No functional change.
>
>Reported-by: Nathan Chancellor <natechancellor@gmail.com>
>Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Reviewed-by: Davidlohr Bueso <dbueso@suse.de>

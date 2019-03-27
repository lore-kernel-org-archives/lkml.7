Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D361C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 07:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72BD8206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 07:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732110AbfC0HDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 03:03:41 -0400
Received: from mx2.cyber.ee ([193.40.6.72]:33170 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbfC0HDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 03:03:40 -0400
Subject: Re: CONFIG_DEBUG_VIRTUAL breaks boot on x86-32
To:     Ralph Campbell <rcampbell@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
References: <4d5ee3b0-6d47-a8df-a6b3-54b0fba66ed7@linux.ee>
 <A1B7F481-4BF6-4441-8019-AE088F8A8939@oracle.com>
 <f39477da-a1ef-e31e-a72d-8ea1d5755234@nvidia.com>
From:   Meelis Roos <mroos@linux.ee>
Message-ID: <dca61136-db66-a89e-e79d-679ee2281d8d@linux.ee>
Date:   Wed, 27 Mar 2019 09:03:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <f39477da-a1ef-e31e-a72d-8ea1d5755234@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: et-EE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> You might be hitting a bug I found.
> Try applying this patch:
> https://marc.info/?l=linux-kernel&m=155355953012985&w=2

Unfortunately it did not change anything.

-- 
Meelis Roos <mroos@linux.ee>

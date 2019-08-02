Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DF3C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 03:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83124206A2
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 03:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730264AbfHBDhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 23:37:17 -0400
Received: from foss.arm.com ([217.140.110.172]:44004 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbfHBDhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 23:37:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2A7C1570;
        Thu,  1 Aug 2019 20:37:15 -0700 (PDT)
Received: from [10.163.1.81] (unknown [10.163.1.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EFD503F71F;
        Thu,  1 Aug 2019 20:37:13 -0700 (PDT)
Subject: Re: [PATCH] mm/madvise: reduce code duplication in error handling
 paths
To:     Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1564640896-1210-1-git-send-email-rppt@linux.ibm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <aeb49e1a-5a21-57bb-04b8-6439620d12eb@arm.com>
Date:   Fri, 2 Aug 2019 09:07:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1564640896-1210-1-git-send-email-rppt@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/01/2019 11:58 AM, Mike Rapoport wrote:
> The madvise_behavior() function converts -ENOMEM to -EAGAIN in several
> places using identical code.
> 
> Move that code to a common error handling path.
> 
> No functional changes.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

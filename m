Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88674C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 14:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63F182146E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 14:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437495AbfIYOcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 10:32:13 -0400
Received: from foss.arm.com ([217.140.110.172]:50982 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437142AbfIYOcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 10:32:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C507728;
        Wed, 25 Sep 2019 07:32:12 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FB9E3F59C;
        Wed, 25 Sep 2019 07:32:12 -0700 (PDT)
Date:   Wed, 25 Sep 2019 15:32:10 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jeremy Cline <jcline@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: kmemleak: DEBUG_KMEMLEAK_EARLY_LOG_SIZE changed
 names
Message-ID: <20190925143209.GE7042@arrakis.emea.arm.com>
References: <20190925143114.19698-1-jcline@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925143114.19698-1-jcline@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 02:31:14PM +0000, Jeremy Cline wrote:
> Commit c5665868183f ("mm: kmemleak: use the memory pool for early
> allocations") renamed CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE to
> CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE. Update the documentation reference
> to reflect that.
> 
> Signed-off-by: Jeremy Cline <jcline@redhat.com>

I forgot about this. Thanks.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

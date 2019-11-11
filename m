Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CF6C17445
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB07214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKKSZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:25:58 -0500
Received: from foss.arm.com ([217.140.110.172]:49022 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbfKKSZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:25:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E2421FB;
        Mon, 11 Nov 2019 10:25:57 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B31A3F534;
        Mon, 11 Nov 2019 10:25:56 -0800 (PST)
Date:   Mon, 11 Nov 2019 18:25:54 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH][next] kselftest: arm64: fix spelling mistake "contiguos"
 -> "contiguous"
Message-ID: <20191111182553.GB60539@arrakis.emea.arm.com>
References: <20191111091236.37165-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111091236.37165-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 09:12:36AM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in an error message literal string. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Queued for 5.5. Thanks.

-- 
Catalin

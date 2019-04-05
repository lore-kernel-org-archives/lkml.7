Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A64DC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE98521871
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731183AbfDEOQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:16:56 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50174 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731016AbfDEOQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 10:16:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3A0A16A3;
        Fri,  5 Apr 2019 07:16:55 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B67E83F68F;
        Fri,  5 Apr 2019 07:16:54 -0700 (PDT)
Date:   Fri, 5 Apr 2019 15:16:49 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     gregkh@linuxfoundation.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4.9/4.14 BACKPORT 1/2] arm64: debug: Don't propagate
 UNKNOWN FAR into si_code for debug signals
Message-ID: <20190405141649.GA7313@fuggles.cambridge.arm.com>
References: <20190403103326.29161-1-will.deacon@arm.com>
 <20190405141522.584C621850@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405141522.584C621850@mail.kernel.org>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 02:15:21PM +0000, Sasha Levin wrote:
> Hi,
> 
> [This is an automated email]
> 
> This commit has been processed because it contains a -stable tag.
> The stable tag indicates that it's relevant for the following trees: 4.14.+
> 
> The bot has tested the following trees: v5.0.6, v4.19.33, v4.14.110.
> 
> v4.19.33: Failed to apply! Possible dependencies:
>     Unable to calculate
> 
> v4.14.110: Build OK!
> 
> How should we proceed with this patch?

I did separate backports for the various stable trees, and annotated them
all accordingly in the subject and the @stable line. I think Greg has
already taken care of them.

Will

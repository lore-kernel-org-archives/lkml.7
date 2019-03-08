Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F24C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 23:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF6820684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 23:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfCHXZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 18:25:11 -0500
Received: from trent.utfs.org ([94.185.90.103]:42166 "EHLO trent.utfs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbfCHXZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 18:25:11 -0500
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id 8832560AD4;
        Sat,  9 Mar 2019 00:25:09 +0100 (CET)
Date:   Fri, 8 Mar 2019 15:25:09 -0800 (PST)
From:   Christian Kujau <lists@nerdbynature.de>
To:     David Howells <dhowells@redhat.com>
cc:     linux-kernel@vger.kernel.org,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve Dickson <steved@redhat.com>
Subject: Re: FS-Cache: Duplicate cookie detected
In-Reply-To: <alpine.DEB.2.21.999.1903081506320.21644@trent.utfs.org>
Message-ID: <alpine.DEB.2.21.999.1903081522160.21644@trent.utfs.org>
References: <alpine.DEB.2.21.999.1903060943320.1662@trent.utfs.org> <22096.1551878195@warthog.procyon.org.uk> <alpine.DEB.2.21.999.1903051616350.4505@trent.utfs.org> <10106.1551892803@warthog.procyon.org.uk> <17155.1552056554@warthog.procyon.org.uk>
 <alpine.DEB.2.21.999.1903081506320.21644@trent.utfs.org>
User-Agent: Alpine 2.21.999 (DEB 277 2018-05-20)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Mar 2019, Christian Kujau wrote:
> Running Linux v5.0 with this patch applied does indeed still produce the 
> "Duplicate cookie detected" messages, but I only ever see wrq=0 when 
> running nfstest_cache: 
> 
>    https://paste.fedoraproject.org/paste/dkav0FQzYZxE9-V7GphjAQ

And again with the whole /proc/fs/fscache/stats output and better time 
stamps: https://paste.fedoraproject.org/paste/hZtCPStJlqB1d9JXnTFndQ

C
-- 
BOFH excuse #5:

static from plastic slide rules

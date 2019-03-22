Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC16CC10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CA3F2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="Nd4IJAJX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbfCVRiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 13:38:51 -0400
Received: from a9-30.smtp-out.amazonses.com ([54.240.9.30]:49122 "EHLO
        a9-30.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725981AbfCVRiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 13:38:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1553276329;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=t1z9bclqYJz9qIJ/zfgRXzGl2XelZgLxHQlIn9FSkNM=;
        b=Nd4IJAJXLmYk98fCzo8idP6HAyo4V4hZpf6qrUB0y5mgA//XLNG/C1SpCJ5k5fpk
        UTWPhHNWCFD7X0vLD48rO9PKd6v/AvtPotP49TaJygzPMJISJOyDeaYvUpAY8sfSb5g
        pFlBaeftFulOATvkj9nCpD2xZB3ZpX2XxZ1qY69s=
Date:   Fri, 22 Mar 2019 17:38:49 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Li RongQing <lirongqing@baidu.com>
cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH] mm, slab: remove unneed check in cpuup_canceled
In-Reply-To: <1553159353-5056-1-git-send-email-lirongqing@baidu.com>
Message-ID: <01000169a67bdd50-bf4ef6a0-c4f5-4156-b458-41885eac10ac-000000@email.amazonses.com>
References: <1553159353-5056-1-git-send-email-lirongqing@baidu.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.03.22-54.240.9.30
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019, Li RongQing wrote:

> nc is a member of percpu allocation memory, and impossible NULL

Acked-by: Christoph Lameter <cl@linux.com>

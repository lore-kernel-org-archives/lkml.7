Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C0FC76190
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B06218BE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390074AbfGWNOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 09:14:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:57250 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727311AbfGWNOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 09:14:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C11D4AC47;
        Tue, 23 Jul 2019 13:14:13 +0000 (UTC)
Date:   Tue, 23 Jul 2019 15:14:10 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Weitao Hou <houweitaoo@gmail.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, david@redhat.com,
        pasha.tatashin@soleen.com, dan.j.williams@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hotplug: remove unneeded return for void function
Message-ID: <20190723131401.GA24690@linux>
References: <20190723130814.21826-1-houweitaoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723130814.21826-1-houweitaoo@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 09:08:14PM +0800, Weitao Hou wrote:
> return is unneeded in void function
> 
> Signed-off-by: Weitao Hou <houweitaoo@gmail.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/memory_hotplug.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 2a9bbddb0e55..c73f09913165 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -132,7 +132,6 @@ static void release_memory_resource(struct resource *res)
>  		return;
>  	release_resource(res);
>  	kfree(res);
> -	return;
>  }
>  
>  #ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
> @@ -979,7 +978,6 @@ static void rollback_node_hotadd(int nid)
>  	arch_refresh_nodedata(nid, NULL);
>  	free_percpu(pgdat->per_cpu_nodestats);
>  	arch_free_nodedata(pgdat);
> -	return;
>  }
>  
>  
> -- 
> 2.18.0
> 

-- 
Oscar Salvador
SUSE L3

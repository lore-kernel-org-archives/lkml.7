Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BE5C2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 16:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC01206D3
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 16:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PkZ58eBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfLXQCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 11:02:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53708 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfLXQCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 11:02:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YWsnGUwLQy1fCYTio28U1e+bq8tf4RG5vs287No2BFM=; b=PkZ58eBfvTMs20Ry90HGKCaK6
        7GZhLXrPI98LJexGwE+IWpuQ59dSkj+2WA0jtTs/GmaY43DdahfyVZZNB363nP42snR+4YLfIL41T
        eowZCtbx9U9z4mAxE2fpBUaceagbT88h/9pg3V4hA6H0ENo4VkUapJR4ZOxsmy5OAkaHP0nkt/rGO
        AFt9LQgUsUQWiWtjqCBHYVsFgl0gXPEk9T4OxK+lGe7DlK1l9EDQMyPpJ4uX4ZNSX5d0T5s/q7u5a
        czEw/on/8D+MZt89C68JnOj7CxbMN/Hp4rTQlwA0EL7tpFybB6HrccVl+a9MhJen7Pq/2366kyBR4
        YCl4irOdQ==;
Received: from [2601:1c0:6280:3f0::fee9]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ijmdv-0007Iu-Ly; Tue, 24 Dec 2019 16:02:43 +0000
Subject: Re: [RFC PATCH] riscv: Add numa support for riscv64 platform
To:     Greentime Hu <greentime.hu@sifive.com>, green.hu@gmail.com,
        greentime@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20191224085544.24960-1-greentime.hu@sifive.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5762c1c1-4078-0647-27fe-6d28f6bc8e9a@infradead.org>
Date:   Tue, 24 Dec 2019 08:02:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191224085544.24960-1-greentime.hu@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/24/19 12:55 AM, Greentime Hu wrote:
> +# Common NUMA Features
> +config NUMA
> +	bool "Numa Memory Allocation and Scheduler Support"
> +	select OF_NUMA
> +	select ARCH_SUPPORTS_NUMA_BALANCING
> +	depends on SPARSEMEM
> +	help
> +	  Enable NUMA (Non Uniform Memory Access) support.

	              (Non-Uniform Memory Access)
please.

> +
> +	  The kernel will try to allocate memory used by a CPU on the
> +	  local memory of the CPU and add some more
> +	  NUMA awareness to the kernel.
> +


-- 
~Randy


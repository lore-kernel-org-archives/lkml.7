Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532EAC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15DA920833
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555318901;
	bh=MHHZajSk8uT6yldJQkSiq9LxrQHV9ROHoiXn0vbGx9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=n9bGhX5ApUF3S7Qq6gDAh1MKTE+cah4JdQWd5WDsKWCx0EEPy1p2bM/l7yZrDTJ3B
	 ig5VNEDC/f2UBHP+liS4wqQwek4IUWVkGDeeSrq/qg28iD/jPFIUrv/f99MjdZzzcv
	 vkCRAbKfgB6Xxfcsh27z0l07131XuCWmAhTAK+aE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfDOJBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:01:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfDOJBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 05:01:39 -0400
Received: from guoren-Inspiron-7460 (23.83.240.247.16clouds.com [23.83.240.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 047D420693;
        Mon, 15 Apr 2019 09:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555318898;
        bh=MHHZajSk8uT6yldJQkSiq9LxrQHV9ROHoiXn0vbGx9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hoPbBKneFz9iPr/wTkE0+6kwQ+AVD0cOlbjJOq0alNypIpeRD1YuADOU3t2k90413
         YQMGIMcRm8C+jXZGYoZ5cvTnpKwUy3GyyamsABsVtpq5JEqCsludzISBpXL50pJG+A
         7vncjRsQ3+6Q1voTfBqZUakVSHTrsqKOy8o13wsE=
Date:   Mon, 15 Apr 2019 17:01:04 +0800
From:   Guo Ren <guoren@kernel.org>
To:     Mao Han <han_mao@c-sky.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] csky: Add support for perf registers sampling
Message-ID: <20190415090104.GA10228@guoren-Inspiron-7460>
References: <cover.1554967684.git.han_mao@c-sky.com>
 <c1d58e5813ac45b30b29f3b67f9856fd32c8b42d.1554967684.git.han_mao@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1d58e5813ac45b30b29f3b67f9856fd32c8b42d.1554967684.git.han_mao@c-sky.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mao,

Sorry, currect:

On Thu, Apr 11, 2019 at 03:45:00PM +0800, Mao Han wrote:
> This patch implements the perf registers sampling and validation API
> for csky arch. The valid registers and their register ID are defined in
> perf_regs.h. Perf tool can backtrace in userspace with unwind library
> and the registers/user stack dump support.

> +	return ((long *)regs)[idx];
	return (u64)*((u32 *)regs + idx);

Best Regards
 Guo Ren

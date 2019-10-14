Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D49ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 07:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 598522089C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 07:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571039583;
	bh=QHjVMx2um2+V2UHQD2kPzkU41tloylm/urAONlN+rKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NLjmdJAgovkmLpS79KA1WVNcoDOJ8rPyb83d/uSfWYXyBoEouPNcQyA5hqRLDCnCQ
	 SrQeadckKWkzmFM6XO5U1fKnPYygfJyUXi2gdnQtHzZRyiEwui73GeGi30t6cLGYFL
	 SuNb0dSg/bfaB+FQtUt4KvVYX8O0DTj74GkqwaDg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730387AbfJNHxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 03:53:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:43232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730065AbfJNHxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 03:53:01 -0400
Received: from localhost (unknown [122.167.124.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DA0F20854;
        Mon, 14 Oct 2019 07:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571039581;
        bh=QHjVMx2um2+V2UHQD2kPzkU41tloylm/urAONlN+rKs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rw7OZ+RR/9eokb8BCU2ZpFQoR27VjP9XImVQUg71zdRYQ/8wGB6vJjNGX90FFvRv1
         2CE8qcI9nvfN6U1l+WrU34P3MO3iL8nBn0JOEQNIlsVNgWwH1uNiG4h9Bva4hX7uyP
         D+pKzM1rJ/3JJRnlhIjpdJk4mzY0+a6Qw7yCLLZI=
Date:   Mon, 14 Oct 2019 13:22:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Alex Smith <alex.smith@imgtec.com>
Subject: Re: [PATCH] dmaengine: jz4780: Use devm_platform_ioremap_resource()
 in jz4780_dma_probe()
Message-ID: <20191014075257.GI2654@vkoul-mobl>
References: <5dd19f28-349a-4957-ea3a-6aebbd7c97e2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dd19f28-349a-4957-ea3a-6aebbd7c97e2@web.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-09-19, 11:25, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 22 Sep 2019 11:18:27 +0200
> 
> Simplify this function implementation a bit by using
> a known wrapper function.
> 
> This issue was detected by using the Coccinelle software.

Applied, thanks

-- 
~Vinod

Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDAEC2D0D4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 07:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB23120709
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 07:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577086999;
	bh=KJEPHrjo3IgJEL5dK6b/sVo8088uqNTjG1eAtaxoMVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Vo3cm3mTEi3ehxaKHkP3uhslWdFPCjusi8oHDds5SsHOpRNcvKcds9IsGTxr4LrUR
	 bQdWt0epC0trwOxoUprs+vnwxyFnRWxMu8Tnq7MWuPLWInxJN49AWqunY2o0ZsTaUC
	 wz3Cxv8NOsLqx7U2HPFs7r8Zn45VWUR3hSmYGnGc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbfLWHnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 02:43:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:53628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbfLWHnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 02:43:18 -0500
Received: from localhost (unknown [223.226.34.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F848206CB;
        Mon, 23 Dec 2019 07:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577086998;
        bh=KJEPHrjo3IgJEL5dK6b/sVo8088uqNTjG1eAtaxoMVA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TpSoWCVv2sM7iiHmW88m4qBrqTEPcxnHv3Cl8oPfm/OsbAThcfB25xvB0d5cmMyM8
         ISqHnk2h6ive+3jgUPMhGxpJJEl/iZ59IYeP/UDzLewqaOTHi9yaw5IhhVwNQI6pbr
         YSH472q+KzFVUuzM/BhOzVjYLcUiRfo7jVZGl0XM=
Date:   Mon, 23 Dec 2019 13:13:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     =?utf-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, paul.burton@mips.com, paulburton@kernel.org,
        mark.rutland@arm.com, paul@crapouillou.net,
        Zubair.Kakakhel@imgtec.com, dan.j.williams@intel.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com, 2374286503@qq.com
Subject: Re: Add dmaengine driver for X1830.
Message-ID: <20191223074313.GW2536@vkoul-mobl>
References: <1576591140-125668-1-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1576591140-125668-1-git-send-email-zhouyanjie@wanyeetech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-12-19, 21:58, 周琰杰 (Zhou Yanjie) wrote:
> 1.Modify the documentation description to make it more relevant.
> 2.Add the dmaengine bindings for the X1830 SoC from Ingenic.
> 3.Add support for probing the dma-jz4780 driver on the
>   X1830 SoC from Ingenic.
> Notice:
> The X1830's dma controller is very similar to the X1000, the
> difference is that the X1830 has 32 dma channels and the
> X1000 has only 8.

Applied, thanks

-- 
~Vinod

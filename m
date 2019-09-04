Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6F3C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 09:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD80323400
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 09:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567588740;
	bh=7PzKPrjPE7DWvXFVkG19p3ZhwppOun+obg1xPknZeh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l4zF48HOFUk4J/SlIL+YtfpeNdUtJVOP7wwgt0JsP9EpiSuYCgUPJZr44MGY1MF43
	 3HtjYrXXLRUifP9+2FAjqsEHisbhzx46rF/tZMzcYnNwFonZDAj6bgxFVxj9t502aS
	 Qk1FIwkMXsnxCgV2yztrd+R0UIyRvjWL/azLGqa4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbfIDJS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 05:18:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:46964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbfIDJS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 05:18:59 -0400
Received: from localhost (unknown [122.182.201.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B36ED2339E;
        Wed,  4 Sep 2019 09:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567588738;
        bh=7PzKPrjPE7DWvXFVkG19p3ZhwppOun+obg1xPknZeh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XIMGFJYN/c9Priq9kIntyPSDcG6WH4kUNT+46l6saWjhvSQyj/f5ZrvDO+0Ho8LJ3
         h2K9O6cICd6NzEVdRklNKNI3k7N7gNJYbm0hMvbAAfsHsEjGRc8PlbtdLbnfDGvx+G
         PLp2KgWCosEkXpHb2A+T6NuLyvNsMauC6vNVoCLQ=
Date:   Wed, 4 Sep 2019 14:47:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, robh+dt@kernel.org, spapothi@codeaurora.org,
        bgoswami@codeaurora.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/4] dt-bindings: soundwire: add slave bindings
Message-ID: <20190904091749.GM2672@vkoul-mobl>
References: <20190829163514.11221-1-srinivas.kandagatla@linaro.org>
 <20190829163514.11221-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829163514.11221-2-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-08-19, 17:35, Srinivas Kandagatla wrote:
> This patch adds bindings for Soundwire Slave devices that includes how
> SoundWire enumeration address and Link ID are used to represented in
> SoundWire slave device tree nodes.

Applied, thanks

-- 
~Vinod

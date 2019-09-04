Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58730C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 09:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E54A22DBF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 09:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567589396;
	bh=LIkm5FpLzo7GENIhsHaqkcW3aq1BN9WvZBp7v01Fy4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fGrTemUIbNwNhpULygTQzleyKhtm/VXpsxQLf0ZL7tV/ANFu/gaNj+vRVAgaGzaQ9
	 NIvMY3ujNsvmfxEKQEK+jyDwfjK8x4lU9mfur4g2jcO3eH2hNqF7LbzRqhTii0myag
	 y/ZIcfQvk3ceQuK8pGBOWY/Y9Rnu/4orqdT4RxME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbfIDJ3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 05:29:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:51710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbfIDJ3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 05:29:55 -0400
Received: from localhost (unknown [122.182.201.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B067221670;
        Wed,  4 Sep 2019 09:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567589394;
        bh=LIkm5FpLzo7GENIhsHaqkcW3aq1BN9WvZBp7v01Fy4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hAWp3Ez6gu/1EvMpXe6ZL4nzwvs2kU3OOOkXJievFicOdGfK2FwG8VeMas/HL7PHX
         dgEqGxILrcb1IG5rdtj04zfjVwU67jq0mHGpoHO2AQe6aqWw2i9TpNMjMwy066oNdP
         T4B7La6Yk98mZiuIhAL/wwqLN2mk6cepiKeNwJdc=
Date:   Wed, 4 Sep 2019 14:58:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, bgoswami@codeaurora.org, plai@codeaurora.org,
        pierre-louis.bossart@linux.intel.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        spapothi@codeaurora.org
Subject: Re: [PATCH v2 1/5] soundwire: Add compute_params callback
Message-ID: <20190904092846.GO2672@vkoul-mobl>
References: <20190813083550.5877-1-srinivas.kandagatla@linaro.org>
 <20190813083550.5877-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813083550.5877-2-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-08-19, 09:35, Srinivas Kandagatla wrote:
> From: Vinod Koul <vkoul@kernel.org>
> 
> This callback allows masters to compute the bus parameters required.

Applied this to help manage cross dependencies with various folks better, thanks

-- 
~Vinod

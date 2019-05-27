Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DC7C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 05:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D27B2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 05:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558933486;
	bh=ZhaWRzbW4eDqGa/ywNz232vbX4q9/FJQELm4pI5OOJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E6KZ0ipU2izodbcss1CXtSvXU8QavJYtCQK5Ni6tcnZcRjTgaZnxWvwfZTygc2P3J
	 ERD6lrYbtwjdzcfFH/AnUdtRZjwUvG+czPOFOSnUWE/e/pVc7HD2UTVH1IiR1QCRZ+
	 JhcUs39ZkuyuAXXqwcOTAyKwrprmVw3bLGqssb6Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfE0FEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 01:04:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:57228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbfE0FEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 01:04:45 -0400
Received: from localhost (unknown [171.61.91.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACFA520657;
        Mon, 27 May 2019 05:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558933484;
        bh=ZhaWRzbW4eDqGa/ywNz232vbX4q9/FJQELm4pI5OOJM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lHKfQKhh+Q4udo9uLAkj+mtWghEYj0Rd5NYHRN96qmr1sU9gA7emY0jT/GxPLM+0u
         vgrGxi7zcx5sEoV0HxxG5IhZbgE0XEx/pxUCBhuCzGyWTR+JC+AJfi/T/mG5zngBYK
         paCwikr7D7b+3gwStpG6JdQY8Uhp1/ZkcS+FM5pw=
Date:   Mon, 27 May 2019 10:34:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     sanyog.r.kale@intel.com, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soundwire: stream: fix out of boundary access on port
 properties
Message-ID: <20190527050438.GY15118@vkoul-mobl>
References: <20190522162443.5780-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522162443.5780-1-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-05-19, 17:24, Srinivas Kandagatla wrote:
> Assigning local iterator to array element and using it again for
> indexing would cross the array boundary.
> Fix this by directly referring array element without using the local
> variable.

Applied, thanks

-- 
~Vinod

Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D18C04E87
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 13:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DA0721743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 13:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558446858;
	bh=mV50Au8ZG+x0O2R6KdtDn2lUTMG7xVfB1PQk8wR02NM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jCp+uIy4XiDfIygihs5fI0zqA1jN0zTc8FXjZiDU1ast7rmDSpku0LYAI97qUbtWW
	 r3hUux5Wep3Z2hWjjiXufB2L3tYNGwO/73U9M2sgAEww2KpkEJJUDvHcqfch5DCfWF
	 TcYmk8uwfhnODcJ6Sm1fRuea1jNDRhz1p+3yskRo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbfEUNyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 09:54:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727534AbfEUNyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 09:54:17 -0400
Received: from localhost (unknown [106.51.105.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D964521479;
        Tue, 21 May 2019 13:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558446856;
        bh=mV50Au8ZG+x0O2R6KdtDn2lUTMG7xVfB1PQk8wR02NM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PSukCtB0J22xf1jquuK8n4kzLvi0Hj8V8hPkzkazkhVxKC9Dsq7QuGcUVKwWzAhv0
         qgD9UlS7JoWOCTsY9fr2yX+7JOYE+FUqTOHCz+6oO8PoAjPQIXNxhqyVjRNxPKNgQZ
         AoeXfqD1YFAO3En1n+4oVVdwQC2wEKHo4VWc9h9E=
Date:   Tue, 21 May 2019 19:24:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     dan.j.williams@intel.com, eric.long@unisoc.com,
        orsonzhai@gmail.com, zhang.lyra@gmail.com,
        vincent.guittot@linaro.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Fix some bugs and add new feature for Spreadtrum
 DMA engine
Message-ID: <20190521135411.GM15118@vkoul-mobl>
References: <cover.1557127239.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1557127239.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-05-19, 15:28, Baolin Wang wrote:
> Hi,
> 
> This patch set fixes some DMA engine bugs and adds interrupt support
> for 2-stage transfer.

Applied all, thanks
-- 
~Vinod

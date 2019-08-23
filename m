Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3106DC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 06:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF8AE23406
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 06:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566542121;
	bh=DMmitDDTGgD/UdGy70jg4T3rwEFmQLlt0KobTblM/+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GsiJap0BqUfpSeJg6Z947FrIdGTO47/LdZKt8UNveWvyyeKiHXIyYOcRVdIBvVFWY
	 uBJ4AaABvUUGu42ba7CpIe7hoqrYnqIzgZsVpBdwXooDMiisCVX8hT+OEm39LAN/Zx
	 np+UMjAb8ONJR4/2X3+oJnIAmIUH/qBaGwzLCJRk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404576AbfHWGfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 02:35:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404002AbfHWGfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 02:35:19 -0400
Received: from localhost (unknown [106.200.210.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFB7D21019;
        Fri, 23 Aug 2019 06:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566542118;
        bh=DMmitDDTGgD/UdGy70jg4T3rwEFmQLlt0KobTblM/+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Khah2hsXR0jt4/Jcrb81KKVo0BMkwzc8dFki5XrR/QymWy8i0EmX0GkQvAEdb8NPB
         MDweCmOsDK4n8GVheQcfah0YFkQ9V8lNOG0hgbdrnu9usApbnhB01xOfDF5URjGCYJ
         1E1WyEuWbOGfrpRqVk8WnWykbRFJOKcuHaAMbHKw=
Date:   Fri, 23 Aug 2019 12:04:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [PATCH v3 0/4] soundwire: debugfs support for 5.4
Message-ID: <20190823063404.GB2672@vkoul-mobl>
References: <20190821185821.12690-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821185821.12690-1-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-08-19, 13:58, Pierre-Louis Bossart wrote:
> This patchset enables debugfs support and corrects all the feedback
> provided on an earlier RFC ('soundwire: updates for 5.4')
> 
> There is one remaining hard-coded value in intel.c that will need to
> be fixed in a follow-up patchset not specific to debugfs: we need to
> remove hard-coded Intel-specific configurations from cadence_master.c
> (PDI offsets, etc).

Applied all (i did hand edit of patch 4 to resolve dependency), thanks

-- 
~Vinod
